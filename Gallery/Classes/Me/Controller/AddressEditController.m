//
//  AddressEditController.m
//  Gallery
//
//  Created by admin on 2018/11/16.
//  Copyright © 2018 安东. All rights reserved.
//

#import "AddressEditController.h"
#import "AddressEditView.h"
@interface AddressEditController ()
@property (strong, nonatomic) AddressEditView *editView;
@end

@implementation AddressEditController

- (void)viewDidLoad {
  [super viewDidLoad];
  self.title = @"添加收获地址";
  [self createInterfaceBuilder];
}
-(void)viewWillAppear:(BOOL)animated {
  [super viewWillAppear:animated];
  [self settingNavigationRightButton];
}
-(void)createInterfaceBuilder {
  [self.view addSubview:self.editView];
}
-(void)settingNavigationRightButton {
  BaseNavigationController *nav = (BaseNavigationController *)self.navigationController;
  [nav setNavigationBarRightItemWithButtonTitle:@"保存"];
  [nav setNavigationBarRightItemWithImageName:@"" highlightImageName:@""];
  [nav showRightNavBtnWithClick:^(id sender) {
  }];
}

#pragma mark - getters
- (AddressEditView *)editView {
  if (!_editView) {
    _editView = [[AddressEditView alloc] initWithFrame:self.view.frame];
  }
  return _editView;
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
