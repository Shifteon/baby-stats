package main

import (
	"baby-stats/database"
	"fmt"
)

func main() {
	db, err := database.NewConnection()
	if err != nil {
		fmt.Printf("A fatal error occured! Could not connect to the db!\nError: %v\n", err)
	}
	defer db.Close()

	migrationErr := database.RunMigrations(db)
	if migrationErr != nil {
		fmt.Printf("A fatal error occured! Could not set up db!\nError: %v\n", migrationErr)
		return
	}
	fmt.Println("Created db and ran migrations!")
}
