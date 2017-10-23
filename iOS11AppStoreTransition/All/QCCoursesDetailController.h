//
//  QCCoursesDetailController.h
//  QingClassSaas
//
//  Created by weikeyan on 2017/10/16.
//  Copyright © 2017年 QingClass. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface QCCoursesDetailController : UIViewController
@property (weak, nonatomic) IBOutlet UIImageView *headImageView;
@property (weak, nonatomic) IBOutlet UITextView *contentView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *downViewConstraint;

@end
