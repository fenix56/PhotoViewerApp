# PhotoViewerApp

Application created to demonstrate [my](https://github.com/fenix56) expertise in Swift and iOS development. Two main frameworks that project uses are:
**[PhotoKit](https://developer.apple.com/documentation/photokit)** and **[Vision](https://developer.apple.com/documentation/vision)**. App use MVVM-C architectural design pattern, for this app complexity is a bit overkill, but I wanted to show my knowledge in that topic as well. Also I've created simple unit tests for *PhotoCollectionViewModel*. The app has 2 screens which will be described below:

## Home Screen
On the start of app you should see this screen:

![MacDown Screenshot](https://snipboard.io/TFmUSH.jpg)

Using PhotoKit framework I'm displaying the user's most recent 1000 photos in a grid.

## Photo Viewer
When user taps a cell in the grid, next screen shows with a full-screen view of the photo:

![MacDown Screenshot](https://snipboard.io/j1zg5p.jpg)

I'm using the Vision framework to analyse attention-based saliency for the image and displaying the bounding box returned to draw a red rectangle around the salient portion of the image. A button in the navigation bar toggles the image between aspect fit and aspect fill:

![MacDown Screenshot](https://snipboard.io/e2pKIT.jpg)

# Summary
I wrote this application in a few hours, but if I had spent a more time on it, I would certainly have experimented more with the Vision framework and add more coverage with unit tests. Also I would add more advanced annimations to image and rectangle aspect transitions. The part of code I would hightlight is 2 files located in Utility folder:

1. *UIImageView+Extension* - there is actual **Vision** framework usage which is Attention Based Saliency and show it as an area in red rectagle. 
2. *PhotoManager* - there is all photo caching and fetching logic from **PhotoKit** framework.
