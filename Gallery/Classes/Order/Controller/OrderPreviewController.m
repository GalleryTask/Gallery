//
//  OrderPreviewController.m
//  Gallery
//
//  Created by 安东 on 16/11/2018.
//  Copyright © 2018 安东. All rights reserved.
//

#import "OrderPreviewController.h"

@interface OrderPreviewController ()

@end

@implementation OrderPreviewController

-(void)viewDidLoad {
  [super viewDidLoad];
  self.navigationItem.title = @"清单明细";
}

-(void)viewDidAppear:(BOOL)animated {
  [super viewDidAppear:animated];
  
  BaseNavigationController *nav = (BaseNavigationController *)self.navigationController;
  [nav setNavigationBarRightItemWithButtonTitle:@"保存"];
  [nav setNavigationBarRightItemWithImageName:@"" highlightImageName:@""];
}


#pragma mark tableview delegate
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  
  UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
  return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  
  return 0;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
  
  [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
