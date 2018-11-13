//
//  NextButton.m
//  NBox
//
//  Created by 安东 on 2018/4/2.
//  Copyright © 2018年 安东. All rights reserved.
//

#import "NextButton.h"

@interface NextButton ()

@property (copy,   nonatomic) ClickBlock clickBlock;

@end

@implementation NextButton

+ (NextButton *)buttonWithTitle:(NSString *)title clickBlock:(ClickBlock)block {
  NextButton *button = [NextButton buttonWithType:UIButtonTypeCustom];
  [[button titleLabel] setFont:FONTSIZE(14)];
  [button addTarget:button action:@selector(unpressedEvent:) forControlEvents:UIControlEventTouchUpInside];
  [button setTitle:title forState:UIControlStateNormal];
  [[button layer] setCornerRadius:4];
  [[button layer] setMasksToBounds:YES];
  [button setBackgroundImage:[CommonUtil imageWithColor:BASECOLOR_BLACK_333] forState:UIControlStateNormal];
  [button setBackgroundImage:[CommonUtil imageWithColor:BASECOLOR_BLACK_333] forState:UIControlStateHighlighted];
  
  button.clickBlock = block;
  
  return button;
}


#pragma mark - 按钮的松开事件 按钮复原 执行响应
- (void)unpressedEvent:(NextButton *)btn {
//  [UIView animateWithDuration:animateDelay animations:^{
//    btn.transform = CGAffineTransformMakeScale(1.0, 1.0);
//  } completion:^(BOOL finished) {
    //执行动作响应
    if (self.clickBlock) {
      self.clickBlock(btn);
    }
//  }];
}
@end
