package main
import (
	"log"
	"net/http"
)

func Handler(w http.ResponseWriter, r *http.Request){
	http.ServeFile(w, r, "index.html")
}

func main() {
	http.HandleFunc("/", Handler)
	if err := http.ListenAndServe("0.0.0.0:8080", nil); err != nil {
		log.Fatal(err)
	}

}