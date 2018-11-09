//
//  XLSlideSegmentItem.m
//  SlideSwitchTest
//
//  Created by MengXianLiang on 2017/4/28.
//  Copyright © 2017年 MengXianLiang. All rights reserved.
//

#import "XLSlideSegmentedItem.h"

@implementation XLSlideSegmentedItem

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self buildUI];
    }
    return self;
}

- (void)buildUI {
    _textLabel = [[UILabel alloc] init];
    _textLabel.textAlignment = NSTextAlignmentCenter;
    [_textLabel setFont:FONTSIZE(14)];
    [self.contentView addSubview:_textLabel];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    _textLabel.frame = self.bounds;
  _textLabel.frame = CGRectMake(self.bounds.origin.x, self.bounds.origin.y, self.bounds.size.width, self.bounds.size.height - 10);
}

@end
