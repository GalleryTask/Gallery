//
//  PackagingDesignerController.m
//  Gallery
//
//  Created by 安东 on 15/11/2018.
//  Copyright © 2018 安东. All rights reserved.
//

#import "PackagingDesignerController.h"
#import "PackagingImageView.h"
// 方案定制平面设计
@interface PackagingDesignerController ()

@end

@implementation PackagingDesignerController

- (void)viewDidLoad {
  [super viewDidLoad];
  
  PackagingImageView *imgView = [[PackagingImageView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCALE_SIZE*132) images:@[] titles:@[] isUploadImage:NO];
  [self.scrollView addSubview:imgView];
  
  PackagingImageView *uploadImgView = [[PackagingImageView alloc] initWithFrame:CGRectMake(0, SCALE_SIZE*132, SCREEN_WIDTH, SCALE_SIZE*130) images:@[] titles:@[@"设计图位置一",@"设计图位置二",@"设计图位置三"] isUploadImage:YES];
  [self.scrollView addSubview:uploadImgView];
  
  PackagingCustomView *customOne = [[PackagingCustomView alloc] init];
  NSInteger countRow = [customOne packagingCustomWithTitle:@"主位/副位设计图工艺"
                                                itemsArray:@[@"水印",@"胶印哑膜",@"胶印亮膜"]
                                              selectedItem:0
                                         selectedItemBlock:^(id  _Nonnull sender) {
                                           
                                         }];
  [self.scrollView addSubview:customOne];
  
  
  
  PackagingCustomView *customTwo = [[PackagingCustomView alloc] init];
  NSInteger countRowTwo = [customTwo packagingCustomWithTitle:@"logo工艺"
                                                   itemsArray:@[@"烫金",@"UV"]
                                                 selectedItem:0
                                            selectedItemBlock:^(id  _Nonnull sender) {
                                              
                                            }];
  [self.scrollView addSubview:customTwo];
  
  PackagingCustomView *customThree = [[PackagingCustomView alloc] init];
  NSInteger countRowThree = [customThree packagingCustomWithTitle:@"服务"
                                                       itemsArray:@[@"一撕得包装设计服务"]
                                                     selectedItem:0
                                                selectedItemBlock:^(id  _Nonnull sender) {
                                                  
                                                }];
  [self.scrollView addSubview:customThree];
  
  
  [customOne mas_makeConstraints:^(MASConstraintMaker *make) {
    make.top.equalTo(uploadImgView.mas_bottom);
    make.left.width.equalTo(self.scrollView);
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
  [self.scrollView setContentSize:CGSizeMake(0, customThree.frame.origin.y+customThree.frame.size.height+SCALE_SIZE*60)];
}


@end
