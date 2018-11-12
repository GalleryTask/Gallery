//
//  PageRoundScrollview.m
//  Gallery
//
//  Created by 安东 on 12/11/2018.
//  Copyright © 2018 安东. All rights reserved.
//

#import "PageRoundScrollView.h"

@interface PageRoundScrollView () <UIScrollViewDelegate>

@property (nonatomic, strong) UIScrollView  *scrollView;

@end

@implementation PageRoundScrollView


-(instancetype)initWithFrame:(CGRect)frame
{
  self=[super initWithFrame:frame];
  if (self) {
    [self addSubview:self.scrollView];
  }
  return self;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
  if (_delegate && [_delegate respondsToSelector:@selector(pageRoundScrollWithPage:)]) {
     int page = floor(scrollView.contentOffset.x / (SCALE_SIZE*327)) + 1;
    [_delegate pageRoundScrollWithPage:page];
  }
}

-(UIScrollView *)scrollView {
  if (!_scrollView) {
    _scrollView = [[UIScrollView alloc] init];
    [_scrollView setFrame:CGRectMake(SCALE_SIZE*24, 0, SCALE_SIZE*337, self.frame.size.height)];
    [_scrollView setShowsHorizontalScrollIndicator:NO];
    [_scrollView setDelegate:self];
    [_scrollView setPagingEnabled:YES];
    [_scrollView setClipsToBounds:NO];
    [_scrollView setContentSize:CGSizeMake(SCALE_SIZE*327*8+SCALE_SIZE*70+SCALE_SIZE*58, 0)];
    
    
    for (int i = 0; i < 8; i++) {
      UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
      [button setFrame:CGRectMake(SCALE_SIZE*337*i, 0, SCALE_SIZE*327, SCALE_SIZE*186)];
      [button setBackgroundColor:BASECOLOR_BACKGROUND_GRAY];
      [[button layer] setCornerRadius:5];
      [button setBackgroundImage:[UIImage imageNamed:@"home_2"] forState:UIControlStateNormal];
      [_scrollView addSubview:button];
      
      UILabel *titleLabel = [[UILabel alloc] init];
      [titleLabel setFont:[UIFont systemFontOfSize:SCALE_SIZE*16 weight:UIFontWeightBold]];
      [titleLabel setTextColor:BASECOLOR_BLACK_333];
      [titleLabel setText:@"苹果包装"];
      [_scrollView addSubview:titleLabel];
      
      [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(button);
        make.top.equalTo(button.mas_bottom).offset(SCALE_SIZE*10);
      }];
      
      UILabel *detailLabel = [[UILabel alloc] init];
      [detailLabel setFont:FONTSIZE(14)];
      [detailLabel setTextColor:BASECOLOR_BLACK_999];
      [detailLabel setText:@"与生俱来的艺术品，包装本该不同"];
      [_scrollView addSubview:detailLabel];
      
      [detailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(button);
        make.top.equalTo(titleLabel.mas_bottom).offset(SCALE_SIZE*5);
      }];
    }
  }
  return _scrollView;
}

#pragma mark---修改hitTest方法
- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event
{
  UIView *view = [super hitTest:point withEvent:event];
  if ([view isEqual:self]){
    for (UIView *subview in _scrollView.subviews){
      CGPoint offset = CGPointMake(point.x - _scrollView.frame.origin.x + _scrollView.contentOffset.x - subview.frame.origin.x, point.y - _scrollView.frame.origin.y + _scrollView.contentOffset.y - subview.frame.origin.y);
      
      if ((view = [subview hitTest:offset withEvent:event])){
        return view;
      }
    }
    return _scrollView;
  }
  return view;
}

@end
