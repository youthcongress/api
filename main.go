package main

import (
	"log"

	"github.com/gofiber/fiber/v2"
)

func main() {
	// Create a new Fiber instance
	app := fiber.New()

	// Define a simple route
	app.Get("/", func(c *fiber.Ctx) error {
		return c.SendString("Hello, Fiber!")
	})

	// Define an API route
	app.Get("/api", func(c *fiber.Ctx) error {
		data := fiber.Map{"message": "Welcome to GoFiber API!"}
		return c.JSON(data)
	})

	// Start the server on port 8004
	port := ":8004"
	log.Printf("Server is running on http://localhost%s", port)
	if err := app.Listen(port); err != nil {
		log.Fatalf("Error starting server: %v", err)
	}
}
