Swift-2048
================

iOS drop-in library presenting a clean-room Swift/UIKit implementation of the game 2048.

Game logic is written in Swift, the GUI in UIKit. The entire GUI is written in code.

The core is decoupled from the GUI using the protocol delegate pattern, so it is easy to pull the code, extract the core and then build a new GUI around it.

Screenshot
----------

Instructions
------------
The included sample app demonstrates the game. Simply tap the button to play. Swipe to move the tiles. For additional fun try tweaking the parameters.


Features
--------
- 2048, the tile-matching game, but native for iOS
- Configure size of game board (NxN square) and winning threshold
- Choose between button controls, swipe gesture controls, or both
- Scoring system
- Pretty animations, all done without SpriteKit

Future Features
---------------
- Better win/lose screens than UIAlertViews
- Actual library (rather than raw code hanging off a sample view controller)

License
-------
(c) 2023 Joe George. Released under the terms of the MIT license.

2048 by Gabriele Cirulli (http://gabrielecirulli.com/). The original game can be found at http://gabrielecirulli.github.io/2048/, as can all relevant attributions. 