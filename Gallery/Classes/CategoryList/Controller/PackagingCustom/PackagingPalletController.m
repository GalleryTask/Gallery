//
//  PackagingPalletController.m
//  Gallery
//
//  Created by 安东 on 13/11/2018.
//  Copyright © 2018 安东. All rights reserved.
//

#import "PackagingPalletController.h"
#import "PackagingCustomView.h"

// 方案定制托盘
@interface PackagingPalletController ()

@end

@implementation PackagingPalletController

- (void)viewDidLoad {
    [super viewDidLoad];
  
  PackagingCustomView *customOne = [[PackagingCustomView alloc] init];
  NSInteger countRow = [customOne packagingCustomWithTitle:@"标准"
                                                itemsArray:@[@"国际",@"欧标"]
                                              selectedItem:0
                                         selectedItemBlock:^(id  _Nonnull sender) {
                                           
                                         }];
  [self.scrollView addSubview:customOne];
  
  
  
  PackagingCustomView *customTwo = [[PackagingCustomView alloc] init];
  NSInteger countRowTwo = [customTwo packagingCustomWithTitle:@"托盘"
                                                   itemsArray:@[@"塑料托盘",@"金属托盘",@"吸塑托盘",@"泡沫托盘",@"盘",@"泡沫托盘"]
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

- (void)viewDidLayoutSubviews {
  [super viewDidLayoutSubviews];
  
}
@end
