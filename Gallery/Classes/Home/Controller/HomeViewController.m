//
//  HomeViewController.m
//  Gallery
//
//  Created by 安东 on 2018/9/19.
//  Copyright © 2018年 安东. All rights reserved.
//

#import "HomeViewController.h"
#import "SceneView.h"
#import "UploadImageObject.h"

@interface HomeViewController ()

@property (nonatomic, strong) UIScrollView  *scrollView;
@property (nonatomic, strong) NSArray  *boxList;

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
  self.navigationItem.title = @"报价";
  BaseNavigationController *nav = (BaseNavigationController *)self.navigationController;
  [nav setNavigationBarRightItemWithButtonTitle:@"上传图片"];
  [nav showRightNavBtnWithClick:^(id sender) {
    [self uploadImage];
  }];
  
  [self createSceneView];
  
}

- (void)createSceneView {
  for (int i = 0; i < self.boxList.count; i++) {
    
    // 创建3D展示view
    SceneView *sceneView = [[SceneView alloc] initWithSceneName:@"art.scnassets/nbox3gai"
                                                          frame:CGRectMake((SCREEN_WIDTH-30)*i+10, SCALE_SIZE*70, SCREEN_WIDTH-40, SCREEN_WIDTH-40)];
    [self.scrollView addSubview:sceneView];
    
    if (i == 1) {
      [sceneView sceneViewDiffuseImage:[UIImage imageNamed:@"180X180"]];
      [sceneView sceneViewReflectiveImage:[UIImage imageNamed:@"180X180"]];
    } else {
      if (i == 0) {
        
      } else {
        [sceneView sceneViewDiffuseImage:[UIImage imageNamed:@"180X180"]];
      }
    }
    
    // 添加点击手势
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(btnClick:)];
    [sceneView addGestureRecognizer:tap];
    
    UIView *tapView = [tap view];
    [tapView setTag:(100 + i)];
    
    UILabel *titleLabel = [[UILabel alloc] init];
    [titleLabel setText:self.boxList[i][@"boxTitle"]];
    [_scrollView addSubview:titleLabel];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
      make.centerX.equalTo(sceneView);
      make.top.mas_equalTo(sceneView.mas_bottom).offset(SCALE_SIZE*20);
    }];
  }
}

- (void)uploadImage {
  UploadImageObject *upload = [[UploadImageObject alloc] init];
  [upload uploadImageWithController:self Block:^(UIImage *image) {
    SceneView *sceneView = [self.scrollView viewWithTag:100];
    [sceneView sceneViewDiffuseImage:image];
    [sceneView sceneViewReflectiveImage:image];
  }];
}

- (void)btnClick:(id)sender {
  
//  UITapGestureRecognizer *tap = (UITapGestureRecognizer *)sender;
//  QuoteViewController *vc = [[QuoteViewController alloc] init];
//  [vc setValue:self.boxList[[tap view].tag-100][@"boxTitle"] forKey:@"titleString"];
//  [vc setValue:self.boxList[[tap view].tag-100][@"boxId"] forKey:@"boxId"];
//  [self.navigationController pushViewController:vc animated:YES];
}

#pragma marks - getters
-(UIScrollView *)scrollView {
  if (!_scrollView) {
    _scrollView = [[UIScrollView alloc] init];
    [_scrollView setFrame:self.view.frame];
    [_scrollView setContentSize:CGSizeMake((SCREEN_WIDTH-40)*12 + 130, 0)];
    [self.view addSubview:_scrollView];
    
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
