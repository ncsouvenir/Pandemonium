# Pandemonium

## Overview
This app lets you make posts on a prestine thread, dedicated to keeping you up to date with recent events.

## Features
- User Authentication
- Creating Posts
- Creating Comments
- Upvotes and Downvotes
- Editing Posts and Comments
- Editing User Profiles

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


## Credits 
- **Project Manager**: Reiaz Gafar - [GitHub](https://github.com/reiaz-gafar)
- **Tech Lead**: Nicole Souvenir - [GitHub](https://github.com/ncsouvenir)
- **UI/UX**: Nathan Rosario - [GitHub](https://github.com/NateMRosario)
- **QA**: Yaseen Aldellesh - [GitHub](https://github.com/Yaseen-al)
