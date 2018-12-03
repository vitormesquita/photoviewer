# Photo Viewer

A photo viewer application which consumes a third-party photos API. Basically the application has 3 features:

- List the newest photos uploaded on API
- Search by a photo 
- Show the photo's details which can be downloaded to your photo library. 

There are some improvies that I would like to do if I have more time. Which are:

- Dynamic `UICollectionViewCell`'s height by photo (as Pinterest)
- More photo's info like related collections
- A section of favorites photos (maybe save in a local database)
- User session to interact more with API for example likes photos, upload new photos and follow people 

The API that I've used to build these project is from [https://unsplash.com](https://unsplash.com) and I've used just requests that don't need to be authenticated. It returns to me not optimized photos, so the app on debug can appear consuming more memory than others photo viewer apps.

In this project the iOS stack was:

- Swift 4.2
- Xcode 10.1
- VIPER architecture with MVVM concepts
- Rective programming using `RxSwift`

## Installation

To build project you have to be installed [Cocoapods](https://cocoapods.org/) to manager all dependencies. If you don't have just run this command line on your shell:

```
$ sudo gem install cocoapods
```

After install cocoapods enter in project path and run this command line:

```
$ pod install
```

After that open `PhotoViewer.xcworkspace` and now you can run the project.

## Architecture concept

I've used MVVM concept, it's update itself (one way binding), so every class just will be updated itself and the class that is observing these updates will do that need to do and so I chose to use `RxSwift` to oberving these updates easily.

In VIPER it's normal to use `Input` and `Output` protocols, but I think use one way binding is better to understand and the code becomes clearer.

## Outsource libraries

I've used a couple of outsource libriries to gain time by developing the main feature. Which are:

- `RxSwift` to be a more flexible code and easy to apply MVVM concepts.
- `RxCocoa` to make some cocoa components reactive to be easier integrate with RxSwift events;
- `Moya/RxSwift` is an easy network abstration layer to make request to API and transforming it on a Rx singal;
- `Mextension` my own library that contains a couple of extensions that I always use in my projects;
- `INSPullToRefresh` to facilitate my infinity list pagination. 

I am fully enable doing projects without using these libraries, but I prefer use them because I don't have much time and I think code be more clear and easy to be maitanable. 

