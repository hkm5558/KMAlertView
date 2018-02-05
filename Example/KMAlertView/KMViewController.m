//
//  KMViewController.m
//  KMAlertView
//
//  Created by hkm5558 on 06/19/2017.
//  Copyright (c) 2017 hkm5558. All rights reserved.
//

#import "KMViewController.h"
#import <KMAlertView/KMAlertView.h>
#import "KMTableViewController.h"
@interface KMViewController ()

@property (nonatomic, copy) NSArray * buttonTitles;
@property (nonatomic, strong) KMAlertStyle * style;

@end

@implementation KMViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([segue.identifier isEqualToString:@"TableView"]) {
        KMTableViewController *tableViewCtr = segue.destinationViewController;
        tableViewCtr.setting = ^(KMAlertStyle *style, NSArray<NSString *> *buttonTitles) {
            self.style = style;
            self.buttonTitles = buttonTitles;
        };
    }
}

- (IBAction)clickShowAlertButton:(UIButton *)sender {
    
    [KMAlertView showAlertWithButtonTitles:self.buttonTitles styleConfigBlock:^KMAlertStyle *(KMAlertStyle *alertStyle) {
        return self.style;
    } callBackBlock:^(NSInteger buttonIndex, NSString *buttonTitle) {
        NSLog(@"\nclick button index = %ld, title = %@",buttonIndex, buttonTitle);
    }];
    
}
@end
