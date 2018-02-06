# KMAlertView
一款自定义的AlertView


## What’s it look like?

### NoneBlur

<img src="https://github.com/hkm5558/KMAlertView/blob/master/Screenshot/NoneBlur1.png" width="192"> <img src="https://github.com/hkm5558/KMAlertView/blob/master/Screenshot/NoneBlur2.png" width="192"> <img src="https://github.com/hkm5558/KMAlertView/blob/master/Screenshot/NoneBlur3.png" width="192"> <img src="https://github.com/hkm5558/KMAlertView/blob/master/Screenshot/NoneBlur4.png" width="192"> <img src="https://github.com/hkm5558/KMAlertView/blob/master/Screenshot/NoneBlur5.png" width="192">

### LightBlur
<img src="https://github.com/hkm5558/KMAlertView/blob/master/Screenshot/LightBlur1.png" width="192"> <img src="https://github.com/hkm5558/KMAlertView/blob/master/Screenshot/LightBlur2.png" width="192"> <img src="https://github.com/hkm5558/KMAlertView/blob/master/Screenshot/LightBlur3.png" width="192"> <img src="https://github.com/hkm5558/KMAlertView/blob/master/Screenshot/LightBlur4.png" width="192"> <img src="https://github.com/hkm5558/KMAlertView/blob/master/Screenshot/LightBlur5.png" width="192">

### DarkBlur
<img src="https://github.com/hkm5558/KMAlertView/blob/master/Screenshot/DarkBlur1.png" width="192"> <img src="https://github.com/hkm5558/KMAlertView/blob/master/Screenshot/DarkBlur2.png" width="192"> <img src="https://github.com/hkm5558/KMAlertView/blob/master/Screenshot/DarkBlur3.png" width="192"> <img src="https://github.com/hkm5558/KMAlertView/blob/master/Screenshot/DarkBlur4.png" width="192"> <img src="https://github.com/hkm5558/KMAlertView/blob/master/Screenshot/DarkBlur5.png" width="192">


## Animate

<img src="https://github.com/hkm5558/KMAlertView/blob/master/Screenshot/ScaleInScaleOut.gif" width="192"> <img src="https://github.com/hkm5558/KMAlertView/blob/master/Screenshot/TopInBottomOut.gif" width="192"> <img src="https://github.com/hkm5558/KMAlertView/blob/master/Screenshot/LeftInRightOut.gif" width="192"> <img src="https://github.com/hkm5558/KMAlertView/blob/master/Screenshot/Angle.gif" width="192">

## Installation with CocoaPods

[CocoaPods](http://cocoapods.org) is a dependency manager for Objective-C, which automates and simplifies the process of using 3rd-party libraries. You can install it with the following command:

```bash
$ gem install cocoapods
```
#### Podfile

To integrate KMUIMaker into your Xcode project using CocoaPods, specify it in your `Podfile`:

In your Podfile
>`pod 'KMAlertView'`

Then, run the following command:

```bash
$ pod install
```
## Requirements

This library requires `iOS 8.0+`

## Installation

KMAlertView is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod "KMAlertView"
```
## Requirements

This library requires `iOS 8.0+`

## Usage


```obj-c

    ///Title only
    [KMAlertView showAlertWithTitle:@"Title only"];

    ///Message only
    [KMAlertView showAlertWithMessage:@"Message only"];
    
    ///Title & Message & CallBackBlock
    [KMAlertView showAlertWithTitle:self.shortTitle message:self.shortMessage callBackBlock:^(NSInteger buttonIndex, NSString *buttonTitle) {
    
    }];
    
    ///Title & Message & ButtonTitles & CallBackBlock
    [KMAlertView showAlertWithTitle:@"Title" message:@"Message" buttonTitles:@[@"button1", @"button2"] callBackBlock:^(NSInteger buttonIndex, NSString *buttonTitle) {
    
    }];
    
    ///Setting With StyleConfigBlock
    [KMAlertView showAlertWithStyleConfigBlock:^KMAlertStyle *(KMAlertStyle *alertStyle) {
        return [KMAlertStyle new];
    } callBackBlock:^(NSInteger buttonIndex, NSString *buttonTitle) {
    
    }];
    
    ///ButtonTitles & StyleConfigBlock
    [KMAlertView showAlertWithButtonTitles:@[@"button1", @"button2"] styleConfigBlock:^KMAlertStyle *(KMAlertStyle *alertStyle) {
        return [KMAlertStyle new];
    } callBackBlock:^(NSInteger buttonIndex, NSString *buttonTitle) {
    
    }];
    
    ///AlertView Dismiss
    [alertView dismissWithCompletion:^{
    
    }];

```

## Author

hkm5558, SZHuangKM@163.com

## License

KMAlertView is available under the MIT license. See the LICENSE file for more info.
