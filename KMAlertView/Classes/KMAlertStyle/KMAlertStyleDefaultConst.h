//
//  KMAlertStyleDefaultConst.h
//  KMAlertView
//
//  Created by KM on 2018/2/5.
//

#import <Foundation/Foundation.h>

#define KM_Color(r,g,b,a) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a]

#define KMColor(r,g,b) KM_Color(r,g,b,1)

#pragma mark - Button

#define kKMAlertButtonFont [UIFont systemFontOfSize:17]

#define kKMAlertButtonTextColor KMColor(30, 144, 255)

#define kKMAlertButtonHighlightTextColor KMColor(30, 144, 255)

#define kKMAlertButtonBackgroundColor [UIColor whiteColor]

#define kKMAlertButtonHighlightBackgroundColor KMColor(230, 230, 230)

#define kKMAlertButtonHeight 44.0

#pragma mark - AlertView

#define kKMAlertViewWidth 280

#define kKMAlertViewCornerRadius 13.0

#define kKMAlertViewBackgroundColor [UIColor whiteColor]

#define kKMAlertViewMinInsets UIEdgeInsetsMake(30, 60, 30, 60)

#define kKMAlertViewMultipleButtonMinHeight 70

#pragma mark - Alert Title

#define kKMAlertTitleFont [UIFont systemFontOfSize:17]

#define kKMAlertTitleTextColor KMColor(40, 40, 40)

#define kKMAlertTitleBackgroundColor [UIColor clearColor]

#define kKMAlertTitleTextAlignment NSTextAlignmentCenter

#define kKMAlertTitleMinHeight 40.0

#define kKMAlertTitleInsets UIEdgeInsetsMake(10, 20, 10, 20)

#define kKMAlertTitleText @"这里是Title"

#pragma mark - Alert Message

#define kKMAlertMessageFont [UIFont systemFontOfSize:15]

#define kKMAlertMessageTextColor KMColor(88, 88, 88)

#define kKMAlertMessageBackgroundColor [UIColor clearColor]

#define kKMAlertMessageTextAlignment NSTextAlignmentCenter

#define kKMAlertMessageMinHeight 30.0

#define kKMAlertMessageInsets UIEdgeInsetsMake(10, 25, 10, 25)

#define kKMAlertMessageText @"这里是message"

#pragma mark - Alert Separator

#define kKMAlertSeparatorMainHorizontalHeight 0.5

#define kKMAlertSeparatorHorizontalColor KMColor(160, 160, 160)

#define kKMAlertSeparatorVerticalColor KMColor(190, 190, 190)

#pragma mark - Alert Animate

#define kKMAlertAnimateInDuration 0.35

#define kKMAlertAnimateOutDuration 0.35

#define kKMAlertAnimateSpringDamping 0.75

#define kKMAlertAnimateSpringVelocity 1.0

#define kKMAlertAnimateAngle 30

#pragma mark - Alert Background

#define kKMAlertBackgroundAlpha 0.5

#define kKMAlertBackgroundColor KMColor(50, 50, 50)

#pragma mark - Alert Shadow

#define kKMAlertShadowColor KM_Color(0, 0, 0, 0.35)

#define kKMAlertShadowRadius 20

#define kKMAlertShadowOpacity 1

#define kKMAlertShadowOffset CGSizeMake(0, 10)
