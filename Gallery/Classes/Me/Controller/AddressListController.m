//
//  AddressListController.m
//  Gallery
//
//  Created by admin on 2018/11/15.
//  Copyright © 2018 安东. All rights reserved.
//

#import "AddressListController.h"
#import "AddressCell.h"
#import "AddressEditController.h"
@interface AddressListController ()<AddressCellDelegate>

@end

@implementation AddressListController

- (void)viewDidLoad {
  [super viewDidLoad];
  self.title = @"我的收获地址";
  [self createInterfaceBuilder];
}
-(void)viewWillAppear:(BOOL)animated {
  [super viewWillAppear:animated];
  [self settingNavigationRightButton];
}
-(void)createInterfaceBuilder {
  [self.tableView setBackgroundColor:BASECOLOR_BACKGROUND_GRAY];
  [self.tableView registerClass:[AddressCell class] forCellReuseIdentifier:@"AddressCell"];
  [self.tableView setRowHeight:SCALE_SIZE*100];
  [self.tableView setContentInset:UIEdgeInsetsMake(0, 0, 0, 0)];
}
-(void)settingNavigationRightButton{
  BaseNavigationController *nav = (BaseNavigationController *)self.navigationController;
  [nav setNavigationBarRightItemWithButtonTitle:@"增加新地址"];
  [nav setNavigationBarRightItemWithImageName:@"" highlightImageName:@""];
  @weakify(self);
  [nav showRightNavBtnWithClick:^(id sender) {
    @strongify(self);
    [self pushController];
  }];
}
#pragma mark - tableview delegate dataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  
  return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  
  AddressCell *addressCell = [tableView dequeueReusableCellWithIdentifier:@"AddressCell" forIndexPath:indexPath];
  addressCell.selectionStyle = UITableViewCellSelectionStyleNone;
  [addressCell setDelegate:self];
  return addressCell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
  
}
-(void)addressCelleditBtnClick{
  [self pushController];
}
-(void)pushController {
  AddressEditController *editVC = [[AddressEditController alloc] init];
  [self.navigationController pushViewController:editVC animated:YES];
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
