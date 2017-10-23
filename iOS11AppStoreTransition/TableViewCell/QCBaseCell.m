//
//  QCBaseCell.m
//  QingClassSaas
//
//  Created by SXJH on 2017/9/22.
//  Copyright © 2017年 SXJH. All rights reserved.
//

#import "QCBaseCell.h"
#define QCTableViewCellDefaultHeight 44.f

@implementation QCBaseCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

+ (NSString *)cellIdentifier {
    return NSStringFromClass([self class]);
}

+ (CGFloat)height {
    return QCTableViewCellDefaultHeight;
}
- (void)updateLocalWithData:(id)data
{
    
}
- (void)updateWithData:(id)data {
}

+ (void)registerToTableView:(UITableView *)tableView {
    [tableView registerNib:[UINib nibWithNibName:NSStringFromClass([self class]) bundle:nil]
    forCellReuseIdentifier:[self cellIdentifier]];
}

@end
