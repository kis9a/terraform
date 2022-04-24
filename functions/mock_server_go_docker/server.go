package main

import (
	"fmt"
	"io"
	"net/http"
	"os"
)

var defaultPort = "8080"

func main() {
	port := os.Getenv("SERVER_PORT")
	if port == "" {
		port = defaultPort
	}
	fmt.Printf("Starting server at port %s\n", port)

	rootHandler := func(w http.ResponseWriter, req *http.Request) {
		io.WriteString(w, "ok")
	}
	http.HandleFunc("/", rootHandler)

	pingHandler := func(w http.ResponseWriter, req *http.Request) {
		io.WriteString(w, "pong")
	}
	http.HandleFunc("/ping", pingHandler)

	if err := http.ListenAndServe(fmt.Sprintf(":%s", port), nil); err != nil {
		fmt.Printf("[Error] %v\n", fmt.Errorf("Error starting server"))
	}
}
