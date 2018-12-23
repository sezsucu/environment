#!/usr/bin/env bash

options="Science Math Movies exit"
selected=""
until [[ "$selected" == "exit" ]]; do
    echo "Choose a topic for the quiz"
    select selected in $options; do
        if [[ -z $selected ]]; then
            echo "Invalid selection"
        elif [[ "$selected" == "exit" ]]; then
            break
        elif [[ -n "$selected" ]]; then
            echo "Questions for $selected topic"
            for n in 1 2; do
                echo "Question $n ) ...."
            done
            for n in `seq 3 5`; do
                echo "Question $n ) ...."
            done
            break
        else
            echo "Invalid selection"
        fi
        echo "Choose a topic for the quiz"
    done
done

read -p "Do you recommend this program to your friends? [y/n] " response
case $response in
    [yY] )
        echo "Thank you"
        ;;
    [nN] )
        echo "Booo!"
        ;;
    *)
        echo "What did you say?"
        ;;
esac

