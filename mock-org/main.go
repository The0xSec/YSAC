package main

import (
	"encoding/json"
	"net/http"
)

type Org struct {
	TeamName  string     `json:"name"`
	Employees []Employee `json:"business_unit"`
}

type Employee struct {
	ID   int    `json:"id"`
	Name string `json:"name"`
	Role string `json:"role"`
}

func Mocks() Org {
	return Org{
		TeamName: "Tech Corp",
		Employees: []Employee{
			{ID: 1, Name: "The0x", Role: "Security Engineer"},
			{ID: 2, Name: "Levi", Role: "Engineering Manager"},
			{ID: 3, Name: "Seeknay", Role: "Identity Manager"},
		},
	}
}

func handler(w http.ResponseWriter, r *http.Request) {
	w.Header().Set("Content-Type", "application/json")
	orgData := Mocks()
	json.NewEncoder(w).Encode(orgData)
}

func main() {
	http.HandleFunc("/api/org", handler)
	http.ListenAndServe(":8080", nil)
}
