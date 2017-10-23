//
//  QCBaseViewController.m
//  QingClass
//
//  Created by xiangchao on 2017/6/23.
//  Copyright © 2017年 qingclass. All rights reserved.
//

#import "QCBaseViewController.h"
//#import "GloableConstant.h"

@interface QCBaseViewController ()

@end

@implementation QCBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBarHidden = NO;
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self setUpNavigationItem];
}

- (void)setUpNavigationItem
{
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    CGRect frame = CGRectMake(0, 0, 11, 19);
    backButton.frame = frame;
    [backButton setImage:[UIImage imageNamed:@"login_Back"] forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(onBack:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
}

- (void)onBack:(UIButton *)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)setNavigationTitle:(NSString *)navigationTitle
{
    UILabel *titleView = [UILabel new];
    titleView.font = [UIFont systemFontOfSize:18];
//    titleView.textColor = ColorWithRGB(51, 51, 51);
    titleView.textAlignment = NSTextAlignmentCenter;
    titleView.text = navigationTitle;
    [titleView sizeToFit];
    self.navigationItem.titleView = titleView;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskPortrait;
}

- (BOOL)shouldAutorotate
{
    return YES;
}

@end
