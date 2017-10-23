//
//  QCCourseCell.h
//  QingClassSaas
//
//  Created by weikeyan on 2017/10/10.
//  Copyright © 2017年 QingClass. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QCBaseCell.h"
@interface QCCourseCell : QCBaseCell
@property (nonatomic, copy) void (^tapCoverImageBlock)(NSInteger tag);//点击图片
@property (weak, nonatomic) IBOutlet UIView *tempView;//执行动画的站位图片
@property (assign, nonatomic) NSInteger indexRow;
@property (weak, nonatomic) IBOutlet UIView *imageContentView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomGap;
@property (weak, nonatomic) IBOutlet UIView *priceView;
@property (weak, nonatomic) IBOutlet UIImageView *headImageView;
@property (weak, nonatomic) IBOutlet UIView *downView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;


@end
