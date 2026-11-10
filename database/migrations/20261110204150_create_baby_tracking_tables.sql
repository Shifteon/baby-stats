-- +goose Up
CREATE TABLE IF NOT EXISTS baby (
    name TEXT PRIMARY KEY,
    birthDate TEXT NOT NULL,
    gender TEXT NOT NULL
);

CREATE TABLE IF NOT EXISTS breastfeeding (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    babyName TEXT NOT NULL,
    leftDurationSeconds INTEGER NOT NULL,
    rightDurationSeconds INTEGER NOT NULL,
    totalDurationSeconds INTEGER NOT NULL,
    startDatetime TEXT NOT NULL,
    endDatetime TEXT NOT NULL,

    FOREIGN KEY (babyName) REFERENCES baby (name)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);

CREATE TABLE IF NOT EXISTS sleep (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    babyName TEXT NOT NULL,
    durationSeconds INTEGER NOT NULL,
    startDatetime TEXT NOT NULL,
    endDatetime TEXT NOT NULL,

    FOREIGN KEY (babyName) REFERENCES baby (name)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);

CREATE TABLE IF NOT EXISTS diaper (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    babyName TEXT NOT NULL,
    datetime TEXT NOT NULL,
    isWet INTEGER NOT NULL, -- bool
    isDirty INTEGER NOT NULL, -- bool

    FOREIGN KEY (babyName) REFERENCES baby (name)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);

CREATE TABLE IF NOT EXISTS pumping (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    babyName TEXT NOT NULL,
    datetime TEXT NOT NULL,
    leftTotalOz REAL NOT NULL,
    rightTotalOz REAL NOT NULL,
    totalOz REAL NOT NULL,

    FOREIGN KEY (babyName) REFERENCES baby (name)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);

CREATE TABLE IF NOT EXISTS bottleFeeding (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    babyName TEXT NOT NULL,
    datetime TEXT NOT NULL,
    totalOz REAL NOT NULL,
    isFormula INTEGER NOT NULL, -- bool
    isBreast INTEGER NOT NULL, -- bool
    isCow INTEGER NOT NULL, -- bool

    FOREIGN KEY (babyName) REFERENCES baby (name)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);

-- +goose Down
DROP TABLE bottleFeeding;
DROP TABLE pumping;
DROP TABLE diaper;
DROP TABLE sleep;
DROP TABLE breastfeeding;
DROP TABLE baby;
