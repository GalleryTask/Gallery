//
//  PackagingCustomView.m
//  Gallery
//
//  Created by 安东 on 13/11/2018.
//  Copyright © 2018 安东. All rights reserved.
//

#import "PackagingCustomView.h"

static const CGFloat itemHorizontalSpace = 12.0f;  // items左右间距
static const CGFloat itemVerticalSpace = 12.f; // items上下间距

@interface PackagingCustomView ()

@property (nonatomic, copy)   PackagingSelectedItemBlock  selectedItemBlock;
@property (nonatomic, strong) UILabel  *titleLabel;
@property (nonatomic, strong) UIView   *lineView;
@property (nonatomic, copy)   NSArray  *items;
@property (nonatomic, assign) NSInteger  selectedTag;

@end

@implementation PackagingCustomView

-(NSInteger)packagingCustomWithTitle:(NSString *)title
                          itemsArray:(NSArray *)items
                        selectedItem:(int)index
                   selectedItemBlock:(nonnull PackagingSelectedItemBlock)block {
  self.selectedItemBlock = block;
  self.items = items;
  [self.titleLabel setText:title];
  NSInteger countRow =  [self createBtnWithItems:items selectedItem:index];
  return countRow;
}


- (NSInteger)createBtnWithItems:(NSArray *)items selectedItem:(int)index {
  CGFloat margin = SCALE_SIZE*10.0f;  // 两边的间距
  CGFloat itemHeight = SCALE_SIZE*32.f;
  CGFloat currentX = margin; // X
  CGFloat currentY = 0; // Y
  NSInteger countRow = 0; // 第几行数
  CGFloat lastLabelWidth = 0; // 记录上一个宽度
  
  @autoreleasepool {
    
    for (int i = 0; i < items.count; i++) {
      // 最多显示十项
      if (i > 9) {
        break;
      }
      
      // 当前button的宽度
      float width = [CommonUtil adaptionWidthWithString:items[i] fontSize:SCALE_SIZE*12 andHeight:itemHeight] + SCALE_SIZE*20;
      
      if (i == 0) {
        currentX = currentX + lastLabelWidth;
      } else {
        currentX = currentX + itemHorizontalSpace + lastLabelWidth;
      }
      
      currentY = countRow * itemHeight + (countRow + 1) * itemVerticalSpace;
      
      // 换行
      if (currentX + itemHorizontalSpace + margin + width >= SCREEN_WIDTH) {
        countRow++;
        currentY = currentY + itemHeight + itemVerticalSpace;
        currentX = margin;
      }
      
      lastLabelWidth = width;
      
      UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
      [button setTitleColor:BASECOLOR_BLACK_333 forState:UIControlStateSelected];
      [button setTitleColor:BASECOLOR_GRAY_CC  forState:UIControlStateNormal];
      [button setBackgroundImage:[CommonUtil imageWithColor:BASECOLOR_BACKGROUND_GRAY] forState:UIControlStateNormal];
      [button setBackgroundImage:[CommonUtil imageWithColor:[UIColor whiteColor]] forState:UIControlStateSelected];
      [[button layer] setCornerRadius:5];
      [[button layer] setMasksToBounds:YES];
      [[button titleLabel] setFont:FONTSIZE(12)];
      [button setTitle:items[i] forState:UIControlStateNormal];
      [button setTag:(100+i)];
      [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
      [self addSubview:button];
      
      [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(currentX);
        make.top.equalTo(self.titleLabel.mas_bottom).offset(currentY);
        make.width.mas_equalTo(width);
        make.height.mas_equalTo(itemHeight);
      }];
      
      if (i == index) {
        _selectedTag = 100 + i;
        [button setSelected:YES];
        [[button layer] setBorderColor:BASECOLOR_BLACK_000.CGColor];
        [[button layer] setBorderWidth:0.5];
      }
    }
  }
  return countRow;
}

- (void)buttonClick:(UIButton *)button {
  // 判断点击的是否是选中转态 如果是则不变
  if (_selectedTag != button.tag) {
    
    for (int i = 0; i < self.items.count; i++) {
      UIButton *btn = [self viewWithTag:100+i];
      [btn setSelected:NO];
      [[btn layer] setBorderWidth:0];
    }
    if (!button.selected) {
      [button setSelected:YES];
      [[button layer] setBorderColor:BASECOLOR_BLACK_000.CGColor];
      [[button layer] setBorderWidth:0.5];
    }
    self.selectedItemBlock(button.currentTitle);
  }
  _selectedTag = button.tag;
}

#pragma marks - getters
-(UILabel *)titleLabel {
  if (!_titleLabel) {
    _titleLabel = [[UILabel alloc] init];
    [_titleLabel setTextColor:BASECOLOR_BLACK_333];
    [_titleLabel setFont:FONTSIZE(14)];
    [self addSubview:_titleLabel];
  }
  return _titleLabel;
}

-(UIView *)lineView {
  if (!_lineView) {
    _lineView = [[UIView alloc] init];
    [_lineView setBackgroundColor:BASECOLOR_LINE];
    [self addSubview:_lineView];
  }
  return _lineView;
}

-(void)layoutSubviews {
  [super layoutSubviews];
  
  [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
    make.left.mas_equalTo(SCALE_SIZE*10);
    make.top.mas_equalTo(SCALE_SIZE*16);
  }];
  
  [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
    make.left.mas_equalTo(SCALE_SIZE*10);
    make.right.mas_equalTo(-SCALE_SIZE*10);
    make.bottom.equalTo(self);
    make.height.mas_equalTo(0.5);
  }];
}

@end
