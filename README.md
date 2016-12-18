# MyFlickrSearchApp

## What is MyFlickrSearchApp?
This app is the result of a programming assignment with as task to write an app you think is production ready that works as a client app for Flickr.

## Requirements

### Functional requirements
1. the app must use the [Flickr API](https://www.flickr.com/services/api/) to allow user searching for photos with specific words
2. the app must show the results of the search in an infinite scroll list where each cell contains at least a photo
3. when tapping on a cell the user of the app must see the full screen photo and its details

### Non-functional requirements
1. The deliverable must include the full project and a README.txt file describing how to build it and other relevant informations
2. Any third party library can be used. The README.txt must contain a brief description of the library and the reason it is used.
3. Android apps must be built using Java or Kotlin. iOS must be built using Objective-C or Swift
4. Even though the app is not an exercise of design, the app must show common UI paradigms of the platform
5. Within the requirements there’s complete freedom to be creative and add details

# Release history

## Version 1.0 Build 1

### Description
First version, with very basic functionality up and running. It is possible to search for photos with specific keywords. The results of a search are displayed in an infinite scroll list where each cell contains the title and a photo. When tapping on a cell, the user can see the full screen photo with zoom and pan possibilities. Details of the photo are not retrieved in this version.

### Not fullfilled requirements:
* Details of the picture are not retrieved

### Added details:
* Panning and zooming in detailled view

### Known limitations:
* There is no feedback to the user, when e.g. the search didn't return any photo's or for any other error
* Unit test cover only one very basic class

### Future enhancements: 
* Move model into a framework which is used by the application
* Memory management: only keep information cached which is visible and a few pages before and after view instead of reducing memory (i.e. throw all retrieved pages away) on a low memory warning - note that the Flickr search api returns at most the first 4.000 results and as we don't story the pictures, memory usage is not that high
* Code to retrieve minitures and full pictures is very simular, could be make a more generic function?

# Building the App

## Build environment
* XCode Version 8.1 (8B62), running on macOS Sierra version 10.12.1

## Used libraries
* Apple: essential Frameworks to build an iOS app
 * UIKit: See [Apple Developer](https://developer.apple.com/reference/uikit) for more information
 * Foundation: See [Apple Developer](https://developer.apple.com/reference/foundation) for more information
* Other: none
 * Other frameworks are not included because in such a simple app as this one they would only increase the project's complexity and dependencies. When sticking to the Apple Frameworks, maintainebility will be easier.
 * Flickr API Kits for Objective-C are available, but outdated and also would only increase the project's complexity and dependencies.
 
## Deployement target
* iOS 10.1
* Devices: iPhone

# Acknowledgments
* [Developing iOS 9 Apps with Swift](https://itunes.apple.com/us/course/developing-ios-9-apps-swift/id1104579961)
