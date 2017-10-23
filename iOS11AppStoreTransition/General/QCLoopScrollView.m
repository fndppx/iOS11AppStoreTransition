
//
//  QCLoopScrollView.m
//  QingClassSaas
//
//  Created by weikeyan on 2017/10/12.
//  Copyright © 2017年 QingClass. All rights reserved.
//

#import "QCLoopScrollView.h"
#import "UIImageView+WebCache.h"
#import "QCUIToobox.h"
static const NSInteger autoScrollDuration = 5;
@interface QCLoopScrollView()<UIScrollViewDelegate>{
    NSInteger _indexPage;
}
@property (nonatomic,strong)UIScrollView * contentScrollView;
@property (nonatomic,strong)UIImageView * leftImageView;
@property (nonatomic,strong)UIImageView * currentImageView;
@property (nonatomic,strong)UIImageView * nextImageView;
@property (nonatomic,strong)NSTimer * timer;
@property (nonatomic,strong)UIPageControl * pageControl;
@property (nonatomic,strong)UIButton * leftButton;
@property (nonatomic,strong)UIButton * currentButton;
@property (nonatomic,strong)UIButton * nextButton;

@end
@implementation QCLoopScrollView
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (void)setImageURLArray:(NSArray *)imageURLArray{
    _imageURLArray = imageURLArray;
    _pageControl.numberOfPages = _imageURLArray.count;
    [self setScrollViewOfImage];
}
- (void)setupScrollView{
    _contentScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    _contentScrollView.contentSize = CGSizeMake(self.frame.size.width*3, self.frame.size.height);
    _contentScrollView.pagingEnabled = YES;
    _contentScrollView.showsHorizontalScrollIndicator = NO;
    _contentScrollView.bounces = NO;
    _contentScrollView.delegate = self;
    _contentScrollView.backgroundColor = [UIColor blackColor];
    [self addSubview:_contentScrollView];
    
    _leftImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
//    _leftImageView.contentMode = UIViewContentModeScaleAspectFit;
    [_contentScrollView addSubview:_leftImageView];
    
    _leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _leftButton.frame = CGRectMake((_contentScrollView.frame.size.width-125)*0.5, _contentScrollView.frame.size.height-35-24, 125, 35);
    [_leftButton setTitle:@"查看更多" forState:UIControlStateNormal];
    _leftButton.backgroundColor = [UIColor whiteColor];
    _leftButton.layer.cornerRadius = _leftButton.frame.size.height*0.5;
    [_leftImageView addSubview:_leftButton];
    
    _currentImageView = [[UIImageView alloc]initWithFrame:CGRectMake(self.frame.size.width, 0, self.frame.size.width, self.frame.size.height)];
//    _currentImageView.contentMode = UIViewContentModeScaleAspectFit;
    [_contentScrollView addSubview:_currentImageView];
    
    _currentButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _currentButton.frame = CGRectMake((_contentScrollView.frame.size.width-125)*0.5, _contentScrollView.frame.size.height-35-24, 125, 35);
    _currentButton.backgroundColor = [UIColor whiteColor];
    _currentButton.layer.cornerRadius = _currentButton.frame.size.height*0.5;
    [_currentImageView addSubview:_currentButton];
    [_currentButton setTitle:@"查看更多" forState:UIControlStateNormal];
    
    _nextImageView = [[UIImageView alloc]initWithFrame:CGRectMake(self.frame.size.width*2, 0, self.frame.size.width, self.frame.size.height)];
//    _currentImageView.contentMode = UIViewContentModeScaleAspectFit;
    [_contentScrollView addSubview:_nextImageView];
    
    _nextButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _nextButton.frame = CGRectMake((_contentScrollView.frame.size.width-125)*0.5, _contentScrollView.frame.size.height-35-24, 125, 35);
    _nextButton.backgroundColor = [UIColor whiteColor];
    _nextButton.layer.cornerRadius = _nextButton.frame.size.height*0.5;
    [_nextImageView addSubview:_nextButton];
    [_nextButton setTitle:@"查看更多" forState:UIControlStateNormal];

    _timer = [NSTimer scheduledTimerWithTimeInterval:autoScrollDuration target:self selector:@selector(timerAction) userInfo:nil repeats:YES];
    
}
- (void)timerAction{
    [self.contentScrollView setContentOffset:CGPointMake(self.frame.size.width*2, 0) animated:YES];
}

- (void)setScrollViewOfImage{
    [self.currentImageView sd_setImageWithURL:[NSURL URLWithString:self.imageURLArray[_indexPage]] placeholderImage:[UIImage imageNamed:@""]];
    [self.leftImageView sd_setImageWithURL:[NSURL URLWithString:self.imageURLArray[_indexPage]] placeholderImage:[UIImage imageNamed:@""]];
    [self.nextImageView sd_setImageWithURL:[NSURL URLWithString:self.imageURLArray[_indexPage]] placeholderImage:[UIImage imageNamed:@""]];
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    CGFloat offset  = scrollView.contentOffset.x;
    if (offset == 0) {
        _indexPage = [self getLastImageViewIndexWithCurrentImageIndexPage:_indexPage];
    }else if (offset == self.frame.size.width*2){
        _indexPage = [self getNextImageViewIndexWithCurrentImageIndexPage:_indexPage];
    }
    
    [self setScrollViewOfImage];
    [scrollView setContentOffset:CGPointMake(self.frame.size.width, 0) animated:NO];
    if (_timer==nil) {
        self.timer = [NSTimer scheduledTimerWithTimeInterval:autoScrollDuration target:self selector:@selector(timerAction) userInfo:nil repeats:YES];
    }
}
- (NSInteger)getNextImageViewIndexWithCurrentImageIndexPage:(NSInteger)indexPage{
    NSInteger tempIndex = indexPage+1;
    return tempIndex < self.imageURLArray.count?tempIndex:0;
}
- (NSInteger)getLastImageViewIndexWithCurrentImageIndexPage:(NSInteger)indexPage{
    NSInteger tempIndex = indexPage-1;
    if (tempIndex==-1) {
        return self.imageURLArray.count-1;
    }else{
        return tempIndex;
    }
}
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    [_timer invalidate];
    _timer = nil;
}
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    if (!decelerate) {
        [self scrollViewDidEndDecelerating:scrollView];
    }
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    _pageControl.currentPage = _indexPage;
}
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView{
    [self scrollViewDidEndDecelerating:_contentScrollView];
}
- (void)setupPageControl{
    _pageControl = [[UIPageControl alloc] init];
    _pageControl.frame = CGRectMake(24, _contentScrollView.frame.size.height-20-19, 40, 20);//指定位置大小
    _pageControl.pageIndicatorTintColor = QCMakeColor(255, 255, 255, 0.5);// 设置非选中页的圆点颜色
    _pageControl.currentPageIndicatorTintColor = QCMakeColor(255, 255, 255, 1); // 设置选中页的圆点颜色
    [self addSubview:_pageControl];
}

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        _imageURLArray = [NSMutableArray arrayWithCapacity:0];
        _indexPage = 0;
        [self setupScrollView];
        [self setupPageControl];
    }
    return self;
}
@end
