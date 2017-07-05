//
//  KMAlertStyle.h
//  KM_Kit
//
//  Created by KM on 2017/6/14.
//  Copyright © 2017年 黄昆明. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, KMAlertViewAnimateInType) {
    KMAlertViewAnimateInTypeScale = 0,
    KMAlertViewAnimateInTypeTop,
    KMAlertViewAnimateInTypeLeft,
    KMAlertViewAnimateInTypeBottom,
    KMAlertViewAnimateInTypeRight,
    KMAlertViewAnimateInTypeAngle
};

typedef NS_ENUM(NSUInteger, KMAlertViewAnimateOutType) {
    KMAlertViewAnimateOutTypeScale = 0,
    KMAlertViewAnimateOutTypeTop,
    KMAlertViewAnimateOutTypeLeft,
    KMAlertViewAnimateOutTypeBottom,
    KMAlertViewAnimateOutTypeRight,
    KMAlertViewAnimateOutTypeAngle
};




#pragma mark - KMAlertStyleAlertView

@interface KMAlertStyleAlertView : NSObject
/** AlertView Width */
@property (nonatomic, assign) CGFloat width;
/** AlertView CornerRadius*/
@property (nonatomic, assign) CGFloat cornerRadius;
/** AlertView BackgroundColor*/
@property (nonatomic, strong) UIColor * backgroundColor;
/** AlertView MinInsets */
@property (nonatomic, assign) UIEdgeInsets minInsets;
/** AlertView MultipleButtonMinHeight */
@property (nonatomic, assign) CGFloat multipleButtonMinHeight;

@end


#pragma mark - KMAlertStyleTitle

@interface KMAlertStyleTitle : NSObject
/** Title Font */
@property (nonatomic, strong) UIFont * font;
/** Title TextColor */
@property (nonatomic, strong) UIColor * textColor;
/** Title BackgroundColor */
@property (nonatomic, strong) UIColor * backgroundColor;
/** Title MinHeight */
@property (nonatomic, assign) CGFloat minHeight;
/** Title TextAlignment */
@property (nonatomic, assign) NSTextAlignment textAlignment;
/** Title Insets */
@property (nonatomic, assign) UIEdgeInsets insets;
/** Title Text */
@property (nonatomic, copy) NSString * text;

@end

#pragma mark - KMAlertStyleMessage

@interface KMAlertStyleMessage : NSObject
/** Message Font */
@property (nonatomic, strong) UIFont * font;
/** Message TextColor */
@property (nonatomic, strong) UIColor * textColor;
/** Message BackgroundColor */
@property (nonatomic, strong) UIColor * backgroundColor;
/** Message MinHeight */
@property (nonatomic, assign) CGFloat minHeight;
/** Message TextAlignment */
@property (nonatomic, assign) NSTextAlignment textAlignment;
/** Message Insets */
@property (nonatomic, assign) UIEdgeInsets insets;
/** Message Text */
@property (nonatomic, copy) NSString * text;

@end

#pragma mark - KMAlertStyleButton

@interface KMAlertStyleButton : NSObject
/** Button Text */
@property (nonatomic, copy) NSString * text;
/** Button Height */
@property (nonatomic, assign) CGFloat height;
/** Button Font */
@property (nonatomic, strong) UIFont * font;
/** Button TextColor */
@property (nonatomic, strong) UIColor * textColor;
/** Button BackgroundColor */
@property (nonatomic, strong) UIColor * backgroundColor;
/** Button HighlightTextColor */
@property (nonatomic, strong) UIColor *highlightTextColor;
/** Button HighlightBackgroundColor */
@property (nonatomic, strong) UIColor *highlightBackgroundColor;

@end

#pragma mark - KMAlertStyleSeparator

@interface KMAlertStyleSeparator : NSObject
/** Separator HorizontalWidth */
@property (nonatomic, assign) CGFloat horizontalWidth;
/** Separator MainHorizontalHeight */
@property (nonatomic, assign) CGFloat mainHorizontalHeight;
/** Separator HorizontalColor */
@property (nonatomic, strong) UIColor * horizontalColor;
/** Separator VerticalColor */
@property (nonatomic, strong) UIColor * verticalColor;

@end

#pragma mark - KMAlertStyleAnimate

@interface KMAlertStyleAnimate : NSObject
/** Animate InType */
@property (nonatomic, assign) KMAlertViewAnimateInType inType;
/** Animate OutType */
@property (nonatomic, assign) KMAlertViewAnimateOutType outType;
/** Animate Bounce */
@property (nonatomic, assign, getter=isBounce) BOOL bounce;
/** Animate AnimateInDuration */
@property (nonatomic, assign) CGFloat animateInDuration;
/** Animate AnimateOutDuration */
@property (nonatomic, assign) CGFloat animateOutDuration;
/** Animate Angle */
@property (nonatomic, assign) CGFloat angle;
/** Animate SpringDamping */
@property (nonatomic, assign) CGFloat springDamping;
/** Animate SpringVelocity */
@property (nonatomic, assign) CGFloat springVelocity;

@end

#pragma mark - KMAlertStyleBackground

@interface KMAlertStyleBackground : NSObject
/** Background Alpha */
@property (nonatomic, assign) CGFloat alpha;
/** Background Color */
@property (nonatomic, strong) UIColor * color;
/** Background BlurStyle */
@property (nonatomic, assign) UIBlurEffectStyle blurStyle;
/** Background DismissWhenTouchBackground */
@property (nonatomic, assign, getter=isDismissWhenTouchBackground) BOOL dismissWhenTouchBackground;
/** Background Blur */
@property (nonatomic, assign, getter=isBlur) BOOL blur;

@end

#pragma mark - KMAlertStyleShadow
@interface KMAlertStyleShadow : NSObject
/** Shadow Shadow*/
@property (nonatomic, assign, getter=isShadow) BOOL shadow;
/** Shadow ShadowColor */
@property (nonatomic, strong) UIColor * shadowColor;
/** Shadow ShadowRadius */
@property (nonatomic, assign) CGFloat shadowRadius;
/** Shadow ShadowOpacity */
@property (nonatomic, assign) CGFloat shadowOpacity;
/** Shadow ShadowOffset */
@property (nonatomic, assign) CGSize shadowOffset;

@end

#pragma mark - KMAlertStyle
@interface KMAlertStyle : NSObject

@property (nonatomic, strong) KMAlertStyleAlertView * alertView;

@property (nonatomic, strong) KMAlertStyleTitle * title;

@property (nonatomic, strong) KMAlertStyleMessage * message;

@property (nonatomic, strong) KMAlertStyleSeparator * separator;

@property (nonatomic, strong) KMAlertStyleAnimate * animate;

@property (nonatomic, strong) KMAlertStyleBackground * background;

@property (nonatomic, strong) KMAlertStyleShadow * shadow;

@property (nonatomic, copy) NSArray<KMAlertStyleButton *> * buttons;

-(void)setupButtonsWithTitles:(NSArray<NSString *> *)titles;

@end
