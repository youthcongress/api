package server

import (
	"fmt"
	"log"
	"net/http"
)

func StartServer() {
	port := 8010

	// Define a simple handler
	http.HandleFunc("/", func(w http.ResponseWriter, r *http.Request) {
		fmt.Fprintln(w, "Hello! API Server is running on port 8010.")
	})

	// Start the server
	log.Printf("Starting API server on port %d...\n", port)
	err := http.ListenAndServe(fmt.Sprintf(":%d", port), nil)
	if err != nil {
		log.Fatalf("Failed to start server: %v", err)
	}
}