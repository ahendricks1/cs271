// This file is part of www.nand2tetris.org
// and the book "The Elements of Computing Systems"
// by Nisan and Schocken, MIT Press.
// File name: projects/04/Fill.asm

// Runs an infinite loop that listens to the keyboard input.
// When a key is pressed (any key), the program blackens the screen,
// i.e. writes "black" in every pixel;
// the screen should remain fully black as long as the key is pressed. 
// When no key is pressed, the program clears the screen, i.e. writes
// "white" in every pixel;
// the screen should remain fully clear as long as no key is pressed.

//Creating current location variable
(RESTART)
@SCREEN
D=A
@currentloc
M=D

//Check if keyboard is being pressed, if so, goto IFTRUE. Otherwise goto ELSE.
(START)
@KBD
D=M
@IFTRUE
D;JGT
@ELSE
0;JMP

//Key is being pressed, color pixels black
(IFTRUE)
@currentloc
A=M
M=-1
@INCREMENT
0;JMP

//Else color pixels white
(ELSE)
@currentloc
A=M
M=0
@INCREMENT
0;JMP

//Incrememnt the current location
(INCREMENT)
@currentloc
M=M+1

//Test if we are at KBD address, restart painting
(TEST)
@KBD
D=A
@currentloc
D=D-M
@RESTART
D;JEQ
@START
0;JMP