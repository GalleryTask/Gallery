//
//  PackagingBaseController.m
//  Gallery
//
//  Created by 安东 on 13/11/2018.
//  Copyright © 2018 安东. All rights reserved.
//

#import "PackagingBaseController.h"

@interface PackagingBaseController ()

@property (nonatomic, strong) UIButton  *createBtn; // 制作

@end

@implementation PackagingBaseController

- (void)viewDidLoad {
  [super viewDidLoad];
  
}

-(UIScrollView *)scrollView {
  if (!_scrollView) {
    _scrollView = [[UIScrollView alloc] init];
    [_scrollView setFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-NAVIGATIONBAR_HEIGHT)];
    [_scrollView setShowsHorizontalScrollIndicator:NO];
    [self.view addSubview:_scrollView];
  }
  return _scrollView;
}


-(UIButton *)createBtn {
  if (!_createBtn) {
    _createBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_createBtn setTitle:@"样品制作" forState:UIControlStateNormal];
    [_createBtn setBackgroundColor:BASECOLOR_BLACK_333];
    [self.scrollView addSubview:_createBtn];
  }
  return _createBtn;
}

-(void)viewDidLayoutSubviews {
  [super viewDidLayoutSubviews];
  
  [self.createBtn mas_makeConstraints:^(MASConstraintMaker *make) {
    make.left.width.equalTo(self.view);
    make.bottom.equalTo(self.view).offset(-SafeAreaBottomHeight);
    make.height.mas_equalTo(SCALE_SIZE*50);
  }];
}

@end
