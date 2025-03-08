package main

import (
	"github.com/youthcongress/api/database"
	"github.com/youthcongress/api/server"
	"github.com/youthcongress/api/storage"
)

func main(){

	server.StartServer()

	database.Connection()
	storage.Connection()
	
}