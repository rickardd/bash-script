#!/bin/bash

# Read $1.txt e.g en-sp.txt
# Save no of lines in variable
# Get a random between 0 and total
# Read that line from the file
# Save from and to translation in variables
# Echo from tanslation
# Ask for user input
# Compare to translation and user input
# Echo colored response 
# If correct
#	Read the number in score.txt
#	Over write with the new score
# Restart with a new random number. 

languageFile="$1.txt"
lineNumber=0
totalNumberOfLines=$(wc -l $languageFile | awk '{print $1}')

clear
echo "***************************"
echo "**"
echo "**  YOU ARE PLAYING"
echo "**"
echo "**  $totalNumberOfLines words in $languageFile"
echo "**"
echo "****************************"
echo " "
read -p "Hit Enter to Start" getStarted


function setLineNumber(){
	lineNumber=$(( ( $RANDOM % $totalNumberOfLines ) + 1 ))
}

function scoreUp () {
	local scoreFile='score.txt'
	score=$(cat $scoreFile)
	echo $(expr $score + 1) > $scoreFile 
}

function ask () {
	clear
	setLineNumber
	line=$(cat $languageFile | head -$lineNumber | tail -1)
	fromWord="$(cut -d':' -f1 <<<"$line")"
	toWord="$(cut -d':' -f2 <<<"$line")"

	echo -e "${lineNumber}: What is: ""\033[1m${fromWord}\033[0m"
	echo " "
	read -p "Your answer? " userInput
	clear
	if [ $userInput = $toWord ]
	then
		echo -e "\033[1;92mCorrect: \033[0m" "${toWord}"
		scoreUp
	else
		echo -e "\033[1;91mWrong: \033[0m" "${fromWord} = ${toWord}"
		echo -e "You typed: ""\033[1;97m${userInput} \033[0m"
	fi
	echo " "
	read -p "Hit Enter to Continue..." doNextQuestion
	ask
}

ask

