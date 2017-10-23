//
//  QCCardTransition.m
//  QingClassSaas
//
//  Created by weikeyan on 2017/10/16.
//  Copyright © 2017年 QingClass. All rights reserved.
//

#import "QCCardTransition.h"
#import "QCAllViewController.h"
#import "QCCoursesDetailController.h"
#import "QCCourseCell.h"
#import "AppDelegate.h"
@interface QCCardTransition()
/**
 *  动画过渡代理管理的是push还是pop
 */
@property (nonatomic, assign) QCCardTransitionType type;
@property (nonatomic,strong) CADisplayLink *displayLink;
@property  NSInteger animationCount; // 动画的数量
@property (nonatomic, strong) UIView *assistView;
@property (nonatomic, strong) UIView *cellContentView;


@end
@implementation QCCardTransition

+ (instancetype)transitionWithType:(QCCardTransitionType)type{
    return [[self alloc] initWithTransitionType:type];
}

- (instancetype)initWithTransitionType:(QCCardTransitionType)type{
    self = [super init];
    if (self) {
        _type = type;
    }
    return self;
}

/**
 *  动画时长
 */
- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext {
    return 1.f;
}

/**
 *  如何执行过渡动画
 */
- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
    switch (_type) {
        case QCCardTransitionTypePush:
            [self pushAnimation:transitionContext];
            break;
            
        case QCCardTransitionTypePop:
            [self popAnimation:transitionContext];
            break;
    }
}

// 执行push过渡动画
- (void)pushAnimation:(id<UIViewControllerContextTransitioning>)transitionContext {
    //起始页面
    QCAllViewController *fromVC = (QCAllViewController *)[transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    //目标页面
    QCCoursesDetailController *toVC = (QCCoursesDetailController *)[transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    QCCourseCell *cell;
    NSArray *cellArray = [fromVC.tableView visibleCells];
    for (int i = 0; i < cellArray.count; i++) {
        if (fromVC.currentIndex == [cellArray[i] indexRow] ) {
            cell = (QCCourseCell *)cellArray[i];
        }
    }
    UIView *containerView = [transitionContext containerView];
    UIView *bgView = [cell.tempView snapshotViewAfterScreenUpdates:YES];
    bgView.tag=20000;
    bgView.frame = [cell.tempView convertRect:cell.tempView.bounds toView: containerView];
    
    UIImageView * contentView = [[UIImageView alloc]initWithImage:[self snapshot:cell.headImageView]];
    
    contentView.tag=20001;
    contentView.frame = [cell.headImageView convertRect:cell.headImageView.bounds toView: containerView];
    contentView.layer.masksToBounds = YES;
    contentView.contentMode = UIViewContentModeScaleAspectFill;
    contentView.backgroundColor = [UIColor redColor];
    cell.headImageView.hidden = YES;
    toVC.headImageView.hidden = YES;

    toVC.view.alpha = 0;
    
    UIView *downView =  [cell.downView snapshotViewAfterScreenUpdates:YES];
    downView.tag=20002;

    downView.frame = [cell.downView convertRect:cell.downView.bounds toView: containerView];

    UIView *priceView = [cell.priceView snapshotViewAfterScreenUpdates:NO];
    priceView.frame = [cell.priceView convertRect:cell.priceView.bounds toView: containerView];
    priceView.tag=20003;
    
    UIView *titleLabel = [cell.titleLabel resizableSnapshotViewFromRect:cell.titleLabel.bounds
                                                        afterScreenUpdates:YES withCapInsets:UIEdgeInsetsZero];
    titleLabel.frame = [cell.titleLabel convertRect:cell.titleLabel.bounds toView: containerView];
    titleLabel.tag=20004;
    

    [containerView addSubview:toVC.view];
    [containerView addSubview:bgView];
    [containerView addSubview:contentView];
    [containerView addSubview:downView];
    [containerView addSubview:priceView];
    [containerView addSubview:titleLabel];
    
    [UIView animateWithDuration:1 delay:0 usingSpringWithDamping:0.7 initialSpringVelocity:0 options:UIViewAnimationOptionAllowUserInteraction animations:^{
        bgView.frame = CGRectMake(0, 0, toVC.view.frame.size.width, toVC.view.frame.size.height);
        contentView.frame = CGRectMake(0, 0, toVC.view.frame.size.width, 400);
        priceView.frame = CGRectMake(toVC.view.frame.size.width-priceView.frame.size.width-24, 444, priceView.frame.size.width, priceView.frame.size.height);
        downView.frame = CGRectMake(0, 400, toVC.view.frame.size.width, 116);
        titleLabel.frame = CGRectMake(24, 400+(116-titleLabel.frame.size.height)*0.5,titleLabel.frame.size.width, titleLabel.frame.size.height);
       
    } completion:^(BOOL finished) {
        [transitionContext completeTransition:YES];
        toVC.headImageView.hidden = NO;
        bgView.hidden = YES;
        contentView.hidden = YES;
        priceView.hidden = YES;
        titleLabel.hidden = YES;
        downView.hidden = YES;
        toVC.view.alpha = 1;
    }];
    
}
- (UIImage *)snapshot:(UIView *)view
{
    UIGraphicsBeginImageContextWithOptions(view.bounds.size, YES, 0);
    [view drawViewHierarchyInRect:view.bounds afterScreenUpdates:YES];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
    
}//执行pop过渡动画
- (void)popAnimation:(id<UIViewControllerContextTransitioning>)transitionContext {
    
    QCCoursesDetailController *fromVC = (QCCoursesDetailController *)[transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    QCAllViewController *toVC = (QCAllViewController *)[transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];

    QCCourseCell *cell;
    NSArray *cellArray = [toVC.tableView visibleCells];
    for (int i = 0; i < cellArray.count; i++) {
        if (toVC.currentIndex == [cellArray[i] indexRow] ) {
            cell = (QCCourseCell *)cellArray[i];
        }
    }
    UIView *containerView = [transitionContext containerView];
    UIView *bgView = [containerView viewWithTag:20000];
    UIView *contentView = [containerView viewWithTag:20001];
    self.assistView = [[UIView alloc]init];
    self.assistView.frame = contentView.frame;
    [containerView addSubview:self.assistView];

    self.cellContentView = contentView;
    UIView *downView = [containerView viewWithTag:20002];
    UIView *priceView = [containerView viewWithTag:20003];
    UIView *titleLabel = [containerView viewWithTag:20004];
  

    fromVC.headImageView.hidden = YES;
    bgView.hidden = NO;
    contentView.hidden = NO;
    downView.hidden = NO;
    titleLabel.hidden = NO;
    priceView.hidden = NO;
    fromVC.view.alpha = 0;
    [containerView insertSubview:toVC.view atIndex:0];
    
    UIView * effectBgView = [[UIView alloc]init];
    effectBgView.backgroundColor = [UIColor clearColor];
    effectBgView.frame = fromVC.view.bounds;
    [toVC.view addSubview:effectBgView];
    
    UIBlurEffect *effect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
    UIVisualEffectView *effectView = [[UIVisualEffectView alloc] initWithEffect:effect];
    effectView.frame = CGRectMake(0, 0, effectBgView.frame.size.width, effectBgView.frame.size.height);
    [effectBgView addSubview:effectView];
//    [UIView animateWithDuration:0.05 animations:^{
//        bgView.frame = CGRectMake(30, 40, bgView.frame.size.width-60, bgView.frame.size.height-80);
//        contentView.frame = CGRectMake(30, 40, contentView.frame.size.width-60, 500);
//    } completion:^(BOOL finished) {
//        [effectBgView removeFromSuperview];
    [self beforeAnimation];
        [UIView animateWithDuration:1.5 delay:0 usingSpringWithDamping:0.7 initialSpringVelocity:0 options:UIViewAnimationOptionAllowUserInteraction animations:^{
            bgView.frame = [cell.imageContentView convertRect:cell.imageContentView.bounds toView:containerView];
            contentView.frame = [cell.headImageView convertRect:cell.headImageView.bounds toView:containerView];
            downView.frame = [cell.downView convertRect:cell.downView.bounds toView:containerView];
            priceView.frame = [cell.priceView convertRect:cell.priceView.bounds toView:containerView];
            self.assistView.frame = contentView.frame;
            titleLabel.frame = [cell.titleLabel convertRect:cell.titleLabel.bounds toView:containerView];

            effectBgView.alpha = 0;
            
        } completion:^(BOOL finished) {
            [self finishAnimation];
            [effectBgView removeFromSuperview];
            cell.imageContentView.hidden = NO;
            cell.headImageView.hidden = NO;
            [downView removeFromSuperview];
            [priceView removeFromSuperview];
            [bgView removeFromSuperview];
            [contentView removeFromSuperview];
            [titleLabel removeFromSuperview];
            [transitionContext completeTransition:YES];
        }];
//    }];
   
}

//动画之前调用
-(void)beforeAnimation{
    if (self.displayLink == nil) {
        self.displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(displayLinkAction)];
        [self.displayLink addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSDefaultRunLoopMode];
    }
    self.animationCount ++;
}

//动画完成之后调用
-(void)finishAnimation{
    self.animationCount --;
    if (self.animationCount == 0) {
        [self.displayLink invalidate];
        self.displayLink = nil;
        [self.assistView removeFromSuperview];
        
    }
}
- (void)displayLinkAction
{
    CALayer *sideHelperPresentationLayer   =  (CALayer *)[self.assistView.layer presentationLayer];
    CGRect sideRect = [[sideHelperPresentationLayer valueForKeyPath:@"frame"]CGRectValue];
    UIView *contentView = self.cellContentView;
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, sideRect.size.width, sideRect.size.height) byRoundingCorners:UIRectCornerTopLeft | UIRectCornerTopRight cornerRadii:CGSizeMake(5,5)];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = CGRectMake(0, 0, sideRect.size.width, sideRect.size.height);
    maskLayer.path = maskPath.CGPath;
    contentView.layer.mask = maskLayer;
}
@end
