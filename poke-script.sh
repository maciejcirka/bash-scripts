#!/bin/bash 

# Script in polish, works on OS X

echo
echo "-------------------------------------------------------------"
echo "Witaj! Zaraz dowiesz się jakim Pokemonem jesteś!"
echo
echo "Jak się nazywasz?"

read name

echo
echo "Szukam Pokemona, którym jesteś........"
echo

yourPokemon=$(curl -s http://pokemon.step.lv/?name=${name// /+} |
grep "<h2>" |
sed -n 's:.*<h2>\(.*\)</h2>.*:\1:p')

image=$(curl -s "https://bulbapedia.bulbagarden.net/wiki/"$yourPokemon"_(Pokémon)" | 
grep "$yourPokemon.png/250px" | 
grep 'title="'$yourPokemon'"' | 
sed -n 's:.*src\(.*\)decoding.*:\1:p' | 
cut -d '"' -f2)

curl -s "https:$image" > $yourPokemon.png
open $yourPokemon.png

description=$(curl -s "https://pokelife.pl/pokedex/index.php/"$yourPokemon"" | 
grep "zachowanie</span></h2>\n
<p>" |
sed -e 's/<[^>]*>//g' |
sed -r '/^\s*$/d')

printf "W świecie Pokemon jesteś $yourPokemon! \n $description" > $yourPokemon-info.txt
open $yourPokemon-info.txt

echo "Ta-dam! Oto on!"
echo "-------------------------------------------------------------"



