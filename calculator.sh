#!/bin/bash

# Function to validate numeric input for choices
is_valid_choice() {
    local choice=$1
    if ! [[ "$choice" =~ ^[1-5]$ ]]; then
        echo "Error: '$choice' is not a valid choice. Please enter a number between 1 and 5."
        return 1
    fi
    return 0
}

# Function to validate number input from the user
is_number() {
    for num in "$@"; do
        if ! [[ "$num" =~ ^-?[0-9]+$ ]]; then
            echo "Error: '$num' is not a valid number."
            return 1
        fi
    done
    return 0
}

# Function for addition
addition() {
    if ! is_number "$@"; then
        return
    fi

    local result=0
    for num in "$@"; do
        result=$((result + num))
    done
    echo "Result: $result"
}

# Function for subtraction
subtraction() {
    if ! is_number "$@"; then
        return
    fi

    local result=$1
    shift
    for num in "$@"; do
        result=$((result - num))
    done
    echo "Result: $result"
}

# Function for multiplication
multiplication() {
    if ! is_number "$@"; then
        return
    fi

    local result=1
    for num in "$@"; do
        result=$((result * num))
    done
    echo "Result: $result"
}

# Function for division
division() {
    if ! is_number "$@"; then
        return
    fi

    local result=$1
    shift
    for num in "$@"; do
        if [ $num -eq 0 ]; then
            echo "Error: Division by zero"
            return
        fi
        result=$((result / num))
    done
    echo "Result: $result"
}

# Function to display menu
display_menu() {
    echo "Select an operation:"
    echo "1. Addition"
    echo "2. Subtraction"
    echo "3. Multiplication"
    echo "4. Division"
    echo "5. Exit"
}

# Main loop
while true; do
    display_menu
    read -p "Enter your choice: " choice

     # Validate the user choice selection
    if ! is_valid_choice "$choice"; then
        continue
    fi

    # Check if the user wants to exit
    if [ "$choice" -eq 5 ]; then
        echo "Exiting the calculator."
        break
    fi

    #Tell user the arithmetic option they have selected
    case $choice in
        1)
            echo "You have selected addition operation."
            ;;
        2)
            echo "You have selected subtraction operation."
            ;;
        3)
            echo "You have selected multiplication operation."
            ;;
        4)
            echo "You have selected division operation."
            ;;
    esac

    # Prompt user for operands
    read -p "Enter the operands separated by space: " -a operands

    # Perform the selected operation
    case $choice in
        1)
            addition "${operands[@]}"
            ;;
        2)
            subtraction "${operands[@]}"
            ;;
        3)
            multiplication "${operands[@]}"
            ;;
        4)
            division "${operands[@]}"
            ;;
    esac
done