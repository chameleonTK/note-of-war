# Note of War

An interactive game developing with [Processing](https://processing.org/) and [Phidgets](https://www.phidgets.com/?). It is inspired by the actual tug of war game which two teams on opposite side of a rope pull against each other to seize the opposite. In the game, players use loud voice as a rhythm to harmonize the team. Note of war mimics these tactics, but instead of using physical strength, but it uses voice, calculates the score and then adjust the position of each team.

The game is developed using [Processing](https://processing.org/) as a tools for building an interactive interface. To connect digital world with sensors and motors, I use the game with [Phidgets](https://www.phidgets.com/?) as an input device which it will connect with several sensors including a sound sensor, an indoor light sensor and a temperature sensor.

It is an part of [CS5041](https://info.cs.st-andrews.ac.uk/student-handbook/modules/CS5041.html) at University of St. Andrews.

## Features
 * Multiplayer game
 * Non-linear score systems; motivate players to cooperate and induce more creative strategy
 * Physical Interaction
 * Multiple gameplay with different sensors
     * Recieving voice with sound sensor
     * Pushing a button (light sensor) to get extra energy
     * Rubbing a temperature sensor to get score when the screen changes into the blinking screen.

![](img/game.gif)

[Demo Video](https://www.youtube.com/watch?v=Jo-9-EmQlL0)

## Running

1. Install [Processing IDE 3.x](https://processing.org/download/)
2. Clone thie repo `https://github.com/chameleonTK/note-of-war` and open `NoteOfWar.pde` as an entry file.
3. Connect Phidget and its sensors.
4. Open `ScoreHandler.pde` and set up `port` and `channel` for each sensor. 

## Requirements

* Phidget
* Phidget Sound Sensor [link](https://www.phidgets.com/?prodid=106) x2
* Phidget Indoor light sensor [link](https://www.phidgets.com/?tier=3&catid=8&pcid=6&prodid=115) x2
* Phidget temperature sensor [link](https://www.phidgets.com/?tier=3&catid=14&pcid=12&prodid=95) x2
* LED and standard resistor x2

* Processing 3.x
* `phidgets22.jar`; see [documentation](https://www.phidgets.com/?view=api)
* `gifAnimation.jar` for Processing 3.x; see [github](https://github.com/akiljohnson1/GifAnimation)

## Resource
* 2D Pixel Art Skeletal Warrior from https://elthen.itch.io/2d-pixel-art-skeletal-warrior *NOT Free*

## How it work
It is quite messy. Explain later


### Todos
 * Use a different high/low, loud/soft sound for new gameplay
 * Big Refactor

## Author
[Pakawat Nakwijit](http://curve.in.th); An ordinary programmer who would like to share and challange himself. It is a part of my 2018 tasks to open source every projects in my old treasure chest with some good documentation. 

## License
This project is licensed under the terms of the MIT license.




