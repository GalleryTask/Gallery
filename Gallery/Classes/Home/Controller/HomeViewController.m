//
//  HomeViewController.m
//  Gallery
//
//  Created by 安东 on 2018/9/19.
//  Copyright © 2018年 安东. All rights reserved.
//

#import "HomeViewController.h"

@interface HomeViewController ()

@property (nonatomic, strong) UIScrollView  *scrollView;

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
  self.navigationItem.title = @"报价";
  [self.view addSubview:self.scrollView];
}

-(UIScrollView *)scrollView {
  if (!_scrollView) {
    _scrollView = [[UIScrollView alloc] init];
    [_scrollView setFrame:self.view.frame];
    [_scrollView setBackgroundColor:BASECOLOR_BLUE];
  }
  return _scrollView;
}

@end
