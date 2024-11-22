#!/bin/bash

# color dictionnary
declare -A colors
# Variables and lists
charactersList="abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVW XYZ+!?@#*ç%&/|()¢=^~èü[!éöä{}]-_;:.,><\§°"
final_word=''


# Add color codes for text colors
colors["black"]="\e[30m"
colors["red"]="\e[31m"
colors["green"]="\e[32m"
colors["yellow"]="\e[33m"
colors["blue"]="\e[34m"
colors["magenta"]="\e[35m"
colors["cyan"]="\e[36m"
colors["gray"]="\e[90m"
colors["dark_red"]="\e[91m"
colors["dark_green"]="\e[92m"
colors["dark_yellow"]="\e[93m"
colors["dark_blue"]="\e[94m"
colors["dark_magenta"]="\e[95m"
colors["dark_cyan"]="\e[96m"
colors["dark_white"]="\e[97m"


# reset color
reset="\e[0m"
color=""
state=1
word="$1"
find=false
bold=false

# Function to display help
show_help() {
    echo "Usage: $0 [options] <word>"
    echo
    echo "Options:"
    echo "  --help    Show this help message"
    echo "  -c        add a color to your text, color table : https://github.com/Thibault343/ScrollSh"
    echo
    echo "Description:"
    echo "  This script takes a word as a parameter and removes its last character."
    echo "  The word should be passed as a parameter when running the script."
    echo "  To write a phrase you can add \"\"."
    echo
}

# Checking options
if [ "$1" == "--help" ]; then
    show_help
    exit 0
fi

if [ "$2" == "-c" ]; then
    for key in "${!colors[@]}"; do
        if [[ "$key" == "$3" ]]; then
            find=true
            color="${colors[$3]}"
            break
        fi
    done
fi
# Check if a parameter was passed
if [ -z "$1" ]; then
    echo "Error: You must provide a word as a parameter."
    echo "Use --help for more information."
    exit 1
fi

while true; do
    # Verify if the final word is full
    if [ "$state" -gt "${#word}" ]; then
        break
    fi

    # Get a random letter from the characters list
    characters_random=$(echo $charactersList | fold -w1 | shuf | head -n1)

    # If the letter matches the character at the current position of the word
    if [ "$characters_random" = "$(echo "$word" | cut -c$state)" ]; then
        final_word+="$characters_random"
        state=$((state + 1))
        echo -e "${color}${final_word}${reset}"
    else
        final_word+="$characters_random"
        echo -e "${color}${final_word}${reset}"
        final_word="${final_word%?}"  # Remove the last character
    fi
done
