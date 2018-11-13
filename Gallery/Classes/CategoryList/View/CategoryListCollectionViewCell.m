//
//  CategoryListCollectionViewCell.m
//  Gallery
//
//  Created by admin on 2018/11/8.
//  Copyright © 2018 安东. All rights reserved.
//

#import "CategoryListCollectionViewCell.h"

@interface CategoryListCollectionViewCell ()


@property(nonatomic, strong) UIImageView *pictureImageView;
@property(nonatomic, strong) UILabel     *titleLabel;

@end

@implementation CategoryListCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(void)setDataDic:(NSDictionary *)dataDic {
  if (dataDic) {
    [self.pictureImageView setImage:[UIImage imageNamed:[dataDic valueForKey:@"imageName"]]];
    [self.titleLabel setText:[dataDic valueForKey:@"title"]];
    
  }
}

-(void)layoutSubviews{
    [super layoutSubviews];

    [self.pictureImageView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(SCALE_SIZE*5);
        make.width.mas_equalTo((SCREEN_WIDTH*0.76-(SCALE_SIZE*10))/2-SCALE_SIZE*10);
        make.top.mas_equalTo(SCALE_SIZE *15);
        make.height.mas_equalTo(((SCREEN_WIDTH*0.76-(SCALE_SIZE*10))/2-SCALE_SIZE*10) /124 *100);
    }];
    
    [self.titleLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
       
        make.left.right.equalTo(self.pictureImageView);
        make.top.mas_equalTo(self.pictureImageView.mas_bottom).offset(SCALE_SIZE*10);
     
    }];
  [super layoutSubviews];
  
  [self.pictureImageView mas_remakeConstraints:^(MASConstraintMaker *make) {
    make.left.mas_equalTo(SCALE_SIZE*5);
    make.width.mas_equalTo((SCREEN_WIDTH*0.76-(SCALE_SIZE*10))/2-SCALE_SIZE*10);
    make.top.mas_equalTo(SCALE_SIZE *15);
    make.height.mas_equalTo(((SCREEN_WIDTH*0.76-(SCALE_SIZE*10))/2-SCALE_SIZE*10) /124 *100);
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
//    _pictureImageView.backgroundColor = BASECOLOR_BACKGROUND_GRAY;
    [self.contentView addSubview:_pictureImageView];
  }
  return _pictureImageView;
}
-(UILabel *)titleLabel {
  if (!_titleLabel) {
    _titleLabel = [[UILabel alloc] init];
    [_titleLabel setTextColor:BASECOLOR_BLACK_030];
    [_titleLabel setFont:FONTSIZE(13)];
    [_titleLabel setText:@"精品彩盒方案一"];
    [_titleLabel setTextAlignment:NSTextAlignmentCenter];
    [self.contentView addSubview:_titleLabel];
  }
  return _titleLabel;
}


@end
