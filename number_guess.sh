#!/bin/bash

PSQL="psql --username=freecodecamp --dbname=number_guess -t --no-align -c"

echo -e "\nEnter your username:"
read USERNAME

QUERY_RESULT=$($PSQL "SELECT * FROM players WHERE username = '$USERNAME'")

if [[ -z $QUERY_RESULT ]]
then
  echo -e "\nWelcome, $USERNAME! It looks like this is your first time here."
else
  IFS="|" read -r USERNAME GAMES_PLAYED BEST_GAME <<< "$QUERY_RESULT"
  echo -e "\nWelcome back, $USERNAME! You have played $GAMES_PLAYED games, and your best game took $BEST_GAME guesses."
fi

SECRET_NUMBER=$(( RANDOM % 1000 + 1 ))
NUMBER_OF_GUESSES=1

echo -e "\nGuess the secret number between 1 and 1000:"
read GUESS

while [[ $GUESS -ne $SECRET_NUMBER ]]
do
  if [[ ! $GUESS =~ ^[0-9]+$ ]]
  then
    echo -e "\nThat is not an integer, guess again:"
  else
    if [[ $GUESS -gt $SECRET_NUMBER ]]
    then
      echo -e "\nIt's lower than that, guess again:"
    else
      echo -e "\nIt's higher than that, guess again:"
    fi

    (( NUMBER_OF_GUESSES++ ))
  fi

  read GUESS
done

echo -e "\nYou guessed it in $NUMBER_OF_GUESSES tries. The secret number was $SECRET_NUMBER. Nice job!"

if [[ -z $QUERY_RESULT ]]
then
  INSERT_PLAYER_HISTORY=$($PSQL "INSERT INTO players(username, games_played, best_game) VALUES('$USERNAME', 1, $NUMBER_OF_GUESSES)")
else
  if [[ $NUMBER_OF_GUESSES -lt $BEST_GAME ]]
  then
    INSERT_PLAYER_HISTORY=$($PSQL "UPDATE players SET games_played = games_played + 1, best_game = $NUMBER_OF_GUESSES WHERE username = '$USERNAME'")
  else
    INSERT_PLAYER_HISTORY=$($PSQL "UPDATE players SET games_played = games_played + 1 WHERE username = '$USERNAME'")
  fi
fi