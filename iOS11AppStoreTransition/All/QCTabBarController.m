//
//  QCTabBarController.m
//  QingClass
//
//  Created by 0dayZh on 2016/11/15.
//  Copyright © 2016年 qingclass. All rights reserved.
//

#import "QCTabBarController.h"
//#import "UIButton+FillColor.h"

@interface QCTabBarController ()

@end

@implementation QCTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    self.tabBar.backgroundImage = [UIImage qc_imageWithColor:[UIColor whiteColor]];
    self.tabBar.shadowImage = [[UIImage imageNamed:@"tabbar_shadow"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 10, 0, 10) resizingMode:UIImageResizingModeStretch];
}

- (BOOL)shouldAutorotate {
    return self.selectedViewController.shouldAutorotate;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return self.selectedViewController.supportedInterfaceOrientations;
}

@end
