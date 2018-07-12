//
//  QCAllViewController.m
//  QingClassSaas
//
//  Created by weikeyan on 2017/10/10.
//  Copyright © 2017年 QingClass. All rights reserved.
//

#import "QCAllViewController.h"
#import "QCCourseCell.h"
#import "QCCoursesDetailController.h"
#import "Masonry.h"
#import "QCUIToobox.h"
#import "ReactiveObjC.h"
static const CGFloat sectionHeaderHeight = 52;
@interface QCAllViewController ()<UITableViewDelegate,UITableViewDataSource,UINavigationControllerDelegate>

@end

@implementation QCAllViewController
- (void)setUpNavigationItem{
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.tableView setContentInset:UIEdgeInsetsMake(-20, 0, 0, 0)];
    self.view.backgroundColor = [UIColor whiteColor];
    [QCCourseCell registerToTableView:self.tableView];
    [self.tableView setTableHeaderView:[self headerView]];
    self.tableView.separatorStyle = NO;
}
- (UIView*)headerView{
    return nil;
  
}
//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
//    return 106;
//}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 3;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return sectionHeaderHeight+12;
    }
    return sectionHeaderHeight;
}
#pragma mark - 自定义分组头部

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    static NSString * identifier = @"sectionHeader";
    UITableViewHeaderFooterView * hf = [tableView dequeueReusableHeaderFooterViewWithIdentifier:identifier];
    hf.backgroundColor = [UIColor whiteColor];
    if (!hf) {
        hf = [[UITableViewHeaderFooterView alloc]initWithReuseIdentifier:identifier];
        UIView * view1 = [[UIView alloc]init];
        view1.backgroundColor = [UIColor whiteColor];
        [hf addSubview:view1];
        
        [view1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.top.bottom.equalTo(@0);
            
        }];
        UIView * view = [[UIView alloc]init];
        view.backgroundColor = [UIColor whiteColor];
        [hf addSubview:view];
        
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(@0);
            make.height.equalTo(@28);
            make.bottom.equalTo(hf);
        }];
        
        UILabel * titleLabel = [[UILabel alloc]init];
        [view addSubview:titleLabel];
        titleLabel.text = @"精品订阅课";
        titleLabel.textColor = QCMakeColor(74, 74, 74, 1);
        titleLabel.font = [UIFont systemFontOfSize:18.f];
        [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(@12);
            make.centerY.equalTo(view);
            make.height.equalTo(@25);
            make.width.greaterThanOrEqualTo(@5);
        }];
        
        UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setBackgroundImage:[UIImage imageNamed:@"course_more"] forState:UIControlStateNormal];
        [view addSubview:button];
        button.backgroundColor = [UIColor clearColor];
        [button addTarget:self action:@selector(moreButtonPressed) forControlEvents:UIControlEventTouchUpInside];
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(view);
            make.height.equalTo(@28);
            make.width.equalTo(@56);
            make.right.equalTo(@(-12));

        }];
    }
    return hf;
}
- (void)moreButtonPressed{
}
- (nullable NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section{
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.1f;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    QCCourseCell *cell = [tableView dequeueReusableCellWithIdentifier:[QCCourseCell cellIdentifier] forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.indexRow = indexPath.row;
    @weakify(self);
    
    __weak QCCourseCell * weakCell = cell;
    cell.tapCoverImageBlock = ^(NSInteger tag) {
        @strongify(self);
        weakCell.imageContentView.transform = CGAffineTransformMakeScale(1.0f, 1.0f);
        [UIView animateWithDuration:0.3 animations:^{
            weakCell.imageContentView.transform=CGAffineTransformMakeScale(0.95f, 0.95f);
        } completion:^(BOOL finished) {
            weakCell.imageContentView.transform=CGAffineTransformIdentity;
            [self cardScrollViewDidSelectedAtIndex:tag];

        }];
    };
    return cell;
}

- (void)cardScrollViewDidSelectedAtIndex:(NSInteger)index{
    self.currentIndex = index;

    
    [UIView animateWithDuration:1 animations:^{
        self.navigationController.tabBarController.tabBar.frame = CGRectMake(0, self.view.frame.size.height+49, self.navigationController.tabBarController.tabBar.frame.size.width, self.navigationController.tabBarController.tabBar.frame.size.height);
        self.navigationController.view.frame = CGRectMake(0, 0, self.navigationController.view.frame.size.width, self.navigationController.view.frame.size.height+49);
        QCCoursesDetailController * vc = QCViewController(@"AllSb", @"QCCourseDetailVC");
        self.navigationController.delegate = vc;
        [self.navigationController pushViewController:vc animated:YES];

    }];
    
    

}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)searchButtonPressed:(id)sender {
    
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
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
