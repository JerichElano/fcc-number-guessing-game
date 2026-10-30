# 🎲 Number Guessing Game

An interactive Bash command-line utility powered by a PostgreSQL database, built as part of the **freeCodeCamp Relational Database Certification**.

---

## 🎮 About the Project

The core objective of this project was to build a number-guessing game that runs entirely in the terminal. The script generates a random secret number between 1 and 1000, prompts the user for guesses, provides higher/lower feedback, tracks game statistics in a PostgreSQL database, and welcomes returning players with their historical scores.

---

## 🚀 Key Files

- **`number_guess.sh`** - The core Bash script that handles game logic, user input validation, PostgreSQL database queries, and dynamic output formatting.
- **`number_guess.sql`** - The PostgreSQL database dump containing the database schema and player records.

---

## 💡 Technical Highlights & Implementation

- **Robust Input Validation**: Implements regex matching (`[[ $GUESS =~ ^[0-9]+$ ]]`) to ensure non-integer inputs (like strings or decimals) are safely caught and handled without crashing the script.
- **Conditional State Management**: Dynamically tracks total games played and updates personal best scores using strict comparison operators (`-lt` for fewer guesses).
- **Random Number Generation**: Utilizes Bash's built-in `$RANDOM` arithmetic expansion to generate a secure random target number between 1 and 1000.
