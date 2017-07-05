//
//  KMAlertView.m
//  KM_Kit
//
//  Created by KM on 2017/6/13.
//  Copyright © 2017年 黄昆明. All rights reserved.
//

#import "KMAlertView.h"

#define KM_Btn_Tag (888)
#define TableViewFooterHeight (0.1)


@interface UIView (KMAlertView_corners)

-(void)kmAlertView_setRoundedCorners:(UIRectCorner)corners
                     radius:(CGFloat)radius;

@end


@implementation UIView (KMAlertView_corners)

-(void)kmAlertView_setRoundedCorners:(UIRectCorner)corners radius:(CGFloat)radius {
    CGRect rect = self.bounds;
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:rect
                                                   byRoundingCorners:corners
                                                         cornerRadii:CGSizeMake(radius, radius)];
    CAShapeLayer *maskLayer = [CAShapeLayer layer];
    maskLayer.frame = rect;
    maskLayer.path = maskPath.CGPath;
    self.layer.mask = maskLayer;
}

@end


#pragma mark - KMHighLightButton
@interface KMHighLightButton : UIButton

@property (nonatomic, strong) KMAlertStyleButton * buttonStyle;

@end

@implementation KMHighLightButton

- (void)setHighlighted:(BOOL)highlighted {
    [super setHighlighted:highlighted];
    
    if (!self.buttonStyle.highlightBackgroundColor) { return; }

    self.backgroundColor = highlighted ? self.buttonStyle.highlightBackgroundColor : self.buttonStyle.backgroundColor;
}

//Getter
-(KMAlertStyleButton *)buttonStyle{
    if (!_buttonStyle) {
        _buttonStyle = [KMAlertStyleButton new];
    }
    return _buttonStyle;
}

@end

#pragma mark - KMAlertButtonCell

@interface KMAlertButtonCell : UITableViewCell

@property (nonatomic, strong) KMAlertStyleButton * buttonStyle;

@property (nonatomic, strong) KMHighLightButton * alertButton;

+(NSString *)alertCellId;

@end

@implementation KMAlertButtonCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:self.alertButton];
    }
    return self;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    self.alertButton.frame = self.contentView.bounds;
}

+(NSString *)alertCellId{
    return NSStringFromClass([self class]);
}

#pragma mark - Setter
-(void)setButtonStyle:(KMAlertStyleButton *)buttonStyle{
    _buttonStyle = buttonStyle;
    
    self.alertButton.buttonStyle = buttonStyle;
    [self.alertButton setTitle:buttonStyle.text forState:UIControlStateNormal];
    [self.alertButton setTitleColor:buttonStyle.textColor forState:UIControlStateNormal];
    [self.alertButton setTitleColor:buttonStyle.highlightTextColor forState:UIControlStateHighlighted];
    self.alertButton.titleLabel.font = buttonStyle.font;
    self.alertButton.backgroundColor = buttonStyle.backgroundColor;
}
#pragma mark - Getter
-(KMHighLightButton *)alertButton{
    if (!_alertButton) {
        _alertButton = [KMHighLightButton buttonWithType:UIButtonTypeCustom];
    }
    return _alertButton;
}
@end



#pragma mark - KMAlertView
@interface KMAlertView ()<UITableViewDelegate, UITableViewDataSource>

//View

@property (nonatomic, strong) UIView * contentView;

@property (nonatomic, strong) UIView * backgroundView;

@property (nonatomic, strong) UILabel * titleLabel;

@property (nonatomic, strong) UILabel * messageLabel;

@property (nonatomic, strong) UIScrollView * textContainer;
//标题容器
@property (nonatomic, strong) UIView * titleContainer;
//消息容器
@property (nonatomic, strong) UIView * messageContainer;
//按钮容器
@property (nonatomic, strong) UITableView * buttonContainer;
//高斯模糊
@property (nonatomic, strong) UIVisualEffectView *blurView;

@property (nonatomic, strong) UIView * shadowView;

//ButtonTitle
@property (nonatomic, copy) NSArray * buttonTitles;

//ContentFrame
@property (nonatomic, assign) CGRect alertContentFrame;

//CallBackBlock
@property (nonatomic, copy) KMAlertViewCallBackBlock callBack;

//AlertStyle
@property (nonatomic, strong) KMAlertStyle * style;
@end

@implementation KMAlertView

#pragma mark - Quick Init
/** Quick Init With Title */
+(instancetype)showAlertWithTitle:(NSString *)title{
    return [self showAlertWithTitle:title
                            message:nil
                      callBackBlock:nil];
}

/** Quick Init With Message */
+(instancetype)showAlertWithMessage:(NSString *)message{
    return [self showAlertWithTitle:nil
                            message:message
                      callBackBlock:nil];
}

/** Quick Init With Title + Message + CallBack */
+(instancetype)showAlertWithTitle:(NSString *)title
                          message:(NSString *)message
                    callBackBlock:(KMAlertViewCallBackBlock)callBack{
    return [self showAlertWithTitle:title
                            message:message
                       buttonTitles:@[@"确定"]
                      callBackBlock:callBack];

}

/** Quick Init With Title + Message + ButtonTitles + CallBack */
+(instancetype)showAlertWithTitle:(NSString *)title message:(NSString *)message buttonTitles:(NSArray<NSString *> *)buttonTitles callBackBlock:(KMAlertViewCallBackBlock)callBack{
    return [self showAlertWithStyleConfigBlock:^KMAlertStyle *(KMAlertStyle *alertStyle) {
                alertStyle.title.text = title;
                alertStyle.message.text = message;
                [alertStyle setupButtonsWithTitles:buttonTitles];
                return alertStyle;
            } callBackBlock:callBack];
}

/** Quick Init With ButtonTitles + AlertStyleConfig + CallBack */
+(instancetype)showAlertWithButtonTitles:(NSArray<NSString *> *)buttonTitles
                        styleConfigBlock:(AlertStyleConfig)alertStyleConfig
                           callBackBlock:(KMAlertViewCallBackBlock)callBack{
    return [self showAlertWithStyleConfigBlock:^KMAlertStyle *(KMAlertStyle *alertStyle) {
        alertStyle = alertStyleConfig ? alertStyleConfig(alertStyle) : alertStyle;
        [alertStyle setupButtonsWithTitles:buttonTitles];
        return alertStyle;
    } callBackBlock:callBack];
}

/** Quick Init With AlertStyleConfig + CallBack */
+(instancetype)showAlertWithStyleConfigBlock:(AlertStyleConfig)alertStyleConfig callBackBlock:(KMAlertViewCallBackBlock)callBack{
    KMAlertView *alertView = [KMAlertView new];
    alertView.style = alertStyleConfig ? alertStyleConfig(alertView.style) : alertView.style;
    alertView.callBack = [callBack copy];
    [alertView showAlertView];
    return alertView;
}



#pragma mark - initialize

- (instancetype)init
{
    self = [super init];
    if (self) {
        CGRect screenBounds = [UIScreen mainScreen].bounds;
        self.frame = screenBounds;
        self.backgroundColor = [UIColor clearColor];
        [self addSubviews];
    }
    return self;
}

-(void)willMoveToSuperview:(UIView *)newSuperview{
    [super willMoveToSuperview:newSuperview];
    if (newSuperview == nil) return;
    
    [self configBackground];                    //配置背景
    
    [self setupTextContentFrame];               //设置文字内容大小
    
    [self setupTextContentAttribute];           //设置文字属性
    
    [self.buttonContainer reloadData];
    
    if (self.style.buttons.count == 2){         //两个按钮
        [self setupTwoButtonFrame];
    }

    
    [self setupContentViewFrame];               //设置ContentView大小
    
    [self configShadow];                        //设置阴影
    
    //显示前对 TableView 的设置
    if (self.buttonContainer.contentSize.height > self.buttonContainer.frame.size.height + TableViewFooterHeight) {
        self.buttonContainer.scrollEnabled = YES;
    }else{
        self.buttonContainer.scrollEnabled = NO;
    }
    
    CGFloat margin = (self.style.alertView.width - self.style.separator.horizontalWidth) / 2.0;
    
    self.buttonContainer.separatorColor = self.style.separator.horizontalColor;
    self.buttonContainer.separatorInset = UIEdgeInsetsMake(0, margin, 0, margin);
}

#pragma mark - Add Subviews
-(void)addSubviews{
    self.backgroundView.frame = self.bounds;
    
    [self addSubview:self.backgroundView];
    
    [self addSubview:self.shadowView];

    [self.shadowView addSubview:self.contentView];
    
    [self.contentView addSubview:self.textContainer];
    [self.contentView addSubview:self.buttonContainer];
    
    [self.textContainer addSubview:self.titleContainer];
    [self.textContainer addSubview:self.messageContainer];
    
    [self.titleContainer addSubview:self.titleLabel];
    [self.messageContainer addSubview:self.messageLabel];
}

#pragma mark - HorizontalLine
/**
 文字和按钮之间的横线
 */
-(void)addHorizontalLine{
    UIView *horizontalLine = [UIView new];
    horizontalLine.frame = CGRectMake(
                                      (CGRectGetWidth(_alertContentFrame) - _style.separator.horizontalWidth)/2.0,
                                      CGRectGetMaxY(_textContainer.frame),
                                      _style.separator.horizontalWidth,
                                      _style.separator.mainHorizontalHeight
                                      );
    horizontalLine.backgroundColor = _style.separator.horizontalColor;
    
    [_contentView addSubview:horizontalLine];
}



#pragma mark - 
#pragma mark Config Background
/**
 背景的配置
 */
-(void)configBackground{
    
    if (_style.background.blur) {
        UIVisualEffect *blurEffect = [UIBlurEffect effectWithStyle:self.style.background.blurStyle];
        _blurView = [[UIVisualEffectView alloc]initWithEffect:blurEffect];
        _blurView.frame = _backgroundView.bounds;
        [_backgroundView addSubview:_blurView];
        _backgroundView.backgroundColor = [_style.background.color colorWithAlphaComponent:_style.background.alpha];
    }else{
        _backgroundView.backgroundColor = [_style.background.color colorWithAlphaComponent:_style.background.alpha];
    }
}

#pragma mark - Config Shadow
-(void)configShadow{
    if (self.style.shadow.isShadow) {
        _shadowView.layer.masksToBounds = NO;
        _shadowView.layer.shadowColor = _style.shadow.shadowColor.CGColor;
        _shadowView.layer.shadowRadius = _style.shadow.shadowRadius;
        _shadowView.layer.shadowOpacity = _style.shadow.shadowOpacity;
        _shadowView.layer.shadowOffset = _style.shadow.shadowOffset;
    }
    
    _shadowView.frame = _alertContentFrame;
    _contentView.frame = _shadowView.bounds;
    [_contentView kmAlertView_setRoundedCorners:UIRectCornerAllCorners
                                         radius:_style.alertView.cornerRadius];
}

#pragma mark -
#pragma mark TextContent Frame
/**
 文字内容 Frame
 */
-(void)setupTextContentFrame{

    _titleLabel.text = _style.title.text;
    _titleLabel.font = _style.title.font;
    _titleLabel.textColor = _style.title.textColor;
    
    _messageLabel.text = _style.message.text;
    _messageLabel.font = _style.message.font;
    _messageLabel.textColor = _style.message.textColor;
    
    
    CGFloat titleW = _style.alertView.width - _style.title.insets.left
                                                - _style.title.insets.right;
    
    CGSize titleTextSize = [_style.title.text boundingRectWithSize:CGSizeMake(titleW, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:_style.title.font} context:nil].size;
    
    
    CGFloat titleTextH = titleTextSize.height;
    CGFloat titleH = 0;
    
    if (titleTextH > 0) {
       titleTextH = (titleTextH < _style.title.minHeight ? _style.title.minHeight : titleTextH);
       titleH = titleTextH + _style.title.insets.top
                           + _style.title.insets.bottom;
    }

    CGFloat messageW = _style.alertView.width - _style.message.insets.left
                                                  - _style.message.insets.right;
    
    CGSize messageTextSize = [_style.message.text boundingRectWithSize:CGSizeMake(messageW, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:_style.message.font} context:nil].size;
    
    CGFloat messageTextH = messageTextSize.height;
    CGFloat messageH = 0;
    if (messageTextH > 0) {
        messageTextH = (messageTextH < _style.message.minHeight ? _style.message.minHeight : messageTextH);
        messageH = messageTextH + (titleTextH > 0 ? 0 : _style.message.insets.top)
                                + _style.message.insets.bottom;
    }
   
    CGFloat titleLabelX = _style.title.insets.left;
    CGFloat titleLabelY = _style.title.insets.top;
    CGFloat titleLabelW = titleW;
    CGFloat titleLabelH = titleTextH;
    
    _titleLabel.frame = CGRectMake(
                                       titleLabelX,
                                       titleLabelY,
                                       titleLabelW,
                                       titleLabelH
                                       );
    
    CGFloat messageLabelX = _style.message.insets.left;
    CGFloat messageLabelY = titleLabelH > 0 ? 0 : _style.message.insets.top;
    CGFloat messageLabelW = messageW;
    CGFloat messageLabelH = messageTextH;
    
    _messageLabel.frame = CGRectMake(
                                       messageLabelX,
                                       messageLabelY,
                                       messageLabelW,
                                       messageLabelH
                                       );
    
    
    CGFloat titleContainerX = 0;
    CGFloat titleContainerY = 0;
    CGFloat titleContainerW = _style.alertView.width;
    CGFloat titleContainerH = titleH;
    _titleContainer.frame = CGRectMake(
                                           titleContainerX,
                                           titleContainerY,
                                           titleContainerW,
                                           titleContainerH
                                           );
    CGFloat messageContainerX = 0;
    CGFloat messageContainerY = 0 + titleContainerH;
    CGFloat messageContainerW = _style.alertView.width;
    CGFloat messageContainerH = messageH;
    _messageContainer.frame = CGRectMake(
                                           messageContainerX,
                                           messageContainerY,
                                           messageContainerW,
                                           messageContainerH
                                           );
    
    CGFloat textContainerH = CGRectGetHeight(_titleContainer.frame) + CGRectGetHeight(_messageContainer.frame);
    
    _textContainer.contentSize = CGSizeMake(
                                                _style.alertView.width,
                                                textContainerH
                                                );
}
#pragma mark TextContent Attribute
/**
 配置文字属性
 */
-(void)setupTextContentAttribute{
    _titleLabel.textAlignment = _style.title.textAlignment;
    
    _messageLabel.textAlignment = _style.message.textAlignment;
    
    _titleContainer.backgroundColor = _style.title.backgroundColor;
    
    _messageContainer.backgroundColor = _style.message.backgroundColor;
    
    _contentView.backgroundColor = _style.alertView.backgroundColor;
}



#pragma mark -
#pragma mark ContentView Frame
/**
 计算 ContentView Frame
 */
-(void)setupContentViewFrame{
    
    CGFloat textContainerX = 0;
    CGFloat textContainerY = 0;
    CGFloat textContainerW = _style.alertView.width;
    CGFloat textContainerH = _textContainer.contentSize.height;
    
    
    CGFloat maxContnetH = [UIScreen mainScreen].bounds.size.height
    - _style.alertView.minInsets.top
    - _style.alertView.minInsets.bottom;
    
    CGFloat maxTextContainerH = 0;
    
    if (_style.buttons.count == 1 || _style.buttons.count == 2) {       //一个按钮 两个按钮
        
        KMAlertStyleButton *buttonStyle = [_style.buttons firstObject];
        maxTextContainerH = maxContnetH - buttonStyle.height;
        
    }else if (_style.buttons.count != 0){                                   //多个按钮
        
        maxTextContainerH = maxContnetH - _style.alertView.multipleButtonMinHeight;
        
    }else{                                                                      //没有按钮
        
        maxTextContainerH = maxContnetH;
        
    }
    textContainerH = textContainerH > maxTextContainerH ? maxTextContainerH : textContainerH;
    
    _textContainer.frame = CGRectMake(
                                          textContainerX,
                                          textContainerY,
                                          textContainerW,
                                          textContainerH
                                          );
    
    
    CGFloat buttonContainerX = 0;
    CGFloat buttonContainerY = CGRectGetMaxY(_textContainer.frame);
    CGFloat buttonContainerW = _style.alertView.width;
    CGFloat buttonContainerH = 0;
    
    if (_style.buttons.count == 1 || _style.buttons.count == 2) {       //一个按钮 两个按钮
        
        KMAlertStyleButton *buttonStyle = [_style.buttons firstObject];
        buttonContainerH = buttonStyle.height;
        
    }else if (_style.buttons.count != 0){                                   //多个按钮
        
        if (textContainerH + _buttonContainer.contentSize.height > maxContnetH) {
            buttonContainerH = maxContnetH - textContainerH;
        }else{
            buttonContainerH = _buttonContainer.contentSize.height;
        }
        
    }else{                                                                      //没有按钮
        buttonContainerH = 0;
    }
    
    if (buttonContainerH) {
        buttonContainerY += _style.separator.mainHorizontalHeight;
    }
    
    _buttonContainer.frame = CGRectMake(
                                            buttonContainerX,
                                            buttonContainerY,
                                            buttonContainerW,
                                            buttonContainerH
                                            );
    
    
    CGFloat contentViewX = ([UIScreen mainScreen].bounds.size.width - _style.alertView.width)/2.0;
    CGFloat contentViewH = CGRectGetMaxY(_buttonContainer.frame);
    CGFloat contentViewY = ([UIScreen mainScreen].bounds.size.height / 2.0) - (contentViewH / 2.0);
    CGFloat contentViewW = _style.alertView.width;
    
    _alertContentFrame = CGRectMake(
                                        contentViewX,
                                        contentViewY,
                                        contentViewW,
                                        contentViewH
                                        );;
    if (buttonContainerH) {
        [self addHorizontalLine];
    }
}



#pragma mark -
#pragma mark Config Button

#pragma mark  两个按钮
/**
 两个按钮时的配置
 */
-(void)setupTwoButtonFrame{
    
    CGFloat buttonY = 0;
    CGFloat buttonW = (_style.alertView.width - 0.5) / 2.0;
    
    for (int i = 0; i < _style.buttons.count; i ++) {
        
        KMAlertStyleButton *buttonStyle = [_style.buttons objectAtIndex:i];
        
        KMHighLightButton *button = [KMHighLightButton buttonWithType:UIButtonTypeCustom];
        button.tag = KM_Btn_Tag + i;
        button.buttonStyle = buttonStyle;
        
        [button setTitle:buttonStyle.text forState:UIControlStateNormal];
        [button setTitleColor:buttonStyle.textColor forState:UIControlStateNormal];
        [button setTitleColor:buttonStyle.highlightTextColor forState:UIControlStateHighlighted];
        button.titleLabel.font = buttonStyle.font;
        button.backgroundColor = buttonStyle.backgroundColor;
        
        [button addTarget:self
                      action:@selector(buttonClickEvent:)
            forControlEvents:UIControlEventTouchUpInside];
        
        CGFloat buttonX = i * (buttonW + 0.5);
        CGFloat buttonH = buttonStyle.height;
        
        button.frame = CGRectMake(
                                  buttonX,
                                  buttonY,
                                  buttonW,
                                  buttonH
                                  );
        [_buttonContainer addSubview:button];
        
        if(i == 0){
            UIView *verticalLineView = [UIView new];
            verticalLineView.frame = CGRectMake(
                                                CGRectGetWidth(button.frame),
                                                0,
                                                0.5,
                                                buttonH
                                                );
            verticalLineView.backgroundColor = _style.separator.verticalColor;
            [_buttonContainer addSubview:verticalLineView];
        }
    }
    
    KMAlertStyleButton *buttonStyle = [_style.buttons firstObject];
    _buttonContainer.contentSize = CGSizeMake(_style.alertView.width, buttonStyle.height);
}

#pragma mark -
#pragma mark ShowAlertView
/**
 显示前的动画设置
 */
-(void)configBeforeShowAlert{
    UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
    [keyWindow addSubview:self];
    
    if (_style.background.isBlur) {
        _blurView.backgroundColor = [_style.background.color colorWithAlphaComponent:0];
    }else{
       _backgroundView.backgroundColor = [_style.background.color colorWithAlphaComponent:0];
    }
    
    switch (_style.animate.inType) {
        case KMAlertViewAnimateInTypeScale:{
            _shadowView.transform = CGAffineTransformMakeScale(1.5, 1.5);
        }
            break;
        case KMAlertViewAnimateInTypeTop:{
            _shadowView.frame = CGRectMake(
                                            _alertContentFrame.origin.x,
                                            0 - _alertContentFrame.size.height - 15,
                                            _alertContentFrame.size.width,
                                            _alertContentFrame.size.height
                                            );
        }
            break;
        case KMAlertViewAnimateInTypeLeft:{
            _shadowView.frame = CGRectMake(
                                            0 - _alertContentFrame.size.width - 15,
                                            _alertContentFrame.origin.y,
                                            _alertContentFrame.size.width,
                                            _alertContentFrame.size.height
                                            );
        }
            break;
        case KMAlertViewAnimateInTypeBottom:{
            _shadowView.frame = CGRectMake(
                                            _alertContentFrame.origin.x,
                                            self.frame.size.height + _alertContentFrame.size.height + 15,
                                            _alertContentFrame.size.width,
                                            _alertContentFrame.size.height
                                            );
        }
            break;
        case KMAlertViewAnimateInTypeRight:{
            _shadowView.frame = CGRectMake(
                                            self.frame.size.width + _alertContentFrame.size.width + 15,
                                            _alertContentFrame.origin.y,
                                            _alertContentFrame.size.width,
                                            _alertContentFrame.size.height
                                            );
        }
            break;
        case KMAlertViewAnimateInTypeAngle:{
            _shadowView.frame = CGRectMake(
                                            _alertContentFrame.origin.x,
                                            0 - _alertContentFrame.size.height - 15,
                                            _alertContentFrame.size.width,
                                            _alertContentFrame.size.height
                                            );
            _shadowView.transform = CGAffineTransformMakeRotation(_style.animate.angle * (M_PI / 180));
        }
            break;
            
        default:
            break;
    }
}

/**
 显示动画设置
 */
-(void)configAfterShowAlert{
    if (_style.background.isBlur) {
        _blurView.backgroundColor = [_style.background.color colorWithAlphaComponent:0];
    }else{
        _backgroundView.backgroundColor = [_style.background.color colorWithAlphaComponent:_style.background.alpha];
    }
    
    _shadowView.transform = CGAffineTransformIdentity;
    
    if (_style.animate.inType == KMAlertViewAnimateInTypeScale) {
        
    }else{
        _shadowView.frame = CGRectMake(
                                        _alertContentFrame.origin.x,
                                        _alertContentFrame.origin.y,
                                        _alertContentFrame.size.width,
                                        _alertContentFrame.size.height
                                        );
    }
}

/**
 显示Alert
 */
-(void)showAlertView{
    
    [self configBeforeShowAlert];
    
    if (_style.animate.isBounce) {
        [UIView animateWithDuration:_style.animate.animateInDuration delay:0 usingSpringWithDamping:_style.animate.springDamping initialSpringVelocity:_style.animate.springVelocity options:UIViewAnimationOptionCurveEaseInOut animations:^{
            [self configAfterShowAlert];
        } completion:^(BOOL finished) {
            
        }];
    }else{
        [UIView animateWithDuration:_style.animate.animateInDuration delay:0.0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            [self configAfterShowAlert];
        } completion:^(BOOL finished) {
               
        }];
    }
}

#pragma mark -
#pragma mark HideAlertView
/**
 隐藏时如果 Bounce = YES
 */
-(void)configBounceWithHideAlert{
    switch (_style.animate.outType) {
        case KMAlertViewAnimateOutTypeTop:{
            _shadowView.frame = CGRectMake(
                                            _alertContentFrame.origin.x,
                                            _alertContentFrame.origin.y + 7.5,
                                            _alertContentFrame.size.width,
                                            _alertContentFrame.size.height
                                            );
        }
            break;
        case KMAlertViewAnimateOutTypeLeft:{
            
            _shadowView.frame = CGRectMake(
                                            _alertContentFrame.origin.x + 7.5,
                                            _alertContentFrame.origin.y,
                                            _alertContentFrame.size.width,
                                            _alertContentFrame.size.height
                                            );
            
        }
            break;
        case KMAlertViewAnimateOutTypeBottom:{
            _shadowView.frame = CGRectMake(
                                            _alertContentFrame.origin.x,
                                            _alertContentFrame.origin.y - 7.5,
                                            _alertContentFrame.size.width,
                                            _alertContentFrame.size.height
                                            );
        }
            break;
        case KMAlertViewAnimateOutTypeRight:{
            _shadowView.frame = CGRectMake(
                                            _alertContentFrame.origin.x - 7.5,
                                            _alertContentFrame.origin.y,
                                            _alertContentFrame.size.width,
                                            _alertContentFrame.size.height
                                            );
        }
            break;
        default:
            break;
    }
}


-(void)configBeforeHideAlert{
    
}

/**
 隐藏动画设置
 */
-(void)configAfterHideAlert{
    _shadowView.alpha = 0;
    _backgroundView.backgroundColor = [_style.background.color colorWithAlphaComponent:0.15];
    switch (_style.animate.outType) {
        case KMAlertViewAnimateOutTypeTop:{
            _shadowView.frame = CGRectMake(
                                            _alertContentFrame.origin.x,
                                            0 - _alertContentFrame.size.height - 15,
                                            _alertContentFrame.size.width,
                                            _alertContentFrame.size.height
                                            );
        }
            break;
        case KMAlertViewAnimateOutTypeLeft:{
            _shadowView.frame = CGRectMake(
                                            0 - _alertContentFrame.size.width - 15,
                                            _alertContentFrame.origin.y,
                                            _alertContentFrame.size.width,
                                            _alertContentFrame.size.height
                                            );
        }
            break;
        case KMAlertViewAnimateOutTypeBottom:{
            _shadowView.frame = CGRectMake(
                                            _alertContentFrame.origin.x,
                                            self.frame.size.height + _alertContentFrame.size.height + 15,
                                            _alertContentFrame.size.width,
                                            _alertContentFrame.size.height
                                            );
        }
            break;
        case KMAlertViewAnimateOutTypeRight:{
            _shadowView.frame = CGRectMake(
                                            self.frame.size.width + _alertContentFrame.size.width + 15,
                                            _alertContentFrame.origin.y,
                                            _alertContentFrame.size.width,
                                            _alertContentFrame.size.height
                                            );
        }
            break;
        case KMAlertViewAnimateOutTypeAngle:{
            _shadowView.frame = CGRectMake(
                                            _alertContentFrame.origin.x,
                                            self.frame.size.height + _alertContentFrame.size.height + 15,
                                            _alertContentFrame.size.width,
                                            _alertContentFrame.size.height
                                            );
            _shadowView.transform = CGAffineTransformMakeRotation(_style.animate.angle);
        }
            break;
            
        default:
            break;
    }
}

/**
 隐藏Alert

 @param completion 回调
 */
- (void)hideAlertWithCompletion:(void(^)(void))completion{

    [UIView animateWithDuration:_style.animate.animateOutDuration delay:0.0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        
        if (_style.animate.outType == KMAlertViewAnimateOutTypeScale) {
            _shadowView.transform = CGAffineTransformMakeScale(0.1, 0.1);
            [self configAfterHideAlert];
        }else{
            if (_style.animate.isBounce) {
                [self configBounceWithHideAlert];
            }else{
                [self configAfterHideAlert];
            }
        }
    } completion:^(BOOL finished) {
        if (_style.animate.outType == KMAlertViewAnimateOutTypeScale) {
            completion ? completion() : nil;
            [self removeFromSuperview];
        }else{
            if (_style.animate.isBounce) {
                [UIView animateWithDuration:_style.animate.animateOutDuration animations:^{
                    [self configAfterHideAlert];
                } completion:^(BOOL finished) {
                    completion ? completion() : nil;
                    [self removeFromSuperview];
                }];
            }else{
                completion ? completion() : nil;
                [self removeFromSuperview];
            }
        }
    }];
}


#pragma mark -
#pragma mark Tap Background
/**
 点击背景
 */
-(void)tapBackgroundView{
    if (_style.background.isDismissWhenTouchBackground) {
        [self hideAlertWithCompletion:nil];
    }
}
#pragma mark - 
#pragma mark Dismiss
/**
 外部调用的隐藏Alert

 @param completion 回调
 */
-(void)dismissWithCompletion:(void (^)(void))completion{
    [self hideAlertWithCompletion:completion];
}

/**
 Alert按钮点击
 */
#pragma mark - Button Event
-(void)buttonClickEvent:(UIButton *)button{
    
    NSInteger index = button.tag - KM_Btn_Tag;
    
    self.callBack ? self.callBack(index, [self.style.buttons objectAtIndex:index].text) : nil;
    [self hideAlertWithCompletion:nil];
}

#pragma mark - TableViwe Delegate && DataSouce

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
   KMAlertStyleButton *buttonStyle = [_style.buttons objectAtIndex:indexPath.row];
    return buttonStyle.height;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (_style.buttons.count == 2) {
        return 0;
    }
    return _style.buttons.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    KMAlertButtonCell *cell = [tableView dequeueReusableCellWithIdentifier:[KMAlertButtonCell alertCellId]];
    
    KMAlertStyleButton *buttonStyle = [_style.buttons objectAtIndex:indexPath.row];
    cell.buttonStyle = buttonStyle;
    cell.alertButton.tag = indexPath.row + KM_Btn_Tag;
    [cell.alertButton addTarget:self action:@selector(buttonClickEvent:) forControlEvents:UIControlEventTouchUpInside];
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return TableViewFooterHeight;
}

#pragma mark - Getter
-(UIView *)backgroundView{
    if (!_backgroundView) {
        _backgroundView = [[UIView alloc]init];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self
                                                                             action:@selector(tapBackgroundView)];
        [_backgroundView addGestureRecognizer:tap];
    }
    return _backgroundView;
}
-(UIView *)shadowView{
    if (!_shadowView) {
        _shadowView = [[UIView alloc]init];
    }
    return _shadowView;
}
-(UIView *)contentView{
    if (!_contentView) {
        _contentView = [[UIView alloc]init];
    }
    return _contentView;
}

-(UIScrollView *)textContainer{
    if (!_textContainer) {
        _textContainer = [[UIScrollView alloc]init];
        _textContainer.backgroundColor = [UIColor clearColor];
    }
    return _textContainer;
}
-(UIView *)titleContainer{
    if (!_titleContainer) {
        _titleContainer = [[UIView alloc]init];
    }
    return _titleContainer;
}

-(UIView *)messageContainer{
    if (!_messageContainer) {
        _messageContainer = [[UIView alloc]init];
    }
    return _messageContainer;
}
-(UITableView *)buttonContainer{
    if (!_buttonContainer) {
        _buttonContainer = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
        _buttonContainer.delegate = self;
        _buttonContainer.dataSource = self;
        _buttonContainer.backgroundColor = [UIColor clearColor];
        _buttonContainer.tableFooterView = [UIView new];
        [_buttonContainer registerClass:[KMAlertButtonCell class] forCellReuseIdentifier:[KMAlertButtonCell alertCellId]];
    }
    return _buttonContainer;
}
-(UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]init];
        _titleLabel.numberOfLines = 0;
    }
    return _titleLabel;
}
-(UILabel *)messageLabel{
    if (!_messageLabel) {
        _messageLabel = [[UILabel alloc]init];
        _messageLabel.numberOfLines = 0;
    }
    return _messageLabel;
}

-(KMAlertStyle *)style{
    if (!_style) {
        _style = [KMAlertStyle new];
    }
    return _style;
}
@end
