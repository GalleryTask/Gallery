//
//  PackagingStandardController.m
//  Gallery
//
//  Created by 安东 on 15/11/2018.
//  Copyright © 2018 安东. All rights reserved.
//

#import "PackagingStandardController.h"

// 方案定制规格
@interface PackagingStandardController ()

@property (nonatomic, strong) UILabel  *titleLabel;
@property (nonatomic, strong) UILabel  *longLabel;
@property (nonatomic, strong) UILabel  *widthLabel;
@property (nonatomic, strong) UILabel  *heightLabel;

@end

@implementation PackagingStandardController

- (void)viewDidLoad {
  [super viewDidLoad];
  
  PackagingCustomView *customOne = [[PackagingCustomView alloc] init];
  NSInteger countRow = [customOne packagingCustomWithTitle:@"材料"
                                                itemsArray:@[@"白卡纸",@"牛皮纸"]
                                              selectedItem:0
                                         selectedItemBlock:^(id  _Nonnull sender) {
                                           
                                         }];
  [self.scrollView addSubview:customOne];
  
  
  
  PackagingCustomView *customTwo = [[PackagingCustomView alloc] init];
  NSInteger countRowTwo = [customTwo packagingCustomWithTitle:@"内容物规格"
                                                   itemsArray:@[@"6个装",@"8个装",@"16个装",@"20个装"]
                                                 selectedItem:0
                                            selectedItemBlock:^(id  _Nonnull sender) {
                                              
                                            }];
  [self.scrollView addSubview:customTwo];
  
  
  
  PackagingCustomView *customThree = [[PackagingCustomView alloc] init];
  NSInteger countRowThree = [customThree packagingCustomWithTitle:@"内容物尺寸"
                                                       itemsArray:@[@"小果(果径<75MM)",@"中果(75MM>果径>75MM)",@"大果(果径>85MM)",@"自定义"]
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
  
  [self.scrollView addSubview:self.titleLabel];
  [self.scrollView addSubview:self.longLabel];
  [self.scrollView addSubview:self.widthLabel];
  [self.scrollView addSubview:self.heightLabel];
  
  [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
    make.left.mas_equalTo(SCALE_SIZE*10);
    make.top.equalTo(customThree.mas_bottom).offset(SCALE_SIZE*16);
  }];
  
  [self.longLabel mas_makeConstraints:^(MASConstraintMaker *make) {
    make.left.equalTo(self.titleLabel);
    make.top.equalTo(self.titleLabel.mas_bottom).offset(SCALE_SIZE*10);
    make.width.mas_equalTo(SCALE_SIZE*90);
  }];
  
  [self.widthLabel mas_makeConstraints:^(MASConstraintMaker *make) {
    make.left.equalTo(self.longLabel.mas_right);
    make.top.width.equalTo(self.longLabel);
  }];
  
  [self.heightLabel mas_makeConstraints:^(MASConstraintMaker *make) {
    make.left.equalTo(self.widthLabel.mas_right);
    make.top.width.equalTo(self.longLabel);
  }];
  
  
  [self.view layoutIfNeeded];
  [self.scrollView setContentSize:CGSizeMake(0, self.longLabel.frame.origin.y+self.longLabel.frame.size.height+SCALE_SIZE*75)];
}

-(UILabel *)titleLabel {
  if (!_titleLabel) {
    _titleLabel = [[UILabel alloc] init];
    [_titleLabel setTextColor:BASECOLOR_BLACK_333];
    [_titleLabel setFont:FONTSIZE(14)];
    [_titleLabel setText:@"包装尺寸"];
  }
  return _titleLabel;
}

-(UILabel *)longLabel {
  if (!_longLabel) {
    _longLabel = [[UILabel alloc] init];
    [_longLabel setTextColor:BASECOLOR_BLACK_333];
    [_longLabel setFont:FONTSIZE(12)];
    [_longLabel setText:@"长：200mm"];
  }
  return _longLabel;
}

-(UILabel *)widthLabel {
  if (!_widthLabel) {
    _widthLabel = [[UILabel alloc] init];
    [_widthLabel setTextColor:BASECOLOR_BLACK_333];
    [_widthLabel setFont:FONTSIZE(12)];
    [_widthLabel setText:@"宽：200mm"];
  }
  return _widthLabel;
}

-(UILabel *)heightLabel {
  if (!_heightLabel) {
    _heightLabel = [[UILabel alloc] init];
    [_heightLabel setTextColor:BASECOLOR_BLACK_333];
    [_heightLabel setFont:FONTSIZE(12)];
    [_heightLabel setText:@"高：200mm"];
  }
  return _heightLabel;
}


@end
