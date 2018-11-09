//
//  SceneViewController.m
//  Gallery
//
//  Created by 安东 on 09/11/2018.
//  Copyright © 2018 安东. All rights reserved.
//

#import "SceneViewController.h"
#import "SceneView.h"

@interface SceneViewController ()

@property (nonatomic, strong) SceneView  *sceneView;
@property (nonatomic, strong) UIButton   *customizedBtn; // 开始定制

@end

@implementation SceneViewController

- (void)viewDidLoad {
    [super viewDidLoad];
  self.navigationItem.title = @"3D苹果包装方案";
  [self.view addSubview:self.sceneView];
  [self.view addSubview:self.customizedBtn];
}

// 开始定制按钮点击事件
- (void)customizedBtnClick:(id)sender {
  
}

#pragma marks - getters
-(UIButton *)customizedBtn {
  if (!_customizedBtn) {
    _customizedBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_customizedBtn setFrame:CGRectMake(0, SCREEN_HEIGHT-SafeAreaBottomHeight-50-NAVIGATIONBAR_HEIGHT, SCREEN_WIDTH, 50)];
    [_customizedBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_customizedBtn setTitle:@"开始定制" forState:UIControlStateNormal];
    [[_customizedBtn titleLabel] setFont:FONTSIZE(16)];
    [_customizedBtn setBackgroundColor:BASECOLOR_BLACK_333];
    [_customizedBtn addTarget:self action:@selector(customizedBtnClick:) forControlEvents:UIControlEventTouchUpInside];
  }
  return _customizedBtn;
}


-(SceneView *)sceneView {
  if (!_sceneView) {
    _sceneView = [[SceneView alloc] initWithSceneName:@"moxing.DAE" frame:CGRectMake(0, SCALE_SIZE*52, SCREEN_WIDTH, SCREEN_WIDTH)];
    [_sceneView sceneViewDiffuseImage:[UIImage imageNamed:@"B.tga"]];
  }
  return _sceneView;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
