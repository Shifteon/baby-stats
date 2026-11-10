package database

import (
	"database/sql"
	"embed"

	"github.com/pressly/goose/v3"
	_ "modernc.org/sqlite"
)

func NewConnection() (*sql.DB, error) {
	db, err := sql.Open("sqlite", "baby.db?_pragma=foreign_keys=on&_journal_mode=WAL&_cache=shared")

	if err != nil {
		return nil, err
	}

	return db, nil
}

//go:embed migrations/*.sql
var embedMigrations embed.FS

func RunMigrations(db *sql.DB) error {
	goose.SetBaseFS(embedMigrations)

	if err := goose.SetDialect("sqlite3"); err != nil {
		return err
	}

	if err := goose.Up(db, "migrations"); err != nil {
		return err
	}

	return nil
}
