//
//  ImageTitleButton.m
//  Gallery
//
//  Created by 安东 on 23/11/2018.
//  Copyright © 2018 安东. All rights reserved.
//

#import "ImageTitleButton.h"

@implementation ImageTitleButton


-(void)layoutSubviews {
  [super layoutSubviews];
  
  // image center
  CGPoint center;
  float itemMargin = 3.f;
  float topSpace = (self.frame.size.height-self.imageView.frame.size.height-self.titleLabel.frame.size.height-itemMargin)/2;
  center.x = self.frame.size.width/2;
  center.y = self.imageView.frame.size.height/2 + topSpace;
  self.imageView.center = center;
  
  // text
  CGRect newFrame = [self titleLabel].frame;
  newFrame.origin.x = 0;
  newFrame.origin.y = self.imageView.frame.size.height + topSpace + itemMargin;
  newFrame.size.width = self.frame.size.width;
  
  self.titleLabel.frame = newFrame;
  self.titleLabel.textAlignment = NSTextAlignmentCenter;
}

@end
