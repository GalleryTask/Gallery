//
//  AddressListController.m
//  Gallery
//
//  Created by admin on 2018/11/15.
//  Copyright © 2018 安东. All rights reserved.
//

#import "AddressListController.h"
#import "AddressCell.h"
@interface AddressListController ()

@end

@implementation AddressListController

- (void)viewDidLoad {
  [super viewDidLoad];
  [self createInterfaceBuilder];
}
-(void)createInterfaceBuilder {
//  [self.tableView mas_remakeConstraints:^(MASConstraintMaker *make) {
//    make.top.with.left.height.equalTo(self);
//  }];
  
  [self.tableView registerClass:[AddressCell class] forCellReuseIdentifier:@"AddressCell"];
  [self.tableView setRowHeight:SCALE_SIZE*100];
  [self.tableView setContentInset:UIEdgeInsetsMake(0, 0, 0, 0)];
//  [self.tableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:2 inSection:0]
//                              animated:NO
//                        scrollPosition:UITableViewScrollPositionNone];
}
#pragma mark - tableview delegate dataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  
  return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  
  AddressCell *addressCell = [tableView dequeueReusableCellWithIdentifier:@"AddressCell" forIndexPath:indexPath];
  
  return addressCell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
  
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
