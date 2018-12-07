//
//  SceneView.m
//  3DModelShow
//
//  Created by 安东 on 2018/7/18.
//  Copyright © 2018年 安东. All rights reserved.
//

#import "SceneView.h"


@interface SceneView()

@property (nonatomic, strong) SCNView     *scnView;
@property (nonatomic, strong) SCNNode     *spotNode;  // 灯光节点
@property (nonatomic, strong) SCNScene    *scene;
@property (nonatomic, strong) SCNMaterial *material;

@property (nonatomic, strong) SCNNode  *topNode;
@property (nonatomic, strong) SCNNode  *liningNode;
@property (nonatomic, strong) SCNNode  *downNode;
@end

@implementation SceneView

- (id)initWithSceneName:(NSString *)sceneName frame:(CGRect)frame {
  if (self = [super init]) {
    [self setFrame:frame];
    [self createSceneViewWithSceneName:sceneName];
//    [self sceneViewDiffuse];
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
- (void)sceneViewDiffuse {

  SCNMaterial *material = [SCNMaterial new];
  material.lightingModelName = SCNLightingModelLambert;
  material.diffuse.contents = [UIImage imageNamed:@"art.scnassets/0_boxtop.png"];
  [self.topNode.geometry setMaterials:@[material]];
  
  SCNMaterial *material1 = [SCNMaterial new];
  material1.lightingModelName = SCNLightingModelLambert;
  material1.diffuse.contents = [UIImage imageNamed:@"art.scnassets/1_boxdown.png"];
  [self.downNode.geometry setMaterials:@[material1]];
  
  SCNMaterial *material2 = [SCNMaterial new];
  material2.lightingModelName = SCNLightingModelLambert;
  material2.diffuse.contents = [UIImage imageNamed:@"art.scnassets/2_lining.png"];
  [self.liningNode.geometry setMaterials:@[material2]];

  //  self.material.diffuse.contents = image;
  //  self.material.diffuse.contents = [UIImage imageNamed:@"1_boxdown.png"];
//  for (SCNNode *aNode in self.scene.rootNode.childNodes) {
//    [aNode.geometry setMaterials:@[self.material]];
//  }
}

// 删除节点
- (void)removeNode {

  if ([self.scnView.scene.rootNode.childNodes containsObject:self.topNode]) {
    
    SCNAnimationEvent *event = [SCNAnimationEvent animationEventWithKeyTime:0.5 block:^(id<SCNAnimation>  _Nonnull animation, id  _Nonnull animatedObject, BOOL playingBackward) {
      
      [self.topNode removeAllAnimations];
      [self.topNode removeFromParentNode];
      
    }];
    
 
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"position.y"];
    animation.duration = 1;
//    animation.fromValue = @"0";
    animation.toValue = @"100";
    animation.animationEvents = @[event];
    animation.repeatCount = 0;
    animation.fillMode=kCAFillModeForwards;
    animation.removedOnCompletion = NO;

  
    [self.topNode addAnimation:animation forKey:nil];
  }
}

// 添加节点
- (void)addNode {

  if (![self.scene.rootNode.childNodes containsObject:self.topNode]) {
  SCNAnimationEvent *event = [SCNAnimationEvent animationEventWithKeyTime:0.5
                                                                    block:^(id<SCNAnimation>  _Nonnull animation, id  _Nonnull animatedObject, BOOL playingBackward) {
  }];
  

  CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"position.y"];
  animation.duration = 0.5;
  animation.fromValue = @"100";
//  animation.toValue = @"0";
  animation.animationEvents = @[event];
  animation.repeatCount = 0;
  

  [self.scnView.scene.rootNode addChildNode:self.topNode];
  [self.topNode addAnimation:animation forKey:nil];
  }
}

-(void)changeCameraNodePosition {

  SCNAction *repeatAction = [SCNAction repeatAction:[SCNAction rotateByX:0 y:1 z:0 duration:0.3] count:4];
  [self.topNode runAction:repeatAction];
  [self.downNode runAction:repeatAction];
  [self.liningNode runAction:repeatAction];
}


#pragma mark - 创建3D模型场景
- (void)createSceneViewWithSceneName:(NSString *)sceneName {
  
  // 初始化场景
  self.scene = [SCNScene sceneNamed:sceneName];
//   self.scene = [SCNScene sceneWithURL:sceneName options:nil error:nil];
  
  [self.scene.rootNode addChildNode:self.cameraNode];
  // 创建灯光
//  [self.scene.rootNode addChildNode:self.spotNode];
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
    _scnView.backgroundColor = [UIColor hexStringToColor:@"#F5F5F5"];
    // 允许控制摄像机位置
    _scnView.allowsCameraControl = YES;
    // 不显示数据控制台
//    _scnView.showsStatistics = YES;
    
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
    _spotNode = [self.scene.rootNode childNodeWithName:@"EnvironmentAmbientLight" recursively:YES];
  }
  return _spotNode;
}

-(SCNNode *)cameraNode {
  if (!_cameraNode) {
    _cameraNode = [SCNNode node];
    _cameraNode.camera = [SCNCamera camera];
    _cameraNode.camera.automaticallyAdjustsZRange = true;
    _cameraNode.position = SCNVector3Make(0, 10, 70);
  }
  return _cameraNode;
}


-(SCNNode *)topNode {
  if (!_topNode) {
    _topNode = [self.scene.rootNode childNodeWithName:@"boxtop" recursively:YES];
  }
  return _topNode;
}

-(SCNNode *)liningNode {
  if (!_liningNode) {
    _liningNode = [self.scene.rootNode childNodeWithName:@"lining" recursively:YES];
  }
  return _liningNode;
}

-(SCNNode *)downNode {
  if (!_downNode) {
    _downNode =  [self.scene.rootNode childNodeWithName:@"boxdown" recursively:YES];
  }
  return _downNode;
}

@end
