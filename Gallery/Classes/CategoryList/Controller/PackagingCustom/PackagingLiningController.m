//
//  PackagingLiningController.m
//  Gallery
//
//  Created by 安东 on 13/11/2018.
//  Copyright © 2018 安东. All rights reserved.
//

#import "PackagingLiningController.h"

// 方案定制内衬
@interface PackagingLiningController ()

@end

@implementation PackagingLiningController

- (void)viewDidLoad {
  [super viewDidLoad];
  
  PackagingCustomView *customOne = [[PackagingCustomView alloc] init];
  NSInteger countRow = [customOne packagingCustomWithTitle:@"EPE结构（不需要EPE网套）"
                                                itemsArray:@[@"结构一 / 规格18g/L",@"结构二 / 规格18g/L"]
                                              selectedItem:0
                                         selectedItemBlock:^(id  _Nonnull sender) {
                                           
                                         }];
  [self.scrollView addSubview:customOne];
  
  
  
  PackagingCustomView *customTwo = [[PackagingCustomView alloc] init];
  NSInteger countRowTwo = [customTwo packagingCustomWithTitle:@"瓦楞卡纸"
                                                   itemsArray:@[@"B楞",@"E楞"]
                                                 selectedItem:0
                                            selectedItemBlock:^(id  _Nonnull sender) {
                                              
                                            }];
  [self.scrollView addSubview:customTwo];
  
  
  
  PackagingCustomView *customThree = [[PackagingCustomView alloc] init];
  NSInteger countRowThree = [customThree packagingCustomWithTitle:@"吸塑托"
                                                       itemsArray:@[@"PET",@"PP"]
                                                     selectedItem:0
                                                selectedItemBlock:^(id  _Nonnull sender) {
                                                  
                                                }];
  [self.scrollView addSubview:customThree];
  
  [customOne mas_makeConstraints:^(MASConstraintMaker *make) {
    make.left.width.top.equalTo(self.scrollView);
    make.height.mas_equalTo(SCALE_SIZE*94+(SCALE_SIZE*44)*countRow);
  }];
  
  [customTwo mas_makeConstraints:^(MASConstraintMaker *make) {
    make.left.width.equalTo(self.scrollView);
    make.top.equalTo(customOne.mas_bottom);
    make.height.mas_equalTo(SCALE_SIZE*94+(SCALE_SIZE*44)*countRowTwo);
  }];
  
  [customThree mas_makeConstraints:^(MASConstraintMaker *make) {
    make.left.width.equalTo(self.scrollView);
    make.top.equalTo(customTwo.mas_bottom);
    make.height.mas_equalTo(SCALE_SIZE*94+(SCALE_SIZE*44)*countRowThree);
  }];
  [self.view layoutIfNeeded];
  [self.scrollView setContentSize:CGSizeMake(0, customThree.frame.origin.y+customThree.frame.size.height+SCALE_SIZE*60+SafeAreaBottomHeight)];
  

}


@end
