//
//  QCCoursesDetailController.m
//  QingClassSaas
//
//  Created by weikeyan on 2017/10/16.
//  Copyright © 2017年 QingClass. All rights reserved.
//

#import "QCCoursesDetailController.h"
#import "QCCardTransition.h"
#import "QCUIToobox.h"
#import "UIImageView+WebCache.h"
@interface QCCoursesDetailController ()<UIScrollViewDelegate>
@property (nonatomic,strong)    UIPercentDrivenInteractiveTransition *percentDrivenTransition;
@property (weak, nonatomic) IBOutlet UIButton *priceLabel;
@property (weak, nonatomic) IBOutlet UIScrollView *contentScrollView;
@property (weak, nonatomic) IBOutlet UIButton *tipPriceLabel;
@property (weak, nonatomic) IBOutlet UIView *floatBuyView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *floatBuyViewToDownGap;
@property (weak, nonatomic) IBOutlet UIView *downPriceView;
@property (weak, nonatomic) IBOutlet UIView *navgationBarView;
@property (weak, nonatomic) IBOutlet UIButton *navigationPriceButton;
@property (weak, nonatomic) IBOutlet UIView *buyButton;
@property (weak, nonatomic) IBOutlet UIView *endBottomBuyView;
@property (weak, nonatomic) IBOutlet UIView *endBottomBuyContentView;

@end

@implementation QCCoursesDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.floatBuyViewToDownGap.constant = - self.floatBuyView.frame.size.height;
    self.tipPriceLabel.layer.cornerRadius = self.tipPriceLabel.frame.size.height*0.5;
    self.tipPriceLabel.layer.masksToBounds = YES;
    
    self.floatBuyView.backgroundColor = QCMakeColor(0, 0, 0, 0.2);
    self.floatBuyView.layer.cornerRadius = 5.f;
    self.floatBuyView.layer.masksToBounds = YES;
    
    self.navigationPriceButton.layer.cornerRadius = self.navigationPriceButton.frame.size.height*0.5;
    self.navigationPriceButton.layer.masksToBounds = YES;
    
    self.endBottomBuyView.layer.cornerRadius = 5.f;
    self.endBottomBuyView.layer.masksToBounds = YES;
    
    self.buyButton.layer.cornerRadius = 5.f;
    self.buyButton.layer.masksToBounds = YES;
    
    self.floatBuyView.layer.cornerRadius = 5.f;
    self.floatBuyView.layer.masksToBounds = YES;
//    [self.contentScrollView setContentInset:UIEdgeInsetsMake(-20, 0, 0, 0)];
    self.contentScrollView.contentSize = CGSizeMake(self.contentScrollView.frame.size.width, self.contentScrollView.contentSize.height-20);
    // Do any additional setup after loading the view.
    self.priceLabel.layer.masksToBounds = YES;
    self.priceLabel.layer.cornerRadius = self.priceLabel.frame.size.height*0.5;
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    [self.headImageView sd_setImageWithURL:[NSURL URLWithString:@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1508999472&di=e8aa5d62d2b19bec67519f7d3071d724&imgtype=jpg&er=1&src=http%3A%2F%2Fimages.17173.com%2F2012%2Fnews%2F2012%2F04%2F27%2Fy0427fc01s.jpg"] placeholderImage:nil];
//    UIScreenEdgePanGestureRecognizer *edgePanGestureRecognizer = [[UIScreenEdgePanGestureRecognizer alloc]initWithTarget:self action:@selector(edgePanGesture:)];
//    //设置从什么边界滑入
//    edgePanGestureRecognizer.edges = UIRectEdgeLeft;
//    [self.view addGestureRecognizer:edgePanGestureRecognizer];
    
}

- (id <UIViewControllerInteractiveTransitioning>)navigationController:(UINavigationController *)navigationController
                          interactionControllerForAnimationController:(id <UIViewControllerAnimatedTransitioning>) animationController{
    return self.percentDrivenTransition;
}
-(void)edgePanGesture:(UIPanGestureRecognizer *)recognizer{
    //计算手指滑的物理距离（滑了多远，与起始位置无关）
    CGFloat progress = [recognizer translationInView:self.view].x / (self.view.bounds.size.width * 1.0);
    progress = MIN(1.0, MAX(0.0, progress));//把这个百分比限制在0~1之间
    
    //当手势刚刚开始，我们创建一个 UIPercentDrivenInteractiveTransition 对象
    if (recognizer.state == UIGestureRecognizerStateBegan) {
        self.percentDrivenTransition = [[UIPercentDrivenInteractiveTransition alloc]init];
        [self.navigationController popViewControllerAnimated:YES];
    }else if (recognizer.state == UIGestureRecognizerStateChanged){
        //当手慢慢划入时，我们把总体手势划入的进度告诉 UIPercentDrivenInteractiveTransition 对象。
        [self.percentDrivenTransition updateInteractiveTransition:progress];
    }else if (recognizer.state == UIGestureRecognizerStateCancelled || recognizer.state == UIGestureRecognizerStateEnded){
        //当手势结束，我们根据用户的手势进度来判断过渡是应该完成还是取消并相应的调用 finishInteractiveTransition 或者 cancelInteractiveTransition 方法.
        if (progress > 0.5) {
            [self.percentDrivenTransition finishInteractiveTransition];
        }else{
            [self.percentDrivenTransition cancelInteractiveTransition];
        }
        self.percentDrivenTransition = nil;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)goBackButtonPressed:(id)sender {
    [UIView animateWithDuration:1 animations:^{
        self.navigationController.tabBarController.tabBar.frame = CGRectMake(0, self.view.frame.size.height-49, self.navigationController.tabBarController.tabBar.frame.size.width, self.navigationController.tabBarController.tabBar.frame.size.height);
        self.navigationController.view.frame = CGRectMake(0, 0, self.navigationController.view.frame.size.width, self.navigationController.view.frame.size.height-49);
        [self.navigationController popViewControllerAnimated:YES];
    }];
}
- (id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController animationControllerForOperation:(UINavigationControllerOperation)operation fromViewController:(UIViewController *)fromVC toViewController:(UIViewController *)toVC {
    //分pop和push两种情况分别返回动画过渡代理相应不同的动画操作
    return [QCCardTransition transitionWithType:operation == UINavigationControllerOperationPush ? QCCardTransitionTypePush : QCCardTransitionTypePop];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    CGRect priceViewRect = [self.contentScrollView convertRect:self.downPriceView.frame toView:self.view];
    
    CGRect downPriceViewRect = [self.contentScrollView convertRect:self.endBottomBuyContentView.frame toView:self.view];

    if(((priceViewRect.origin.y>-self.downPriceView.frame.size.height)&&downPriceViewRect.origin.y<=self.view.frame.size.height)||(priceViewRect.origin.y<=-self.downPriceView.frame.size.height&&downPriceViewRect.origin.y>self.view.frame.size.height)){
        [UIView animateWithDuration:1 delay:0 usingSpringWithDamping:0.9 initialSpringVelocity:0 options:UIViewAnimationOptionAllowUserInteraction animations:^{
            self.navgationBarView.alpha = 1;
            self.floatBuyView.frame = CGRectMake(self.floatBuyView.frame.origin.x, self.view.frame.size.height-12-self.floatBuyView.frame.size.height, self.floatBuyView.frame.size.width, self.floatBuyView.frame.size.height);
            [self.floatBuyView layoutIfNeeded];
        } completion:^(BOOL finished) {
            
        }];
    }else{
        [UIView animateWithDuration:1 delay:0 usingSpringWithDamping:0.9 initialSpringVelocity:0 options:UIViewAnimationOptionAllowUserInteraction animations:^{
            if (priceViewRect.origin.y>-self.downPriceView.frame.size.height) {
                self.navgationBarView.alpha = 0;
            }else{
                self.navgationBarView.alpha = 1;
            }
            self.floatBuyView.frame = CGRectMake(self.floatBuyView.frame.origin.x, self.view.frame.size.height+self.floatBuyView.frame.size.height, self.floatBuyView.frame.size.width, self.floatBuyView.frame.size.height);
            [self.floatBuyView layoutIfNeeded];
        } completion:^(BOOL finished) {
            
        }];
    }
}
/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end

