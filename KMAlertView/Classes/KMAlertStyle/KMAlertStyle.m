//
//  KMAlertStyle.m
//  KM_Kit
//
//  Created by KM on 2017/6/14.
//  Copyright © 2017年 黄昆明. All rights reserved.
//

#import "KMAlertStyle.h"

#define KM_Color(r,g,b,a) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a]

#define KMColor(r,g,b) KM_Color(r,g,b,1)


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
    self.font = [UIFont systemFontOfSize:17];
    self.textColor = KMColor(30, 144, 255);
    self.highlightTextColor = KMColor(30, 144, 255);
    self.backgroundColor = [UIColor whiteColor];
    self.highlightBackgroundColor = KMColor(230, 230, 230);
    self.height = 44.0;
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
    alertView.width = 280;
    alertView.cornerRadius = 13;
    alertView.backgroundColor = [UIColor whiteColor];
    alertView.minInsets = UIEdgeInsetsMake(30, 60, 30, 60);
    alertView.multipleButtonMinHeight = 70;
    
    KMAlertStyleTitle *title = [KMAlertStyleTitle new];
    title.font = [UIFont systemFontOfSize:17];
    title.textColor = KMColor(40, 40, 40);
    title.backgroundColor = [UIColor clearColor];
    title.textAlignment = NSTextAlignmentCenter;
    title.minHeight = 40;
    title.insets = UIEdgeInsetsMake(10, 20, 10, 20);
    title.text = @"这里是title";
    
    KMAlertStyleMessage *message = [KMAlertStyleMessage new];
    message.font = [UIFont systemFontOfSize:15];
    message.textColor = KMColor(88, 88, 88);
    message.backgroundColor = [UIColor clearColor];
    message.textAlignment = NSTextAlignmentCenter;
    message.minHeight = 30;
    message.insets = UIEdgeInsetsMake(10, 25, 10, 25);
    message.text = @"这里是message";
    
    KMAlertStyleSeparator *separator = [KMAlertStyleSeparator new];
    separator.horizontalWidth = alertView.width;
    separator.mainHorizontalHeight = 0.5;
    separator.horizontalColor = KMColor(160, 160, 160);
    separator.verticalColor = KMColor(190, 190, 190);
    
    KMAlertStyleAnimate *animate = [KMAlertStyleAnimate new];
    animate.animateInDuration = 0.5;
    animate.animateOutDuration = 0.5;
    animate.bounce = YES;
    animate.springDamping = 0.75;
    animate.springVelocity = 1;
    animate.angle = 30;
    animate.inType = KMAlertViewAnimateInTypeAngle;
    animate.outType = KMAlertViewAnimateOutTypeAngle;
    
    KMAlertStyleBackground *background = [KMAlertStyleBackground new];
    background.alpha = 0.5;
    background.color = KMColor(50, 50, 50);
    background.dismissWhenTouchBackground = YES;
    background.blur = YES;
    background.blurStyle = UIBlurEffectStyleLight;
    
    KMAlertStyleShadow *shadow = [KMAlertStyleShadow new];
    shadow.shadow = YES;
    shadow.shadowColor = KM_Color(0, 0, 0, 0.35);
    shadow.shadowRadius = 20;
    shadow.shadowOpacity = 1;
    shadow.shadowOffset = CGSizeMake(0, 10);
    
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
