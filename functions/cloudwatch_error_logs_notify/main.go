package main

import (
	"context"
	"encoding/json"
	"log"
	"net/http"
	"net/url"
	"os"

	"github.com/aws/aws-lambda-go/events"
	"github.com/aws/aws-lambda-go/lambda"
)

var webhookUrl string

type payload struct {
	Text string `json:"text"`
}

func init() {
	log.SetFlags(log.LstdFlags | log.Lshortfile)
	webhookUrl = os.Getenv("SLACK_WEBHOOK_URL")
}

func main() {
	lambda.Start(handler)
}

func handler(ctx context.Context, e events.CloudwatchLogsEvent) {
	data, err := e.AWSLogs.Parse()
	if err != nil {
		log.Fatal(err)
	}
	logs, err := json.Marshal(data.LogEvents)
	if err != nil {
		log.Fatal(err)
	}
	p, err := json.Marshal(payload{Text: string(logs)})
	if err != nil {
		log.Fatal(err)
	}
	resp, err := http.PostForm(webhookUrl, url.Values{"payload": {string(p)}})
	if err != nil {
		log.Fatal(err)
	}
	defer resp.Body.Close()
}
