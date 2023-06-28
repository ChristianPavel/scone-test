package main

import (
    "os"
    "fmt"
    "net/http"
)

func handler(w http.ResponseWriter, r *http.Request) {
    fmt.Fprintf(w, "Hi there, I love %s!\n", r.URL.Path[1:])
    if r.URL.Path[1:] == "EXIT" {
        os.Exit(0)
    }
}

func main() {
    http.HandleFunc("/", handler)
    http.ListenAndServe(":8080", nil)
}