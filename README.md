# DNBHL Code Testing

DNBHL (Do Not Believe His Lies) Automated Code Testing Script

## Features

- Identifies Valid Codes
- Shows puzzle types
- Shows puzzle location (URL)
- Shows puzzle hints

## Usage

Using the ShadowPuzzle script is very simple, just drag and drop it into Terminal, or cd into the directory with your script, and give it the path to a text file containing the codes you'd like to try.

```shell
$ ./ShadowPuzzle.sh checkthisout.txt
```
Or simply pass the codes as arguments to the script.

```shell
$ ./ShadowPuzzle.sh "the first time" "I SAW YOU THERE" "In my dreams"
```

Codes are separated by newlines in the provided txt file.

## Example Output
### \*\*\*SPOILERS***

```
FOUND: THEFIRSTTIME with URL: https://s3.amazonaws.com/shadowpuzzle/THEFIRSTTIME.xml (Amount of Time: 3 Seconds)
PUZZLE TYPE: Text
PUZZLE LOCATION: https://s3.amazonaws.com/shadowpuzzle/thefirsttime.txt
HINT: Try to decrypt this with a method of transmitting text information as a series of on-off tones, lights, or clicks.

FOUND: ISAWHIMTHERE with URL: https://s3.amazonaws.com/shadowpuzzle/ISAWHIMTHERE.xml (Amount of Time: 4 Seconds)
PUZZLE TYPE: Image
PUZZLE LOCATION: https://s3.amazonaws.com/shadowpuzzle/isawhimthere.jpg
HINT: Decrypt this using any photo editing software or app, or just print the image, cut and solve the puzzle.

FOUND: INMYDREAMS with URL: https://s3.amazonaws.com/shadowpuzzle/INMYDREAMS.xml (Amount of Time: 0 Seconds)
PUZZLE TYPE: Sound
PUZZLE LOCATION: https://s3.amazonaws.com/shadowpuzzle/inmydreams.m4a
HINT: This is too fast. Try slowing it down. Remember The First Time.
```

## OS Support

- Mac OS X 10.6+

## License
MIT license. Copyright © 2015 [Shmoopi LLC](http://shmoopi.net/).
