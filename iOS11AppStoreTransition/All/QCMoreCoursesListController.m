//
//  QCMoreCoursesListController.m
//  QingClassSaas
//
//  Created by weikeyan on 2017/10/18.
//  Copyright © 2017年 QingClass. All rights reserved.
//

#import "QCMoreCoursesListController.h"
#import "QCMoreCourseListCell.h"
#import "QCRefreshTableView.h"
@interface QCMoreCoursesListController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet QCRefreshTableView *tableView;

@end

@implementation QCMoreCoursesListController

- (void)viewDidLoad {
    [super viewDidLoad];
    [QCMoreCourseListCell registerToTableView:self.tableView];
    self.title = @"精品订阅课列表";
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 5;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 132;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    QCMoreCourseListCell *cell = [tableView dequeueReusableCellWithIdentifier:[QCMoreCourseListCell cellIdentifier] forIndexPath:indexPath];
   
    return cell;
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
