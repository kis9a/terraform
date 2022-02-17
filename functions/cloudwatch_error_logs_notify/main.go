package main

import (
	"log"
	"main/handler"

	"github.com/aws/aws-lambda-go/lambda"
)

func init() {
	log.SetFlags(log.LstdFlags | log.Lshortfile)
}

func main() {
	lambda.Start(handler.New().Run)
}
