//
//  HomeViewController.m
//  Gallery
//
//  Created by 安东 on 2018/9/19.
//  Copyright © 2018年 安东. All rights reserved.
//

#import "HomeViewController.h"
#import "MateriaIInformationViewController.h"
@interface HomeViewController ()

@property (nonatomic, strong) UIScrollView  *scrollView;
@property (nonatomic, strong) NSArray  *boxList;

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
  self.navigationItem.title = @"报价";
  [self.view addSubview:self.scrollView];
    
    
    MateriaIInformationViewController *materiaVC = [[MateriaIInformationViewController alloc] init];
    [self.navigationController pushViewController:materiaVC animated:YES];
}

-(UIScrollView *)scrollView {
  if (!_scrollView) {
    _scrollView = [[UIScrollView alloc] init];
    [_scrollView setFrame:self.view.frame];
    [_scrollView setContentSize:CGSizeMake((SCREEN_WIDTH-20)*12 + 110, 0)];
    
    for (int i = 0; i < self.boxList.count; i++) {
      UIImageView *imgView = [[UIImageView alloc] init];
      [imgView setFrame:CGRectMake((SCREEN_WIDTH-10)*i, 60, SCREEN_WIDTH-20, SCREEN_WIDTH-20)];
      [imgView setBackgroundColor:BASECOLOR_LIGHTGRAY];
      [imgView setUserInteractionEnabled:NO];
      [_scrollView addSubview:imgView];
      
      UILabel *titleLabel = [[UILabel alloc] init];
      [titleLabel setText:self.boxList[i]];
      [_scrollView addSubview:titleLabel];
      [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(imgView);
        make.top.mas_equalTo(imgView.mas_bottom).offset(SCALE_SIZE*15);
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
