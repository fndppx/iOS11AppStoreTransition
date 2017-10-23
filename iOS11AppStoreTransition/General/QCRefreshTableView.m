//
//  QCRefreshTableView.m
//  QingClass
//
//  Created by SXJH on 2017/6/29.
//  Copyright © 2017年 qingclass. All rights reserved.
//

#import "QCRefreshTableView.h"
#import "MJRefresh.h"
#import "QCUIToobox.h"
@implementation QCRefreshTableView

- (void)_init {
    _hasRefreshHeader = YES;
    _hasRefreshFooter = NO;
}

- (void)configRefresh{
    !self.hasRefreshHeader ?: [self addRefreshHeader];
    !self.hasRefreshFooter ?: [self addRefreshFooter];
    self.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];

}

- (instancetype)initWithCoder:(NSCoder *)aDecoder{
    if (self = [super initWithCoder:aDecoder]) {
        [self _init];
    }
    return self;
}
#pragma mark - Refresh control

- (void)addRefreshHeader {
    NSMutableArray<UIImage *> *images = [NSMutableArray new];
    for (int i = 14; i < 58; i++) {
        NSString * imageUrl = @"";
        if (i>=10) {
            imageUrl = [NSString stringWithFormat:@"loading_00%d_图层-%d", i,59-i];
        }else{
            imageUrl = [NSString stringWithFormat:@"loading_000%d_图层-%d", i,59-i];
        }
        UIImage *image = [UIImage imageNamed:imageUrl];
        image = [image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
//        [images addObject:image];
    }
    MJRefreshHeader * header = [MJRefreshHeader headerWithRefreshingTarget:self refreshingAction:@selector(headerRefreshingInvoked)];
//    MJRefreshGifHeader *header = [MJRefreshGifHeader headerWithRefreshingTarget:self
//                                                               refreshingAction:@selector(headerRefreshingInvoked)];
//    header.lastUpdatedTimeLabel.hidden = YES;
//    header.stateLabel.hidden = YES;
////    [header setImages:@[[UIImage imageNamed:@"loading_0014_图层-45"]] duration:0 forState:MJRefreshStateIdle];
//    [header setImages:images duration:1.5 forState:MJRefreshStatePulling];
//    [header setImages:images duration:1.5 forState:MJRefreshStateRefreshing];
//    header.gifView.tintColor = [UIColor colorWithHex:0x7fd0ff];
//    header.backgroundColor = [UIColor clearColor];
    self.mj_header = header;
    
    
}

- (void)removeRefreshHeader {
    QCLogMethod();
    self.mj_header = nil;
}

- (void)headerRefreshingInvoked {
    if ([self.refreshDelegate respondsToSelector:@selector(QCRefreshTableViewDelegateHeaderRefreshingInvoked)]) {
        [self.refreshDelegate QCRefreshTableViewDelegateHeaderRefreshingInvoked];
    }
    QCLogMethod();
}

- (void)endHeaderRefreshing {
    QCLogMethod();
    !self.mj_header.isRefreshing ?: [self.mj_header endRefreshing];
}

- (void)addRefreshFooter {
    QCLogMethod();
    MJRefreshAutoNormalFooter *footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self
                                                                             refreshingAction:@selector(footerRefreshingInvoked)];
    [footer setTitle:@"正在加载更多" forState:MJRefreshStateRefreshing];
    [footer setTitle:@"正在加载更多" forState:MJRefreshStatePulling];
    [footer setTitle:@"加载更多" forState:MJRefreshStateIdle];
    [footer setTitle:@"已加载完成" forState:MJRefreshStateNoMoreData];

//    MJRefreshStateIdle = 1,
//    /** 松开就可以进行刷新的状态 */
//    MJRefreshStatePulling,
//    /** 正在刷新中的状态 */
//    MJRefreshStateRefreshing,
//    /** 即将刷新的状态 */
//    MJRefreshStateWillRefresh,
//    /** 所有数据加载完毕，没有更多的数据了 */
//    MJRefreshStateNoMoreData
    footer.backgroundColor = [UIColor clearColor];
    self.mj_footer = footer;
}

- (void)removeRefreshFooter {
    QCLogMethod();
    self.mj_footer = nil;
}

- (void)footerRefreshingInvoked {
    if ([self.refreshDelegate respondsToSelector:@selector(QCRefreshTableViewDelegateFooterRefreshingInvoked)]) {
        [self.refreshDelegate QCRefreshTableViewDelegateFooterRefreshingInvoked];
    }
    QCLogMethod();
}

- (void)endFooterRefreshing {
    QCLogMethod();
    !self.mj_footer.isRefreshing ?: [self.mj_footer endRefreshing];
}

#pragma mark - Property

- (void)setHasRefreshHeader:(BOOL)hasRefreshHeader {
    if (hasRefreshHeader == _hasRefreshHeader) {
        return;
    }
    
    [self willChangeValueForKey:@"hasRefreshHeader"];
    _hasRefreshHeader = hasRefreshHeader;
    hasRefreshHeader ? [self addRefreshHeader] : [self removeRefreshHeader];
    [self didChangeValueForKey:@"hasRefreshHeader"];
}

- (void)setHasRefreshFooter:(BOOL)hasRefreshFooter {
    if (hasRefreshFooter == _hasRefreshFooter) {
        return;
    }
    
    [self willChangeValueForKey:@"hasRefreshFooter"];
    _hasRefreshFooter = hasRefreshFooter;
    hasRefreshFooter ? [self addRefreshFooter] : [self removeRefreshFooter];
    [self didChangeValueForKey:@"hasRefreshFooter"];
}

- (void)refresh{
    [self.mj_header beginRefreshing];
}


@end
