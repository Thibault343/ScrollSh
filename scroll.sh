#!/bin/bash

# Liste contenant toutes les lettres de l'alphabet
alphabet=(
    a b c d e f g h i j k l m n o p q r s t u v w x y z
)
final_word=''
count=0
# Sélection aléatoire d'une lettre
lettre_aleatoire=${alphabet[RANDOM % ${#alphabet[@]}]}

# Affiche la lettre choisie

# Demande à l'utilisateur d'entrer un mot
read -p "Entrez un mot : " mot

# Vérifie si la première lettre du mot correspond à la lettre aléatoire
while [[ $final_word -lt  $mot]]; do
    premiere_lettre=${mot:0:1} # Récupère la première lettre du mot
    if [[ "$premiere_lettre" == "$lettre_aleatoire" ]]; then
        final_word += $premiere_lettre  
    fi
done