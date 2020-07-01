# YTS

Movie browser app written in Swift 5 using [YTS APIs](https://yts.mx/api).

[![swift-version](https://img.shields.io/badge/swift-5.1-brightgreen.svg)](https://github.com/apple/swift)
[![xcode-version](https://img.shields.io/badge/xcode-11-brightgreen)](https://developer.apple.com/xcode/)
[![rxswift](https://img.shields.io/badge/rxswift-5.1.1-brightgreen)](https://github.com/ReactiveX/RxSwift)
[![license](https://img.shields.io/badge/license-mit-brightgreen.svg)](https://en.wikipedia.org/wiki/MIT_License)
[![blog](https://img.shields.io/badge/blog-techkoronå-brightgreen)](https://techkoronaa.blogspot.com/)


![](yts.gif)

## Supports

iOS 11+


## Pods Used

YTS uses number of open source dependencies to for its magic 

* [Alamofire](https://github.com/Alamofire/Alamofire)
* [RxSwift](https://github.com/ReactiveX/RxSwift)
* [NotificationBannerSwift](https://github.com/Daltron/NotificationBanner)
* [Swinject](https://github.com/Swinject/Swinject)
* [SwinjectStoryboard](https://github.com/Swinject/SwinjectStoryboard)
* [SkeletonView](https://github.com/Juanpe/SkeletonView)
* [Cosmos](https://github.com/evgenyneu/Cosmos)
* [Kingfisher](https://github.com/onevcat/Kingfisher)


### Note:
I had to tweak [NotificationBannerSwift](https://github.com/Daltron/NotificationBanner) a little bit to avoid a crash. So if in case you do a `pod install` make sure to do the following change in BaseNotificationBanner.swift file,

```swift
/// The main window of the application which banner views are placed on
    private let appWindow: UIWindow? = {
        var window:UIWindow? = UIApplication.shared.keyWindow
        if window == nil{
            // Fetching window for iOS 13
            if #available(iOS 13.0, *) {
                window = UIApplication.shared.windows.filter({$0.windowScene?.activationState == .foregroundActive}).first!
            }
        }
        return window
    }()
    
```

## Contributing
Pull requests are welcome. For major changes, please open an issue first to discuss what you would like to change.

## License
[MIT](https://github.com/Koronaa/YTS/blob/master/LICENSE)

