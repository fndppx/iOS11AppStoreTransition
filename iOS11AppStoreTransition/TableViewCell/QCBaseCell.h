//
//  QCBaseCell.h
//  QingClassSaas
//
//  Created by SXJH on 2017/9/22.
//  Copyright © 2017年 SXJH. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface QCBaseCell : UITableViewCell
+ (NSString *)cellIdentifier;
+ (CGFloat)height;
+ (void)registerToTableView:(UITableView *)tableView;
@end
