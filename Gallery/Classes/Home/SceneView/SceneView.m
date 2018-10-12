//
//  SceneView.m
//  3DModelShow
//
//  Created by 安东 on 2018/7/18.
//  Copyright © 2018年 安东. All rights reserved.
//

#import "SceneView.h"
#import <SceneKit/SceneKit.h>

@interface SceneView()

@property (nonatomic, strong) SCNNode  *spotNode;  // 灯光节点

@end

@implementation SceneView

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
  cameraNode.position = SCNVector3Make(0, 10, 50);
  
  // 创建灯光
  [scene.rootNode addChildNode:self.spotNode];
  
  // 材质
  SCNMaterial *material = [SCNMaterial new];
  material.diffuse.contents = [UIImage imageNamed:@"180X180"];
  material.lightingModelName = SCNLightingModelLambert;
  
  for (SCNNode *aNode in scene.rootNode.childNodes) {
    [aNode.geometry setMaterials:@[material]];
  }

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


- (SCNNode *)spotNode{
  if (!_spotNode) {
    SCNLight *spotLight = [SCNLight light];// 创建光对象
    spotLight.type = SCNLightTypeAmbient;// 设置类型
    spotLight.color = [UIColor whiteColor]; // 设置光的颜色
    spotLight.castsShadow = TRUE;// 捕捉阴影
    spotLight.attenuationStartDistance = 0;
    spotLight.attenuationEndDistance = 100;
    spotLight.attenuationFalloffExponent = 2;
    spotLight.spotInnerAngle = 0;
    spotLight.spotOuterAngle = 30;
    _spotNode = [SCNNode node];
    _spotNode.position = SCNVector3Make(0, 2, 10); //设置光源节点的位置
    _spotNode.light  = spotLight;
  }
  
  return _spotNode;
}

@end
