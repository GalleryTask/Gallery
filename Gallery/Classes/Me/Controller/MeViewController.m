//
//  MeViewController.m
//  Gallery
//
//  Created by 安东 on 2018/9/19.
//  Copyright © 2018年 安东. All rights reserved.
//

#import "MeViewController.h"
#import "MeOrderTableViewCell.h"
#import "MeTableViewCell.h"
#import "MeView.h"
@interface MeViewController ()<MeOrderTableViewCellDelegate,MeTableViewCellDelegate>
@property(nonatomic, strong)MeView *meView;
@end

@implementation MeViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  self.title = @"我的";
  [self createInterfaceBuilder];
}
-(void)viewWillAppear:(BOOL)animated {
  [super viewWillAppear:animated];
   BaseNavigationController *nav = (BaseNavigationController *)self.navigationController;
  [nav setNavigationBarHidden:YES animated:NO];
}
-(void)createInterfaceBuilder {
  [self.view addSubview:self.meView];

  [self.tableView setBackgroundColor:BASECOLOR_BACKGROUND_GRAY];
  [self.tableView registerClass:[MeOrderTableViewCell class] forCellReuseIdentifier:@"MeOrderTableViewCell"];
  [self.tableView registerClass:[MeTableViewCell class] forCellReuseIdentifier:@"MeTableViewCell"];
  
  self.tableView.separatorStyle =UITableViewCellSeparatorStyleNone;
  //self.tableView.contentInset = UIEdgeInsetsMake(0, 0, SCALE_SIZE*49, 0);
   // [self.tableView setFrame:CGRectMake(0, 300, SCREEN_WIDTH, SCREEN_HEIGHT-(SCALE_SIZE*113)-SafeAreaBottomHeight)];
  
  [self.tableView mas_remakeConstraints:^(MASConstraintMaker *make) {
    make.top.equalTo(self.meView.mas_bottom);
    make.width.equalTo(self.view);
    make.height.equalTo(self.view).offset(-SCALE_SIZE*113);
  }];
  [self.tableView setContentInset:UIEdgeInsetsMake(0, 0, 0, 0)];
}

#pragma mark - tableview delegate dataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
  return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  return 2;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  if (indexPath.row == 0) {
    MeOrderTableViewCell *orderCell = [tableView dequeueReusableCellWithIdentifier:@"MeOrderTableViewCell" forIndexPath:indexPath];
    orderCell.selectionStyle = UITableViewCellSelectionStyleNone;
    [orderCell setDelegate:self];
    return orderCell;
  }else{
    MeTableViewCell *meCell = [tableView dequeueReusableCellWithIdentifier:@"MeTableViewCell" forIndexPath:indexPath];
    meCell.selectionStyle = UITableViewCellSelectionStyleNone;
    [meCell setDelegate:self];
    return meCell;
  }
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
  
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
  if (indexPath.row == 0) {
    return SCALE_SIZE * 218;
  }else{
    return SCALE_SIZE * 152;
  }
}

#pragma mark - MeOrderTableViewCellDelegate

-(void)orderButtonIndex:(NSInteger)index {
  //0是全部订单，1是待付款，依次类推
}
#pragma mark =====物流点击事件
-(void)meLogisticsClick {
  
}
#pragma mark - MeTableViewCellDelegate
-(void)meCellButtonIndex:(NSInteger)index {
  //0时定制，依次类推
}
-(MeView *)meView {
  if (!_meView) {
    _meView = [[MeView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCALE_SIZE*113)];
    [_meView setBackgroundColor:BASECOLOR_BLACK_333];
  }
  return _meView;
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
