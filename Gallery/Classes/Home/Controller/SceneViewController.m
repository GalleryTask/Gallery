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
@end

@implementation SceneViewController

- (void)viewDidLoad {
    [super viewDidLoad];
  self.navigationItem.title = @"3D苹果包装方案";
  [self.view addSubview:self.sceneView];
  
}

-(SceneView *)sceneView {
  if (!_sceneView) {
    _sceneView = [[SceneView alloc] initWithSceneName:@"HeZiZheDie.DAE" frame:CGRectMake(0, SCALE_SIZE*52, SCREEN_WIDTH, SCREEN_WIDTH)];
    [_sceneView sceneViewDiffuseImage:[UIImage imageNamed:@"0_T_hezi_tietu_01_d.tga"]];
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
