# Swift-2048

iOS drop-in library presenting a clean-room Swift/UIKit implementation of the game 2048.

Game logic is written in Swift, the GUI in UIKit. The entire GUI is written in code.

The core is decoupled from the GUI using the protocol delegate pattern, so it is easy to pull the code, extract the core and then build a new GUI around it.

### Screenshots
----------
<p align="center">
  <img src="https://github.com/joafc96/swift-2048/blob/main/swift-2048/Screenshots/dark_2048.png" alt="screenshot_dark" width="220" height="480"/>
  <img src="https://github.com/joafc96/swift-2048/blob/main/swift-2048/Screenshots/light_2048.png" alt="screenshot_light" width="220" height="480"/>
</p>

### Features
--------
- 2048, the tile-matching game, but native for iOS
- Configure size of game board (NxN square) and winning threshold
- Scoring system
- Pretty animations, all done without SpriteKit

### Contributing
-------
Changes and improvements are more than welcome! Feel free to fork and open a pull request. Please make your changes in a specific branch and request to pull into `main`! If you can, please make sure the game fully works before sending the PR, as that will help speed up the process.

### License
-------
Released under the terms of the [MIT license](https://github.com/uberspot/2048-android/blob/master/LICENSE).

2048 by Gabriele Cirulli (http://gabrielecirulli.com/). The original game can be found at http://gabrielecirulli.github.io/2048/, as can all relevant attributions. 

### Donations
-------
I made this in my spare time, but if you enjoyed the game and feel like buying me coffee, you can donate at my BTC address: `3KgkUHSGqsNEiSQJ4mid5PmraxugtdBBQP`. Thank you very much!