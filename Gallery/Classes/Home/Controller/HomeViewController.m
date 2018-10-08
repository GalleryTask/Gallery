//
//  HomeViewController.m
//  Gallery
//
//  Created by 安东 on 2018/9/19.
//  Copyright © 2018年 安东. All rights reserved.
//

#import "HomeViewController.h"
#import "QuoteViewController.h"
#import "SceneView.h"

@interface HomeViewController ()

@property (nonatomic, strong) UIScrollView  *scrollView;
@property (nonatomic, strong) NSArray  *boxList;

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
  self.navigationItem.title = @"报价";
  [self.view addSubview:self.scrollView];
}

- (void)btnClick:(id)sender  {
  
  UITapGestureRecognizer *tap = (UITapGestureRecognizer *)sender;
  QuoteViewController *vc = [[QuoteViewController alloc] init];
  [vc setValue:self.boxList[[tap view].tag-100][@"boxTitle"] forKey:@"titleString"];
  [vc setValue:self.boxList[[tap view].tag-100][@"boxId"] forKey:@"boxId"];
  [self.navigationController pushViewController:vc animated:YES];
}

#pragma marks - getters
-(UIScrollView *)scrollView {
  if (!_scrollView) {
    _scrollView = [[UIScrollView alloc] init];
    [_scrollView setFrame:self.view.frame];
    [_scrollView setContentSize:CGSizeMake((SCREEN_WIDTH-40)*12 + 130, 0)];
    
    for (int i = 0; i < self.boxList.count; i++) {
     
      SceneView *sceneView = [[SceneView alloc] initWithSceneName:@"art.scnassets/nbox3gai" frame:CGRectMake((SCREEN_WIDTH-30)*i+10, SCALE_SIZE*70, SCREEN_WIDTH-40, SCREEN_WIDTH-40)];
      [_scrollView addSubview:sceneView];
      
      UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(btnClick:)];
      [sceneView addGestureRecognizer:tap];
      
      UIView *tapView = [tap view];
      [tapView setTag:(100+i)];
      
      UILabel *titleLabel = [[UILabel alloc] init];
      [titleLabel setText:self.boxList[i][@"boxTitle"]];
      [_scrollView addSubview:titleLabel];
      [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(sceneView);
        make.top.mas_equalTo(sceneView.mas_bottom).offset(SCALE_SIZE*20);
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
