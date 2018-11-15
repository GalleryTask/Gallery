//
//  PackagingTagController.m
//  Gallery
//
//  Created by 安东 on 15/11/2018.
//  Copyright © 2018 安东. All rights reserved.
//

#import "PackagingTagController.h"
// 方案定制标签
@interface PackagingTagController ()

@end

@implementation PackagingTagController

- (void)viewDidLoad {
    [super viewDidLoad];
  
  PackagingCustomView *customOne = [[PackagingCustomView alloc] init];
  NSInteger countRow = [customOne packagingCustomWithTitle:@"尺寸"
                                                itemsArray:@[@"大(50*30MM²)",@"中(30*15MM²)",@"小(20*10MM²)",@"自定义"]
                                              selectedItem:0
                                         selectedItemBlock:^(id  _Nonnull sender) {
                                           
                                         }];
  [self.scrollView addSubview:customOne];
  
  
  
  PackagingCustomView *customTwo = [[PackagingCustomView alloc] init];
  NSInteger countRowTwo = [customTwo packagingCustomWithTitle:@"材质"
                                                   itemsArray:@[@"铜版纸",@"牛皮纸",@"拉丝银",@"亚银材质"]
                                                 selectedItem:0
                                            selectedItemBlock:^(id  _Nonnull sender) {
                                              
                                            }];
  [self.scrollView addSubview:customTwo];
  
  
  [customOne mas_makeConstraints:^(MASConstraintMaker *make) {
    make.left.width.top.equalTo(self.scrollView);
    make.height.mas_equalTo(SCALE_SIZE*94+(SCALE_SIZE*44)*countRow);
  }];
  
  [customTwo mas_makeConstraints:^(MASConstraintMaker *make) {
    make.left.width.equalTo(self.scrollView);
    make.top.equalTo(customOne.mas_bottom);
    make.height.mas_equalTo(SCALE_SIZE*94+(SCALE_SIZE*44)*countRowTwo);
  }];
  [self.view layoutIfNeeded];
  [self.scrollView setContentSize:CGSizeMake(0, customTwo.frame.origin.y+customTwo.frame.size.height+SCALE_SIZE*60)];
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
