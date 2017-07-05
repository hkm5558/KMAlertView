//
//  KMTableViewController.h
//  KMAlertView
//
//  Created by KM on 2017/6/20.
//  Copyright © 2017年 hkm5558. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <KMAlertView/KMAlertView.h>

typedef void(^SettingBlock)(KMAlertStyle * style, NSArray<NSString *> * buttonTitles);

@interface KMTableViewController : UITableViewController
@property (nonatomic, copy) SettingBlock  setting;
@end
