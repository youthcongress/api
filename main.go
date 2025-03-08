package main

import (
	"github.com/youthcongress/api/database"
	"github.com/youthcongress/api/storage"
)

func main(){
	database.Connection()
	storage.Connection()
}