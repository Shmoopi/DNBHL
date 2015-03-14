#!/bin/bash

###################################################################################################

### DNBHL Automated Testing Script ###
# This is a script to automate checking codes for the DNBHL (Do Not Believe His Lies) application.

## To use, simply run the script and provide either a file path, or quoted guesses.  The script
## Automatically takes the strings (codes) and validates them.  If any matches are found, the
## Script will return "FOUND" and exit 0 - otherwise, the script will exit 1

## Example Usage:
# ./ShadowPuzzle.sh checkthisout.txt
# ./ShadowPuzzle.sh "the first time" "I SAW YOU THERE" "In my dreams"

###################################################################################################

# Check if we received any arguments
if [ -z "$@" ]; then
  # Nothing input, fail
  echo "No input received..."

  # Empty line
  echo

  # Exit
  exit 1
fi

# Variable to say we found something
EXITCODE=1

# Variable to show puzzle type - change to 0 to not show the puzzle type
SHOWPUZZLETYPE=1
# Variable to show hints - change to 0 to not show hints
SHOWHINTS=1
# Variable to show the puzzle location - Change to 0 to not show the puzzle location
SHOWPUZZLELOCATION=1

# Function to check if the string works
function doesStringWork() {
  # Set var to the first argument passed to this function
  var=$1
  # Make the argument contain no spaces and all caps
  STRING=$(echo "${var//[[:blank:]]/}" | awk '{print toupper($0)}')
  # Time the curling of the page
  START=$(date +%s)
  # Curl the s3 page
  PAGE=$(curl -s https://s3.amazonaws.com/shadowpuzzle/"$STRING".xml 2>&1)
  # Grep the page to see if there's a match
  if [[ ! "$PAGE" =~ "Access Denied" ]]; then
    # Found it!

    # Finish timing the curl
    END=$(date +%s)
    DIFF=$(echo "$END - $START" | bc)

    # Return FOUND
    echo "FOUND: $STRING with URL: https://s3.amazonaws.com/shadowpuzzle/$STRING.xml (Amount of Time: $DIFF Seconds)"

    # Show the puzzle type...
    if [ $SHOWPUZZLETYPE = 1 ]; then
      echo "PUZZLE TYPE: $(echo "$PAGE" | grep "id=\"puzzle\">" | awk '{print $1;}' | cut -c 2-)"
    fi

    # Get the puzzle location...
    if [ $SHOWPUZZLELOCATION = 1 ]; then
      echo "PUZZLE LOCATION: $(echo "$PAGE" | sed -n 's:.*<property name="data-location">\(.*\)</property>.*:\1:p')"
    fi

    # Get the hint...
    if [ $SHOWHINTS = 1 ]; then
      echo "HINT: $(echo "$PAGE" | grep "<property name=\"text\">" | tail -3 | head -1 | sed -n 's:.*<property name="text">\(.*\)</property>.*:\1:p')"
    fi

    # Change the exit code
    EXITCODE=0
  else
    # Not found!
    # Finish timing the curl
    END=$(date +%s)
    DIFF=$(echo "$END - $START" | bc)

    # Return not found
    echo "Did not find: $STRING with URL: https://s3.amazonaws.com/shadowpuzzle/$STRING.xml (Amount of Time: $DIFF Seconds)"
  fi

  # Empty line
  echo

  return
}

## Find out if we need to read lines from a file or strings passed through command-line ##

# Empty line
echo

# Check if the first argument is a file that exists
if [ -e "$1" ]; then

  # First argument is a file that exists, read from the file and check each line

  # Treat this run as a file input - Read from the file and check each line
  while read line || [ -n "$line" ]; do
    # Check if the line is empty
    if [ -z "$line" ]; then
      # Empty line
      continue
    fi
    # Get the line
    LINETOCHECK=$line
    # Check the line
    doesStringWork "$LINETOCHECK"
  done < "$1"

else

  # First argument is not a file, read from each argument and check if it exists

  # Run through all the arguments given to us
  for var in "$@"
  do
    # Check the argument
    doesStringWork "$var"
  done
fi

# Exit based on what we found
exit "$EXITCODE"
