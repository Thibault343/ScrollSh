#!/bin/bash

# Variables and lists

# Characters list
charactersList="abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVW XYZ+!?@#*ç%&/|()¢=^~èü[!éöä{}]"
# final word
final_word=''
# Word state (the word state define whose letter is check)
state=1
# ask a word to user
word="$1"
# Fonction d'aide
show_help() {
    echo "Usage: $0 [options] <word>"
    echo
    echo "Options:"
    echo "  --help    Show this help message"
    echo
    echo "Description:"
    echo "  This script takes a word as a parameter and removes its last character."
    echo "  The word should be passed as a parameter when running the script."
    echo "  To write a phrase you can add ""."
    echo
}

# Checking options
if [ "$1" == "--help" ]; then
    show_help
    exit 0
fi

# Check if a parameter was passed
if [ -z "$1" ]; then
    echo "Error: You must provide a word as a parameter."
    echo "Use --help for more information."
    exit 1
fi
while true; do
    # verify if the final word is full
    if [ "$state" -gt "${#word}" ]; then
        break
    fi
    # get a letter from the characterlist       
    characters_random=$(echo $charactersList | fold -w1 | shuf | head -n1)
    # if the letter is equal to the letter select by the state
    if [ "$characters_random" = "$(echo "$word" | cut "-c$state")" ]; then
        final_word+="$characters_random"
        state=$((state + 1))
        echo "$final_word"
    else 
        final_word+="$characters_random"
        echo "$final_word"
        final_word="${final_word%?}"
    fi
    
done
