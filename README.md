![Introduction](https://github.com/ncsouvenir/Pandemonium/blob/dev-Nicole/Gif/Screen%20Shot%202018-03-17%20at%203.59.59%20PM.png)

![alt text](https://github.com/ncsouvenir/Pandemonium/blob/qa/GIF1.gif)
![alt text](https://github.com/ncsouvenir/Pandemonium/blob/qa/GIF2.gif)

## Features
- User Authentication
- Creating posts and comments to interact with other users
- Editing posts and comments
- Ability to critique others with an upvoting and downvoting system
- Editing User profile images and usernames
- Being able to switch the app into "night mode"

## Requirements
- iOS 8.0+ / Mac OS X 10.11+ / tvOS 9.0+
- Xcode 9.0+
- Swift 4.0+

## Installation

### CocoaPods
CocoaPods is a dependency manager for Cocoa projects. You can install it with the following command:

`$ sudo gem install cocoapods`

### Pods
- [Firebase](https://firebase.google.com)
- [SnapKit](http://snapkit.io/docs/)
- [Toucan](https://cocoapods.org/pods/Toucan)
- [KingFisher](https://github.com/onevcat/Kingfisher)

### How to Install Pods
To integrate these pods into your Xcode project using CocoaPods, specify it in your Podfile:
```
source 'https://github.com/CocoaPods/Specs.git'
platform :ios, '10.0'
use_frameworks!

target '<Your Target Name>' do
    pod 'Firebase/Core'
    pod 'Firebase/Auth’
    pod 'Firebase/Database’
    pod 'Firebase/Storage'
    pod 'SnapKit'
    pod 'Toucan'
    pod 'Kingfisher'
end
```

Then, run the following command in Terminal:

`$ pod install`

## Technologies and Design Patterns

- Firebase as a back-end service
- Dependency Injection
- Custom Delegation
- Programmatic AutoLayout



## Future Updates
In continuing to iterate on this project I would like to do the following:

- Adding functionality for flagging and reporting users
- Re-factor the UI/UX for better user experience



## Contributors

- **Project Manager**: Reiaz Gafar - [GitHub](https://github.com/reiaz-gafar)
- **Tech Lead**: Nicole Souvenir - [GitHub](https://github.com/ncsouvenir)
- **UI/UX**: Nathan Rosario - [GitHub](https://github.com/NateMRosario)
- **QA**: Yaseen Aldellesh - [GitHub](https://github.com/Yaseen-al)
