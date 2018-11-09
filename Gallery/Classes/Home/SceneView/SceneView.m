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

@property (nonatomic, strong) SCNView     *scnView;
@property (nonatomic, strong) SCNNode     *spotNode;  // 灯光节点
@property (nonatomic, strong) SCNNode     *cameraNode; // 角度
@property (nonatomic, strong) SCNScene    *scene;
@property (nonatomic, strong) SCNMaterial *material;

@property (nonatomic, strong) SCNNode   *ggNode;  // 

@end

@implementation SceneView

- (id)initWithSceneName:(NSString *)sceneName frame:(CGRect)frame {
  if (self = [super init]) {
    [self setFrame:frame];
    [self createSceneViewWithSceneName:sceneName];
  }
  return self;
}

// 设置反光效果
-(void)sceneViewReflectiveImage:(UIImage *)image {
  self.material.fresnelExponent = 1.7;
  self.material.reflective.contents = image;

  for (SCNNode *aNode in self.scene.rootNode.childNodes) {
    [aNode.geometry setMaterials:@[self.material]];
  }
  
}

// 设置贴图图片
- (void)sceneViewDiffuseImage:(UIImage *)image {
  self.material.diffuse.contents = image;
  
  for (SCNNode *aNode in self.scene.rootNode.childNodes) {
    [aNode.geometry setMaterials:@[self.material]];
  }
}

- (void)removeNode {

  if ([self.scene.rootNode.childNodes containsObject:self.ggNode]) {
    
    SCNAnimationEvent *event = [SCNAnimationEvent animationEventWithKeyTime:0.5 block:^(id<SCNAnimation>  _Nonnull animation, id  _Nonnull animatedObject, BOOL playingBackward) {
      
      [self.ggNode removeAllAnimations];
      [self.ggNode removeFromParentNode];
    }];
    
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"position.y"];
    animation.duration = 1;
    animation.fromValue = @"0";
    animation.toValue = @"100";
    animation.animationEvents = @[event];
    animation.repeatCount = 0;
    animation.fillMode=kCAFillModeForwards;
    animation.removedOnCompletion = NO;
    
    [self.ggNode addAnimation:animation forKey:nil];
  }
}

- (void)addNode {

  if (![self.scene.rootNode.childNodes containsObject:self.ggNode]) {
  SCNAnimationEvent *event = [SCNAnimationEvent animationEventWithKeyTime:0.5 block:^(id<SCNAnimation>  _Nonnull animation, id  _Nonnull animatedObject, BOOL playingBackward) {
  }];
  
  CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"position.y"];
  animation.duration = 0.5;
  animation.fromValue = @"100";
  animation.toValue = @"0";
  animation.animationEvents = @[event];
  animation.repeatCount = 0;
  
  [self.scene.rootNode addChildNode:self.ggNode];
  [self.ggNode addAnimation:animation forKey:nil];
  }
}

-(SCNNode *)ggNode {
  if (!_ggNode) {
    self.ggNode = [self.scene.rootNode childNodeWithName:@"_" recursively:YES];
    
  }
  return _ggNode;
}

-(void)changeCameraNodePosition {
//  self.cameraNode.position = SCNVector3Make(0, 10, 30);
//  [self.cameraNode runAction:[SCNAction repeatAction:[SCNAction scaleTo:1 duration:1] count:1]];


}

#pragma mark - 创建3D模型场景
- (void)createSceneViewWithSceneName:(NSString *)sceneName {
  
  // 初始化场景
  self.scene = [SCNScene sceneNamed:sceneName];
//   self.scene = [SCNScene sceneWithURL:sceneName options:nil error:nil];
  
  [self.scene.rootNode addChildNode:self.cameraNode];
  // 创建灯光
  [self.scene.rootNode addChildNode:self.spotNode];
  // 创建展示场景
  [self addSubview:self.scnView];
}

// 创建展示场景
-(SCNView *)scnView {
  if (!_scnView) {
    // 创建展示场景
    _scnView = [[SCNView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    // 设置场景
    _scnView.scene = self.scene;
    // 设置背景颜色
//    _scnView.backgroundColor = [UIColor hexStringToColor:@"#F5F5F5"];
    // 允许控制摄像机位置
    _scnView.allowsCameraControl = YES;
    // 不显示数据控制台
    _scnView.showsStatistics = NO;
  }
  return _scnView;
}

// 设置材质
-(SCNMaterial *)material {
  if (!_material) {
    _material = [SCNMaterial new];
    _material.lightingModelName = SCNLightingModelLambert;
  }
  return _material;
}

// 创建灯光
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

-(SCNNode *)cameraNode {
  if (!_cameraNode) {
    _cameraNode = [SCNNode node];
    _cameraNode.camera = [SCNCamera camera];
    _cameraNode.camera.automaticallyAdjustsZRange = true;
    _cameraNode.position = SCNVector3Make(0, 10, 50);
  }
  return _cameraNode;
}
@end
