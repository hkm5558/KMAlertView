//
//  KMAlertView.h
//  KM_Kit
//
//  Created by KM on 2017/6/13.
//  Copyright © 2017年 KM. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KMAlertStyle.h"


typedef KMAlertStyle *(^AlertStyleConfig)(KMAlertStyle * alertStyle);

typedef void(^KMAlertViewCallBackBlock)(NSInteger buttonIndex, NSString *buttonTitle);

@interface KMAlertView : UIView

//Style
@property (nonatomic, strong, readonly) KMAlertStyle * style;

/** Quick Init With Title */
+(instancetype)showAlertWithTitle:(NSString *)title;

/** Quick Init With Message */
+(instancetype)showAlertWithMessage:(NSString *)message;

/** Quick Init With Title + Message + CallBack */
+(instancetype)showAlertWithTitle:(NSString *)title
                          message:(NSString *)message
                    callBackBlock:(KMAlertViewCallBackBlock)callBack;

/** Quick Init With Title + Message + ButtonTitles + CallBack */
+(instancetype)showAlertWithTitle:(NSString *)title
                          message:(NSString *)message
                     buttonTitles:(NSArray<NSString *> *)buttonTitles
                    callBackBlock:(KMAlertViewCallBackBlock)callBack;

/** Quick Init With ButtonTitles + AlertStyleConfig + CallBack */
+(instancetype)showAlertWithButtonTitles:(NSArray<NSString *> *)buttonTitles
                        styleConfigBlock:(AlertStyleConfig)alertStyleConfig
                           callBackBlock:(KMAlertViewCallBackBlock)callBack;

/** Quick Init With AlertStyleConfig + CallBack */
+(instancetype)showAlertWithStyleConfigBlock:(AlertStyleConfig)alertStyleConfig
                               callBackBlock:(KMAlertViewCallBackBlock)callBack;

/** Dissmiss */
-(void)dismissWithCompletion:(void(^)(void))completion;

@end
