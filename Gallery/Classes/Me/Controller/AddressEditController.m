//
//  AddressEditController.m
//  Gallery
//
//  Created by admin on 2018/11/16.
//  Copyright © 2018 安东. All rights reserved.
//

#import "AddressEditController.h"
#import "AddressEditView.h"
@interface AddressEditController ()<AddressEditDelegate>
@property (strong, nonatomic) AddressEditView *editView;
@end

@implementation AddressEditController

- (void)viewDidLoad {
  [super viewDidLoad];
  self.title = @"添加收获地址";
  [self createInterfaceBuilder];
  [self settingNavigationRightButton];
}



-(void)createInterfaceBuilder {
  [self.view addSubview:self.editView];
}

-(void)settingNavigationRightButton {
  BaseNavigationController *nav = (BaseNavigationController *)self.navigationController;
  @weakify(self);
  [nav setNavigationBarRightItemWithButtonTitle:@"保存" clickBlock:^(id sender) {
    @strongify(self);
    [self saveButtonClick];
  }];

}
-(void)saveButtonClick{
  if ([self.editView.nameTextField.text isEqualToString:@""]) {
    [CommonUtil promptViewWithText:@"请输入收货人姓名" view:self.editView hidden:YES];
    return;
  }
  if ([self.editView.phoneTextField.text isEqualToString:@""]) {
    [CommonUtil promptViewWithText:@"请输入配送员联系您的电话" view:self.editView hidden:YES];
    return;
  }
  if ([self.editView.cityBtn.titleLabel.text isEqualToString:@"选择您所在的城市"]) {
    [CommonUtil promptViewWithText:@"选择您所在的城市" view:self.editView hidden:YES];
    return;
  }
  if ([self.editView.addressTextField.text isEqualToString:@""]) {
    [CommonUtil promptViewWithText:@"请输入收货地址" view:self.editView hidden:YES];
    return;
  }
  if ([self.editView.addressTextField.text isEqualToString:@""]) {
    [CommonUtil promptViewWithText:@"请输入楼号门牌" view:self.editView hidden:YES];
    return;
  }
}

#pragma mark -------AddressEditDelegate

#pragma mark -------地址类型的代理
-(void)addressEditType:(NSString *)typeString{
  
}
#pragma mark -------是否设置默认地址
-(void)addressEditDefaultSwitch:(BOOL)isOn{
  
}

#pragma mark - getters
- (AddressEditView *)editView {
  if (!_editView) {
    _editView = [[AddressEditView alloc] initWithFrame:self.view.frame];
    _editView.delegate = self;
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
