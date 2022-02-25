#! /bin/bash

# Welcoming message for the program
echo ""
echo "Welcome to this market which contains only three fruits :)"
echo "Welcome to ApplesPearsCherries"
echo ""

# The first function checks if the customer wants to start an order or quit
# It also collects the customer name and phone number
function program() {
	echo "Would you like to start an order?"
	read -p "Please enter buy or quit: " choice

	# While loop to validade the user input.
	while [[ ! $choice =~ ^(buy|BUY|b|B|quit|QUIT|q|Q)$ ]]; do
		read -p "Please enter one of the options (buy|BUY|b|B / quit|QUIT|q|Q) " choice
	done

	# Check for $choice if is buy or quit
	case $choice in
		quit|QUIT|q|Q )
			# Close the program if choice was to quit
			echo "----- Thanks for using our program! See you next time -----"
			exit 0
			;;
		buy|BUY|b|B )
			# If the choice was to buy:
			# Prompt user for their name, cannot be empty
			if [[ -z "$name" ]]; then 	# -> This if statment check weather the customer already
										#    inputed their name in a previous purchase.
				read -p "Please enter your name: " name
				while [[ -z "$name" ]]; do
					echo ""
					echo "Your name cannot be empty."
					read -p "Please enter your name: " name
				done

				# Prompt the user for their phone number, it can only contain numbers, and cannot be empty
				read -p "Please enter your phone number: " phone_number
				while [[ ! $phone_number =~ ^[0-9]+$ ]]; do
					echo ""
					echo "Phone number can only contain numbers, and cannot be empty."
					read -p "Please enter your phone number: " phone_number
				done
			fi

			# After collecting the customer information, enters the buy function
			buy
			;;
	esac	
}

# Buy function collects information about the order.
function buy() {
	# List of fruits that can be inputted
	fruits='^(apple|Apple|APPLE|pear|Pear|PEAR|cherry|Cherry|CHERRY)$'
	echo ""
	echo "We have apple, pear or cherry"
	read -p "What kind of fruit would you like? " fruit

	# Collects the fruit that the customer wants to buy.
	# Has to be one that is in the list above
	while [[ ! $fruit =~ $fruits ]]; do
		echo "Sorry we don't have $fruit, we only have apple, pear or cherry)."
		read -p "What kind of fruit would you like? " fruit
	done

	# Collects the amount in kg, can only be numbers and more than 1
	read -p "How many kg would you like? " amount
	while [[ ! $amount =~ ^[0-9]+$ ]] || [[ $amount < 1 ]]; do
		read -p "Please enter a valid positive amount: " amount
	done

	# Summary
	summary

}

# Summary function.
# Gives the customer a summary of ther order
function summary() {
	# First it checks which fruit was ordered, and set the price for it
	case $fruit in
		apple|Apple|APPLE )
			price=3
			;;
		pear|Pear|PEAR )
			price=4
			;;
		cherry|Cherry|CHERRY )
			price=2
			;;
	esac

	Date=$(date +"%d-%m-%Y %T") # Gets the date and time

	echo ""
	echo "===================================================="
	echo "Hello $name, here is the summary of your order:"
	echo "Date: $Date"
	echo "----------------------------------------------------"
	echo "Your phone number: "$phone_number"."
	echo "You have bought "$amount"kg of "$fruit"."
	echo "The price for a kg of $fruit is £"$price"."
	echo "The total cost is £$(($amount*$price))"
	echo "===================================================="
	echo ""

	program

}

program