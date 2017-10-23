//
//  QCRefreshTableView.h
//  QingClass
//
//  Created by SXJH on 2017/6/29.
//  Copyright © 2017年 qingclass. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol QCRefreshTableViewDelegate <NSObject>

- (void)QCRefreshTableViewDelegateHeaderRefreshingInvoked;
- (void)QCRefreshTableViewDelegateFooterRefreshingInvoked;

@end
@interface QCRefreshTableView : UITableView
@property (nonatomic, assign) BOOL hasRefreshHeader;    // default as YES
@property (nonatomic, assign) BOOL hasRefreshFooter;    // default as NO
@property (nonatomic, weak) id<QCRefreshTableViewDelegate> refreshDelegate;

- (void)endHeaderRefreshing;
- (void)configRefresh;
- (void)endFooterRefreshing;
- (void)refresh;
@end
