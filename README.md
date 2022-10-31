# PhotoViewerApp

Application created to demonstrate [my](https://github.com/fenix56) expertise in Swift and iOS development. App use MVVM-C architectural design pattern, for this app complexity is a bit overkill, but I wanted to show my knowledge in that topic as well. App has 2 screens which will be described below:

## Home Screen
On the start of app you should see this screen:

![MacDown Screenshot](https://snipboard.io/TFmUSH.jpg)

Using PhotoKit framework I'm displaying the user's most recent 1000 photos in a grid.

## Photo Viewer
When user taps a cell in the grid, next screen shows with a full-screen view of the photo:

![MacDown Screenshot](https://snipboard.io/XMK2Ph.jpg)

I'm using the Vision framework to analyse attention-based saliency for the image and displaying the bounding box returned to draw a red rectangle around the salient portion of the image. A button in the navigation bar toggles the image between aspect fit and aspect fill:

![MacDown Screenshot](https://snipboard.io/GjeK0F.jpg)

# Summary
I wrote this application in a few hours, but if I had spent a more time on it, I would certainly have experimented more with the Vision framework. Also I would add more advanced annimations to image and rectangle aspect transitions. The part of code I would hightlight is *UIImageView+Extension* file in **Utility** folder. I've implemented there actual image request from PhotoKit method and Vision framework usage.
