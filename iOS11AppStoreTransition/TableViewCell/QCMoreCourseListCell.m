//
//  QCCourseDetailCell.m
//  QingClassSaas
//
//  Created by weikeyan on 2017/10/20.
//  Copyright © 2017年 QingClass. All rights reserved.
//

#import "QCMoreCourseListCell.h"

@implementation QCMoreCourseListCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.priceButton.layer.cornerRadius = self.priceButton.frame.size.height*0.5;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
