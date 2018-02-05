//
//  KMAlertStyle.m
//  KM_Kit
//
//  Created by KM on 2017/6/14.
//  Copyright © 2017年 黄昆明. All rights reserved.
//

#import "KMAlertStyle.h"


#pragma mark - KMAlertStyleAlertView
@implementation KMAlertStyleAlertView
-(void)setWidth:(CGFloat)width{
    if (_width > 0 &&(_minInsets.left > 0 || _minInsets.right > 0)) {
        CGFloat maxWidth = [UIScreen mainScreen].bounds.size.width - _minInsets.left - _minInsets.right;
        width = width > maxWidth ? maxWidth : width;
    }
    _width = width;
}
@end

#pragma mark - KMAlertStyleTitle
@implementation KMAlertStyleTitle

@end

#pragma mark - KMAlertStyleMessage
@implementation KMAlertStyleMessage

@end

#pragma mark - KMAlertStyleSeparator
@implementation KMAlertStyleSeparator

@end

#pragma mark - KMAlertStyleAnimate
@implementation KMAlertStyleAnimate

@end

#pragma mark - KMAlertStyleBackground
@implementation KMAlertStyleBackground

@end

#pragma mark - KMAlertStyleShadow
@implementation KMAlertStyleShadow

@end

#pragma mark - KMAlertStyleButton

@implementation KMAlertStyleButton

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self defaultStyle];
    }
    return self;
}
-(void)defaultStyle{
    self.font = kKMAlertButtonFont;
    self.textColor = kKMAlertButtonTextColor;
    self.highlightTextColor = kKMAlertButtonHighlightTextColor;
    self.backgroundColor = kKMAlertButtonBackgroundColor;
    self.highlightBackgroundColor = kKMAlertButtonHighlightBackgroundColor;
    self.height = kKMAlertButtonHeight;
}

@end

#pragma mark - KMAlertStyle
@implementation KMAlertStyle

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self useDefalutStyle];
    }
    return self;
}

-(void)useDefalutStyle{
    KMAlertStyleAlertView *alertView = [KMAlertStyleAlertView new];
    alertView.width = kKMAlertViewWidth;
    alertView.cornerRadius = kKMAlertViewCornerRadius;
    alertView.backgroundColor = kKMAlertViewBackgroundColor;
    alertView.minInsets = kKMAlertViewMinInsets;
    alertView.multipleButtonMinHeight = kKMAlertViewMultipleButtonMinHeight;
    
    KMAlertStyleTitle *title = [KMAlertStyleTitle new];
    title.font = kKMAlertTitleFont;
    title.textColor = kKMAlertTitleTextColor;
    title.backgroundColor = kKMAlertTitleBackgroundColor;
    title.textAlignment = kKMAlertTitleTextAlignment;
    title.minHeight = kKMAlertTitleMinHeight;
    title.insets = kKMAlertTitleInsets;
    title.text = kKMAlertTitleText;
    
    KMAlertStyleMessage *message = [KMAlertStyleMessage new];
    message.font = kKMAlertMessageFont;
    message.textColor = kKMAlertMessageTextColor;
    message.backgroundColor = kKMAlertMessageBackgroundColor;
    message.textAlignment = kKMAlertMessageTextAlignment;
    message.minHeight = kKMAlertMessageMinHeight;
    message.insets = kKMAlertMessageInsets;
    message.text = kKMAlertMessageText;
    
    KMAlertStyleSeparator *separator = [KMAlertStyleSeparator new];
    separator.horizontalWidth = alertView.width;
    separator.mainHorizontalHeight = kKMAlertSeparatorMainHorizontalHeight;
    separator.horizontalColor = kKMAlertSeparatorHorizontalColor;
    separator.verticalColor = kKMAlertSeparatorVerticalColor;
    
    KMAlertStyleAnimate *animate = [KMAlertStyleAnimate new];
    animate.animateInDuration = kKMAlertAnimateInDuration;
    animate.animateOutDuration = kKMAlertAnimateOutDuration;
    animate.bounce = YES;
    animate.springDamping = kKMAlertAnimateSpringDamping;
    animate.springVelocity = kKMAlertAnimateSpringVelocity;
    animate.angle = kKMAlertAnimateAngle;
    animate.inType = KMAlertViewAnimateInTypeAngle;
    animate.outType = KMAlertViewAnimateOutTypeAngle;
    
    KMAlertStyleBackground *background = [KMAlertStyleBackground new];
    background.alpha = kKMAlertBackgroundAlpha;
    background.color = kKMAlertBackgroundColor;
    background.dismissWhenTouchBackground = YES;
    background.blur = YES;
    background.blurStyle = UIBlurEffectStyleLight;
    
    KMAlertStyleShadow *shadow = [KMAlertStyleShadow new];
    shadow.shadow = YES;
    shadow.shadowColor = kKMAlertShadowColor;
    shadow.shadowRadius = kKMAlertShadowRadius;
    shadow.shadowOpacity = kKMAlertShadowOpacity;
    shadow.shadowOffset = kKMAlertShadowOffset;
    
    KMAlertStyleButton *button = [KMAlertStyleButton new];
    button.text = @"确定";
    
    
    self.alertView = alertView;
    self.title = title;
    self.message = message;
    self.separator = separator;
    self.animate = animate;
    self.background = background;
    self.shadow = shadow;
    self.buttons = @[button];
}
-(void)setupButtonsWithTitles:(NSArray<NSString *> *)titles{
    NSMutableArray *arrayM = @[].mutableCopy;
    for (NSString *title in titles) {
        KMAlertStyleButton *buttonStyle = [KMAlertStyleButton new];
        buttonStyle.text = title;
        [arrayM addObject:buttonStyle];
    }
    self.buttons = arrayM.copy;
}
@end
