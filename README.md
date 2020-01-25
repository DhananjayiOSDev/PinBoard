# PinBoard

This repository is used to demostrate the sample application development challenge from recruitment firm.

## Task 

Imagine you are on the Pinterest iOS team and you are working with some colleagues on the pinboard (the scrolling wall of images), you split up the tasks among each other and your task is to create an image loading library that will be used to asynchronously download the images for the pins on the pinboard when they are needed.
The library will also be useful for all other parts of the app where asynchronous remote image loading is required. The images are available on a publicly accessible URL (like a CDN). The library should be general purpose and not assume anything about the use case, the pinboard is an example but other parts of the app that show images will also use it (e.g. a user's profile pic on the profile screen).
One of your colleagues will also want to use the library for loading JSON documents, and you just know that your boss and colleagues will love your library so much that they will ask you to support other data types in the future as well, so your design should not limit support to a particular data type.
The purpose of the library is to abstract the downloading (images, pdf, zip, etc) and caching of remote resources (images, JSON, XML, etc) so that client code can easily "swap" a URL for any kind of files ( JSON, XML, etc) without worrying about any of the details. Resources which are reused often should not be continually re-downloaded and should be cached, but the library cannot use infinite memory.

## Project Structure

We have used the MVC designe pattern for the development of this sample application also created the seperate framework [MVDownloader](https://github.com/DhananjayiOSDev/MVDownloader), This will be a reusable framework component. Following will be a project structure for the current application and MVDownloader framework.

[MVDownloader](https://github.com/DhananjayiOSDev/MVDownloader)	
Please see following source code structure for MVDownloader framework. There are 3 main classes are used to create the framework.

![MVDownloader](https://github.com/DhananjayiOSDev/PinBoard/blob/master/ScreenShots/MVDownloader.png)

1. MVDownloader.swift : This class contains the all methods for MVDownloder framework such configureCacheLimit, downloadImage etc.
2. MVNetworkHandler.swift : This class is used to implement actual URSession task methods and delegates for fetching the data from remote server.
3. MVAPIWrapper.swift : This class is used to comunication between network handler class and controllers and viewmodels.

We can integrate this framework using the cocoapods dependancy manager.

pod 'MVDownloader', :git => 'https://github.com/DhananjayiOSDev/MVDownloader.git'

PinBoard Project

Please see the detail project structure for the PinBoard project, Source code structure is divided into three layers i.e. ApplicationLayer, BusinessLayer, DataAccessLayer

![PinBoard](https://github.com/DhananjayiOSDev/PinBoard/blob/master/ScreenShots/PinBoard.png)

1. ApplicationLayer : This group consist the viewcontrollers, constants, customviews(like UITableviewcells), resourcesetc.
2. BusinessLayer : This group consist the all Models, Utilities and custom classes.
3. DataAccessLayer : This group consist the Wrappers and Network function classes.

Actual PinBoard functionality is implemented into the PBGalleryViewController.swift in which pin image details are fetched from server and listed it in UITableView.

Functionalities Covered:

● Loaded the pin image details from following remote server URL: http://pastebin.com/raw/wgkJgazE
● Images and JSON are cahced to memory using MVDownloader DownloadCache
● The cache should have a configurable max capacity using configureCacheLimit function of MVDownloader.
● Implemented the function for cancelling current download.
● The same image may be requested by multiple sources.
● Multiple parallel images downloading.
● Pull to refresh functionality.
● Pagination functionality is implemented upto 100 pin records with loading 10 records each time.

Third Party Libraries Used

[SwiftyJson](https://github.com/SwiftyJSON/SwiftyJSON)

[Toast-Swift](https://github.com/scalessec/Toast-Swift)


