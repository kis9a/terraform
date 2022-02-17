package handler

import (
	"context"
	"encoding/json"
	"fmt"
	"log"
	"net/http"
	"net/url"
	"strings"

	"github.com/aws/aws-lambda-go/events"
	"github.com/aws/aws-lambda-go/lambdacontext"
	"github.com/gobwas/glob"
)

var webhooks = []Webhook{
	{
		Pattern: "**dev**",
		URL:     "https://hooks.slack.com/services/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",
	},
}

type Payload struct {
	Username   string         `json:"username"`
	Icon_emoji string         `json:"icon_emoji"`
	Blocks     []PayloadBlock `json:"blocks"`
}

type PayloadBlock struct {
	Type string      `json:"type"`
	Text PayloadText `json:"text"`
}

type PayloadText struct {
	Type string `json:"type"`
	Text string `json:"text"`
}

type Webhook struct {
	Pattern string `json:"pattern"`
	URL     string `json:"url"`
}

type Handler struct{}

func New() *Handler {
	return &Handler{}
}

func (h *Handler) Run(ctx context.Context, e events.CloudwatchLogsEvent) {
	_, err := parseContext(ctx)
	if err != nil {
		log.Fatal(err)
	}

	data, err := e.AWSLogs.Parse()
	if err != nil {
		log.Fatal(err)
	}
	if err = notifyCloudwatchLogsEvent(data); err != nil {
		log.Fatal(err)
	}
}

func parseContext(ctx context.Context) (*lambdacontext.LambdaContext, error) {
	lc, ok := lambdacontext.FromContext(ctx)
	if !ok {
		return nil, fmt.Errorf("could not parse Lambda Context")
	}
	return lc, nil
}

func parseTimeStamp(t int64) string {
	// dependence on cloudWatch timestamp_format
	return fmt.Sprint(t)
}

func notifyCloudwatchLogsEvent(l events.CloudwatchLogsData) error {
	lp, err := getCloudwatchLogsEventPayload(l)
	if err != nil {
		return err
	}
	pjson, err := json.Marshal(lp)
	if err != nil {
		return err
	}
	webhookURL := getWebhook(l.LogGroup).URL
	if webhookURL == "" {
		return fmt.Errorf("LogGroup Name does not match a URL")
	}
	if err = notify(string(pjson), webhookURL); err != nil {
		return err
	}
	return nil
}

func getWebhook(m string) Webhook {
	for _, w := range webhooks {
		g := glob.MustCompile(w.Pattern, '/')
		is := g.Match(m)
		if is {
			return w
		}
	}
	return Webhook{}
}

func getCloudwatchLogsEventPayload(l events.CloudwatchLogsData) (Payload, error) {
	var p Payload
	p.Username = l.LogGroup
	p.Icon_emoji = "alarm_clock"

	for _, v := range l.LogEvents {
		p.Blocks = append(p.Blocks, PayloadBlock{
			Type: "section",
			Text: PayloadText{
				Type: "mrkdwn",
				Text: strings.Join([]string{"*", l.LogGroup, " ", parseTimeStamp(v.Timestamp), "*"}, ""),
			},
		},
		)
		p.Blocks = append(p.Blocks, PayloadBlock{
			Type: "section",
			Text: PayloadText{
				Type: "plain_text",
				Text: v.Message,
			},
		})
	}
	return p, nil
}

func notify(str string, webhookURL string) error {
	resp, err := http.PostForm(webhookURL, url.Values{"payload": {string(str)}})
	if err != nil {
		return err
	}
	if resp.StatusCode != http.StatusOK {
		return fmt.Errorf("Notify Response Status Code is wrong\n%v+", resp)
	}
	defer resp.Body.Close()
	return nil
}
