//
//  SceneView.m
//  3DModelShow
//
//  Created by 安东 on 2018/7/18.
//  Copyright © 2018年 安东. All rights reserved.
//

#import "SceneView.h"
#import <SceneKit/SceneKit.h>


@implementation SceneView

//-(instancetype)initWithFrame:(CGRect)frame {
//  if (self = [super initWithFrame:frame]) {
//    [self createSceneView];
//  }
//  return self;
//}

- (id)initWithSceneName:(NSString *)sceneName frame:(CGRect)frame {
  if (self = [super init]) {
    [self setFrame:frame];
    [self createSceneViewWithSceneName:sceneName];
  }
  return self;
}

#pragma mark - 创建3D模型场景
- (void)createSceneViewWithSceneName:(NSString *)sceneName {
  
  // 初始化场景
  SCNScene *scene = [SCNScene sceneNamed:sceneName];
  
  SCNNode *cameraNode = [SCNNode node];
  cameraNode.camera = [SCNCamera camera];
  cameraNode.camera.automaticallyAdjustsZRange = true;
//  cameraNode.camera.zFar = 400;//视距
  [scene.rootNode addChildNode:cameraNode];
  cameraNode.position = SCNVector3Make(0, 10, 100);
  // 创建灯光
  SCNNode *node = [SCNNode node];
  node.light = [SCNLight light];
  node.light.type = SCNLightTypeAmbient;
  node.light.color = [UIColor whiteColor];
//  node.camera.zFar = 400;
//  node.position = SCNVector3Make(0, 0, 300);
  [scene.rootNode addChildNode:node];
  
  // 创建展示场景
  SCNView *scnView = [[SCNView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
  [self addSubview:scnView];
  
  // 设置场景
  scnView.scene = scene;
  
  // 设置背景颜色
  scnView.backgroundColor = [UIColor hexStringToColor:@"#F5F5F5"];
  
  // 允许控制摄像机位置
  scnView.allowsCameraControl = YES;
  
  // 不显示数据控制台
  scnView.showsStatistics = NO;
}
@end
