//
//  CategoryDetallCell.m
//  Gallery
//
//  Created by admin on 2018/11/8.
//  Copyright © 2018 安东. All rights reserved.
//

#import "CategoryDetallCell.h"
@interface CategoryDetallCell ()


@property(nonatomic, strong) UIImageView *pictureImageView;
@property(nonatomic, strong) UILabel     *titleLabel;

@end
@implementation CategoryDetallCell

-(void)setDataDic:(NSDictionary *)dataDic {
  [self.pictureImageView setImage:[UIImage imageNamed:dataDic[@"imageName"]]];
  [self.titleLabel setText:dataDic[@"title"]];
}

-(void)layoutSubviews{
    [super layoutSubviews];
  
  [self.pictureImageView mas_remakeConstraints:^(MASConstraintMaker *make) {
    
    if (_type == ProductsType) {
      make.left.mas_equalTo(SCALE_SIZE*5);
      make.width.mas_equalTo((SCREEN_WIDTH*0.76-(SCALE_SIZE*10))/2-SCALE_SIZE*10);
      make.top.mas_equalTo(SCALE_SIZE *15);
      make.height.mas_equalTo(((SCREEN_WIDTH*0.76-(SCALE_SIZE*10))/2-SCALE_SIZE*10) /124 *100);
    }else{
      make.left.mas_equalTo(SCALE_SIZE*10);
      make.width.height.mas_equalTo((SCREEN_WIDTH - SCALE_SIZE*20)/2- SCALE_SIZE*20);
      make.top.mas_equalTo(SCALE_SIZE *20);
    }
  }];
  
  [self.titleLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
    make.left.right.equalTo(self.pictureImageView);
    make.top.mas_equalTo(self.pictureImageView.mas_bottom).offset(SCALE_SIZE*10);
  }];
}

-(UIImageView *)pictureImageView {
    if (!_pictureImageView) {
        _pictureImageView = [[UIImageView alloc] init];
        [_pictureImageView setContentMode:UIViewContentModeScaleAspectFit];
        [self.contentView addSubview:_pictureImageView];
    }
    return _pictureImageView;
}

-(UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        [_titleLabel setTextColor:BASECOLOR_BLACK_030];
        [_titleLabel setFont:FONTSIZE(14)];
        [_titleLabel setTextAlignment:(NSTextAlignmentCenter)];
        [_titleLabel setText:@"精品彩盒方案一"];
        [self.contentView addSubview:_titleLabel];
    }
    return _titleLabel;
}


@end
