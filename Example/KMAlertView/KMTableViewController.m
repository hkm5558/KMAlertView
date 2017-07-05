//
//  KMTableViewController.m
//  KMAlertView
//
//  Created by KM on 2017/6/20.
//  Copyright © 2017年 hkm5558. All rights reserved.
//

#import "KMTableViewController.h"
#import <KMAlertView/KMAlertView.h>
@interface KMTableViewController ()

@property (nonatomic, copy) NSString * shortTitle;
@property (nonatomic, copy) NSString * shortMessage;

@property (nonatomic, copy) NSString * longTitle;
@property (nonatomic, copy) NSString * longMessage;

@property (nonatomic, copy) NSArray * buttonTitles;
@property (nonatomic, strong) KMAlertStyle * style;

@end

@implementation KMTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.shortTitle = @"This is Title";
    
    self.shortMessage = @"This is Message";
    
    self.longTitle = @"Long Title Long Title Long Title Long Title Long Title Long Title Long Title Long Title Long Title Long Title Long Title Long Title Long Title Long Title Long Title Long Title Long Title Long Title Long Title Long Title Long Title Long Title Long Title Long Title Long Title Long Title Long Title Long Title Long Title Long Title Long Title Long Title Long Title Long Title Long Title Long Title Long Title Long Title Long Title Long Title Long Title Long Title Long Title Long Title Long Title Long Title Long Title Long Title Long Title Long Title Long Title Long Title Long Title Long Title Long Title Long Title Long Title Long Title Long Title Long Title Long Title Long Title Long Title Long Title Long Title Long Title Long Title Long Title Long Title Long Title Long Title Long Title Long Title Long Title Long Title Long Title Long Title Long Title Long Title Long Title Long Title Long Title Long Title Long Title Long Title Long Title Long Title Long Title Long Title Long Title Long Title Long Title Long Title Long Title Long Title Long Title Long Title Long Title Long Title Long Title Long Title Long Title Long Title Long Title Long Title Long Title Long Title Long Title Long Title Long Title Long Title Long Title Long Title Long Title Long Title Long Title Long Title Long Title Long Title Long Title Long Title Long Title Long Title Long Title Long Title Long Title Long Title Long Title Long Title Long Title Long Title Long Title Long Title Long Title Long Title Long Title Long Title Long Title Long Title Long Title Long Title Long Title Long Title Long Title Long Title Long Title Long Title Long Title ";
    self.longMessage = @"Long Message Long Message Long Message Long Message Long Message Long Message Long Message Long Message Long Message Long Message Long Message Long Message Long Message Long Message Long Message Long Message Long Message Long Message Long Message Long Message Long Message Long Message Long Message Long Message Long Message Long Message Long Message Long Message Long Message Long Message Long Message Long Message Long Message Long Message Long Message Long Message Long Message Long Message Long Message Long Message Long Message Long Message Long Message Long Message Long Message Long Message Long Message Long Message Long Message Long Message Long Message Long Message Long Message Long Message Long Message Long Message Long Message Long Message Long Message Long Message Long Message Long Message Long Message Long Message Long Message Long Message Long Message Long Message Long Message Long Message Long Message Long Message Long Message Long Message Long Message Long Message Long Message Long Message Long Message Long Message Long Message Long Message Long Message Long Message Long Message Long Message Long Message Long Message Long Message Long Message Long Message Long Message Long Message Long Message Long Message Long Message Long Message Long Message Long Message Long Message Long Message Long Message Long Message Long Message Long Message Long Message Long Message Long Message Long Message Long Message Long Message Long Message Long Message Long Message Long Message Long Message Long Message Long Message Long Message Long Message Long Message Long Message Long Message Long Message Long Message Long Message Long Message Long Message Long Message Long Message Long Message Long Message ";
    self.style = [self getDefaultStyle];
    self.buttonTitles = @[@"确定"];
    
    [self applySetting];
}

-(KMAlertStyle *)getDefaultStyle{
    
    KMAlertStyle *style = [KMAlertStyle new];
    style.title.text = self.shortTitle;
    style.message.text = self.shortMessage;

    return style;
}

-(void)applySetting{
    self.setting ? self.setting(self.style , self.buttonTitles) : nil;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (indexPath.section) {
        case 0:{
            switch (indexPath.row) {
                case 0:{
                    [KMAlertView showAlertWithTitle:self.shortTitle];
                }
                    break;
                case 1:{
                    [KMAlertView showAlertWithTitle:self.longTitle];
                }
                    break;
                case 2:{
                    [KMAlertView showAlertWithMessage:self.shortMessage];
                }
                    break;
                case 3:{
                    [KMAlertView showAlertWithMessage:self.longMessage];
                }
                    break;
                case 4:{
                    [KMAlertView showAlertWithTitle:self.shortTitle
                                            message:self.shortMessage
                                      callBackBlock:nil];
                }
                    break;
                case 5:{
                    [KMAlertView showAlertWithTitle:self.longTitle
                                            message:self.longMessage
                                      callBackBlock:nil];
                }
                    break;
                default:
                    break;
            }
        }
            break;
            
        default:
            break;
    }
}

#pragma mark - Style Setting

- (IBAction)changeTitleStyle:(UISegmentedControl *)sender {
    switch (sender.selectedSegmentIndex) {
        case 0:{
            self.style.title.text = self.shortTitle;
        }
            break;
        case 1:{
            self.style.title.text = self.longTitle;
        }
            break;
        case 2:{
            self.style.title.text = nil;
        }
            break;
            
        default:
            break;
    }
    [self applySetting];
}
- (IBAction)changeMessageStyle:(UISegmentedControl *)sender {
    switch (sender.selectedSegmentIndex) {
        case 0:{
            self.style.message.text = self.shortMessage;
        }
            break;
        case 1:{
            self.style.message.text = self.longMessage;
        }
            break;
        case 2:{
            self.style.message.text = nil;
        }
            break;
            
        default:
            break;
    }
    [self applySetting];
}
- (IBAction)changeButtonNumber:(UISegmentedControl *)sender {
    switch (sender.selectedSegmentIndex) {
        case 0:{
            self.buttonTitles = @[@"确定"];
        }
            break;
        case 1:{
            self.buttonTitles = @[@"确定", @"取消"];
        }
            break;
        case 2:{
            self.buttonTitles = @[@"确定", @"取消", @"其他"];
        }
            break;
        case 3:{
            NSMutableArray *titles = @[].mutableCopy;
            for (int i = 0; i < 30; i ++) {
                NSString * text = [NSString stringWithFormat:@"按钮 - %d",i];
                [titles addObject:text];
            }
            self.buttonTitles = titles.copy;
        }
            break;
        case 4:{
            self.buttonTitles = nil;
        }
            break;
            
        default:
            break;
    }
    [self applySetting];
}
- (IBAction)changeAnimateInType:(UISegmentedControl *)sender {
    self.style.animate.inType = sender.selectedSegmentIndex;
    [self applySetting];
}
- (IBAction)changeAnimateOutType:(UISegmentedControl *)sender {
    self.style.animate.outType = sender.selectedSegmentIndex;
    [self applySetting];
}
- (IBAction)changeBounceStyle:(UISegmentedControl *)sender {
    self.style.animate.bounce = [[NSNumber numberWithInteger:sender.selectedSegmentIndex] boolValue];
    [self applySetting];
}

- (IBAction)changeBlur:(UISegmentedControl *)sender {
    self.style.background.blur = [[NSNumber numberWithInteger:sender.selectedSegmentIndex] boolValue];
    [self applySetting];
}


- (IBAction)changeBlurStyle:(UISegmentedControl *)sender{
    switch (sender.selectedSegmentIndex) {
        case 0:{
            self.style.background.blurStyle = UIBlurEffectStyleLight;
        }
            break;
        case 1:{
            self.style.background.blurStyle = UIBlurEffectStyleDark;
        }
            break;
        case 2:{
            self.style.background.blurStyle = UIBlurEffectStyleExtraLight;
        }
            break;
            
        default:
            break;
    }
    [self applySetting];
}



- (IBAction)changeShadowStyle:(UISegmentedControl *)sender {
    self.style.shadow.shadow = [[NSNumber numberWithInteger:sender.selectedSegmentIndex] boolValue];
    [self applySetting];
}
- (IBAction)changeDismissWhenTouchBackground:(UISegmentedControl *)sender {
    self.style.background.dismissWhenTouchBackground = [[NSNumber numberWithInteger:sender.selectedSegmentIndex] boolValue];
    [self applySetting];
}







@end
