//
//  PackagingBaseController.m
//  Gallery
//
//  Created by 安东 on 13/11/2018.
//  Copyright © 2018 安东. All rights reserved.
//

#import "PackagingBaseController.h"
#import "OrderPreviewController.h"

@interface PackagingBaseController () <BottomSelectBarDelegate>



@end

@implementation PackagingBaseController

- (void)viewDidLoad {
  [super viewDidLoad];
}


#pragma marks - BottomSelectBar delegate
-(void)bottomBarWithLeftBtnClick:(id)sender {
  
}

-(void)bottomBarWithRightBtnClick:(id)sender {
  OrderPreviewController *vc = [[OrderPreviewController alloc] init];
  [self.navigationController pushViewController:vc animated:YES];
}

#pragma marks - getters
-(UIScrollView *)scrollView {
  if (!_scrollView) {
    _scrollView = [[UIScrollView alloc] init];
    [_scrollView setFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-NAVIGATIONBAR_HEIGHT)];
    [_scrollView setShowsHorizontalScrollIndicator:NO];
    [self.view addSubview:_scrollView];
  }
  return _scrollView;
}

-(BottomSelectBar *)bottomBar {
  if (!_bottomBar) {
    _bottomBar = [[BottomSelectBar alloc] initWithLeftTitle:@"下生产单" rightTitle:@"提交打样" delegate:self];
    [self.scrollView addSubview:_bottomBar];
  }
  return _bottomBar;
}


-(void)viewDidLayoutSubviews {
  [super viewDidLayoutSubviews];
  
  [self.bottomBar mas_makeConstraints:^(MASConstraintMaker *make) {
    make.left.width.equalTo(self.view);
    make.bottom.equalTo(self.view).offset(-SafeAreaBottomHeight);
    make.height.mas_equalTo(SCALE_SIZE*50);
  }];
}

@end
