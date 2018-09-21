//
//  HomeViewController.m
//  Gallery
//
//  Created by 安东 on 2018/9/19.
//  Copyright © 2018年 安东. All rights reserved.
//

#import "HomeViewController.h"

#import "QuoteViewController.h"

@interface HomeViewController ()

@property (nonatomic, strong) UIScrollView  *scrollView;
@property (nonatomic, strong) NSArray  *boxList;

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
  self.navigationItem.title = @"报价";
  [self.view addSubview:self.scrollView];
//  NSLog(@"%d",IS_IPHONE_XSMAX);
  NSLog(@"%d",IS_IPHONE_6P);
  NSLog(@"%f",SCREEN_HEIGHT);
}

- (void)btnClick:(UIButton *)button {
  QuoteViewController *vc = [[QuoteViewController alloc] init];
  [vc setValue:self.boxList[button.tag-100] forKey:@"titleString"];
  [self.navigationController pushViewController:vc animated:YES];
}

#pragma marks - getters
-(UIScrollView *)scrollView {
  if (!_scrollView) {
    _scrollView = [[UIScrollView alloc] init];
    [_scrollView setFrame:self.view.frame];
    [_scrollView setContentSize:CGSizeMake((SCREEN_WIDTH-40)*12 + 130, 0)];
    
    for (int i = 0; i < self.boxList.count; i++) {
      UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
      [btn setFrame:CGRectMake((SCREEN_WIDTH-30)*i+10, SCALE_SIZE*70, SCREEN_WIDTH-40, SCREEN_WIDTH-40)];
      [btn setBackgroundColor:BASECOLOR_LIGHTGRAY];
      [btn setTag:(100+i)];
      [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
      [_scrollView addSubview:btn];
      
      UILabel *titleLabel = [[UILabel alloc] init];
      [titleLabel setText:self.boxList[i]];
      [_scrollView addSubview:titleLabel];
      [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(btn);
        make.top.mas_equalTo(btn.mas_bottom).offset(SCALE_SIZE*20);
      }];
    }
  }
  return _scrollView;
}

-(NSArray *)boxList {
  if (!_boxList) {
    _boxList = [[[NSDictionary alloc] initWithContentsOfFile:
                 [[NSBundle mainBundle] pathForResource:@"DataList.plist"ofType:nil]]
                objectForKey:@"BoxList"] ;
  }
  return _boxList;
}

@end
