package main

import (
	"bytes"
	"encoding/json"
	"fmt"
	"html/template"
	"io/ioutil"
	"log"
	"net/http"
	"net/url"
	"os"
	"strings"
	"time"

	"github.com/aws/aws-lambda-go/lambda"
	"github.com/aws/aws-sdk-go/aws"
	"github.com/aws/aws-sdk-go/aws/session"
	"github.com/aws/aws-sdk-go/service/costexplorer"
)

type TimeHelper struct {
	Location *time.Location
	Now      time.Time
}

type Tmpl struct {
	Start string
	End   string
	Cost  string
	Unit  string
}

type Slack struct {
	Text       string `json:"text"`
	Username   string `json:"username"`
	Icon_emoji string `json:"icon_emoji"`
	Icon_url   string `json:"icon_url"`
}

var (
	accessToken     string
	accessPoint     *url.URL
	slackWebhookUrl string
	timeh           *TimeHelper
)

const tmplStr = `

{{.Start}} - {{.End}}
{{.Cost}} {{ .Unit }}
`

func init() {
	log.SetFlags(log.LstdFlags | log.Lshortfile)
	if accessToken = os.Getenv("AWS_COST_LINE_NOTIFY_TOKEN"); accessToken == "" {
		log.Fatalf("AWS_COST_LINE_NOTIFY_TOKEN is not defined")
	}
	if slackWebhookUrl = os.Getenv("SLACK_WEBHOOK_URL"); slackWebhookUrl == "" {
		log.Printf("SLACK_WEBHOOK_URL is not defined")
	}
	var err error
	accessPoint, err = url.ParseRequestURI("https://notify-api.line.me/api/notify")
	if err != nil {
		log.Fatal(err)
	}
	timeh, err = newTimeHelper("Asia/Tokyo")
	if err != nil {
		log.Fatal(err)
	}
}

func main() {
	lambda.Start(handler)
}

func handler() {
	cost, err := getCostDate()
	if err != nil {
		log.Fatal(err)
	}
	msg, err := getCostMessage(cost)
	if err != nil {
		log.Fatal(err)
	}
	cost, err = getCostMonth()
	if err != nil {
		log.Fatal(err)
	}
	nmsg, err := getCostMessage(cost)
	if err != nil {
		log.Fatal(err)
	}
	err = notifyToLine(msg + nmsg)
	if err != nil {
		log.Fatal(err)
	}
	if slackWebhookUrl != "" {
		err = notifyToSlack(msg + nmsg)
		if err != nil {
			log.Fatal(err)
		}
	}
}

func getCostMessage(cost *costexplorer.GetCostAndUsageOutput) (string, error) {
	var tmplArg Tmpl
	var tmplWriter bytes.Buffer
	data := cost.ResultsByTime[0]
	tmplArg.Start = *data.TimePeriod.Start
	tmplArg.End = *data.TimePeriod.End
	tmplArg.Cost = *data.Total["UnblendedCost"].Amount
	tmplArg.Unit = *data.Total["UnblendedCost"].Unit
	tmpl := template.Must(template.New("cost-notify").Parse(tmplStr))
	if err := tmpl.Execute(&tmplWriter, tmplArg); err != nil {
		return "", err
	}
	return tmplWriter.String(), nil
}

func getCostDate() (*costexplorer.GetCostAndUsageOutput, error) {
	return getCostPeriod("DAILY", timeh.GetYesterday(), timeh.Now.Format("2006-01-02"))
}

func getCostMonth() (*costexplorer.GetCostAndUsageOutput, error) {
	start := timeh.GetFirstOfMonth()
	end := timeh.Now.Format("2006-01-02")
	if start != end {
		return getCostPeriod("MONTHLY", start, end)
	} else {
		end = timeh.GetSecondOfMonth()
		return getCostPeriod("MONTHLY", start, end)
	}
}

func notifyToLine(message string) error {
	client := &http.Client{}
	form := url.Values{}
	form.Add("message", message)
	body := strings.NewReader(form.Encode())
	req, err := http.NewRequest("POST", accessPoint.String(), body)
	if err != nil {
		return err
	}
	req.Header.Set("Content-Type", "application/x-www-form-urlencoded")
	req.Header.Set("Authorization", "Bearer "+accessToken)
	_, err = client.Do(req)
	return err
}

func notifyToSlack(message string) error {
	params, err := json.Marshal(Slack{
		Text:     message,
		Username: "aws_cost_slack_notify",
	})
	if err != nil {
		fmt.Println("failed to json marshal slack" + fmt.Sprint(err))
		return err
	}
	res, err := http.PostForm(
		slackWebhookUrl,
		url.Values{"payload": {string(params)}},
	)
	if err != nil {
		fmt.Println("failed to http request, err:" + fmt.Sprint(err))
		return err
	}
	defer res.Body.Close()
	contents, _ := ioutil.ReadAll(res.Body)
	fmt.Printf("Http Status:%s, result: %s\n", res.Status, contents)
	return nil
}

func getCostPeriod(granularity string, start string, end string) (*costexplorer.GetCostAndUsageOutput, error) {
	svc := costexplorer.New(session.Must(session.NewSession()))
	metric := "UnblendedCost"
	timePeriod := costexplorer.DateInterval{
		Start: aws.String(start),
		End:   aws.String(end),
	}
	input := costexplorer.GetCostAndUsageInput{}
	input.Granularity = aws.String(granularity)
	input.Metrics = []*string{&metric}
	input.TimePeriod = &timePeriod
	return svc.GetCostAndUsage(&input)
}

func newTimeHelper(locationName string) (*TimeHelper, error) {
	location, err := time.LoadLocation(locationName)
	return &TimeHelper{
		Location: location,
		Now:      time.Now().In(location),
	}, err
}

func (timeh TimeHelper) GetFirstOfMonth() string {
	return time.Date(timeh.Now.Year(), timeh.Now.Month(), 1, 0, 0, 0, 0, time.UTC).Format("2006-01-02")
}

func (timeh TimeHelper) GetSecondOfMonth() string {
	return time.Date(timeh.Now.Year(), timeh.Now.Month(), 2, 0, 0, 0, 0, time.UTC).Format("2006-01-02")
}

func (timeh TimeHelper) GetLastOfMonth() string {
	return time.Date(timeh.Now.Year(), timeh.Now.Month(), 1, 0, 0, 0, 0, time.UTC).AddDate(0, 0, -1).Format("2006-01-02")
}

func (timeh TimeHelper) GetYesterday() string {
	return timeh.Now.AddDate(0, 0, -1).Format("2006-01-02")
}
