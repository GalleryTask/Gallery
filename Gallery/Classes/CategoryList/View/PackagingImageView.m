//
//  PackagingImageView.m
//  Gallery
//
//  Created by 安东 on 15/11/2018.
//  Copyright © 2018 安东. All rights reserved.
//

#import "PackagingImageView.h"
#import "uploadImageObject.h"

@interface PackagingImageView ()


@end

@implementation PackagingImageView

- (instancetype)initWithFrame:(CGRect)frame
                       images:(NSArray *)images
                       titles:(NSArray *)titles
                isUploadImage:(BOOL)isUpload {
  if (self = [super init]) {
    [self setFrame:frame];
    [self createUploadImageBtnWithImages:images titles:titles isUpload:isUpload];
  }
  return self;
}

- (void)createUploadImageBtnWithImages:(NSArray *)images titles:(NSArray *)titles isUpload:(BOOL)isUpload {
  
  if (isUpload) {
    
    NSInteger margin = (SCREEN_WIDTH-SCALE_SIZE*210)/4;
    for (int i = 0; i < titles.count; i++) {
      UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
      [button setBackgroundColor:BASECOLOR_BACKGROUND_GRAY];
      [button setBackgroundImage:[UIImage imageNamed:@"category_uploadImage"] forState:UIControlStateNormal];
      [button addTarget:self action:@selector(uploadImageBtnClick:) forControlEvents:UIControlEventTouchUpInside];
      [self addSubview:button];
      if (titles.count == 1) {
        margin = SCALE_SIZE*14;
      }
      
      [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(margin+ ((SCREEN_WIDTH-SCALE_SIZE*210)/4 +SCALE_SIZE*70)*i);
        make.top.mas_equalTo(SCALE_SIZE*16);
        make.width.height.mas_equalTo(SCALE_SIZE*70);
      }];
      
      UILabel *label = [[UILabel alloc] init];
      [label setText:titles[i]];
      [label setTextColor:BASECOLOR_BLACK_333];
      [label setFont:FONTSIZE(12)];
      [self addSubview:label];
      
      
      [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(button);
        make.top.equalTo(button.mas_bottom).offset(SCALE_SIZE*10);
      }];
      
    }
    
  } else {
    
    UILabel *label = [[UILabel alloc] init];
    [label setText:@"样例"];
    [label setTextColor:BASECOLOR_BLACK_333];
    [label setFont:FONTSIZE(14)];
    [self addSubview:label];
    
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
      make.left.mas_equalTo(SCALE_SIZE*10);
      make.top.mas_equalTo(SCALE_SIZE*16);
    }];
    
    for (int i = 0; i < 3; i++) {
      UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
      [button setBackgroundColor:BASECOLOR_BACKGROUND_GRAY];
      [self addSubview:button];
      
      [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo((SCREEN_WIDTH-SCALE_SIZE*210)/4 + ((SCREEN_WIDTH-SCALE_SIZE*210)/4 +SCALE_SIZE*70)*i);
        make.top.equalTo(label.mas_bottom).offset(SCALE_SIZE*10);
        make.width.height.mas_equalTo(SCALE_SIZE*70);
      }];
    }
  }
}


- (void)uploadImageBtnClick:(UIButton *)button {
  
  UploadImageObject *upload = [[UploadImageObject alloc] init];
  [upload uploadImageWithController:[CommonUtil getCurrentVC] Block:^(UIImage *image) {
    [button setImage:image forState:UIControlStateNormal];
  }];
}


@end
