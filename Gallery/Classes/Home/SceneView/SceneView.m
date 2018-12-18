//
//  SceneView.m
//  3DModelShow
//
//  Created by 安东 on 2018/7/18.
//  Copyright © 2018年 安东. All rights reserved.
//

#import "SceneView.h"

#define MaxSCale 10.0  //最大缩放比例
#define MinScale 0.5  //最小缩放比例

@interface SceneView()

@property (nonatomic, strong) SCNView     *scnView;
@property (nonatomic, strong) SCNNode     *spotNode;  // 灯光节点
@property (nonatomic, strong) SCNScene    *scene;
@property (nonatomic, strong) SCNMaterial *material;

@property (nonatomic, strong) SCNNode  *topNode;
@property (nonatomic, strong) SCNNode  *liningNode;
@property (nonatomic, strong) SCNNode  *downNode;
@property (nonatomic,assign) CGFloat totalScale;
@property (nonatomic, strong) NSArray  *nodeArray;

@end

@implementation SceneView

- (id)initWithSceneName:(NSString *)sceneName frame:(CGRect)frame {
  if (self = [super init]) {
    [self setFrame:frame];
    self.totalScale = 1.0;
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


// 更换node的贴图图片
- (void)changeNodeDiffuseWithImageNameArray:(NSArray *)array {
  for (int i = 0; i < array.count; i++) {
    SCNMaterial *material = [SCNMaterial new];
    material.lightingModelName = SCNLightingModelLambert;
    material.diffuse.contents = [UIImage imageNamed:array[i]];
    SCNNode *node = self.nodeArray[i];
    [node.childNodes[0].geometry setMaterials:@[material]];
  }
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
    animation.toValue = @"100";
    animation.animationEvents = @[event];
    animation.repeatCount = 0;
    animation.fillMode=kCAFillModeForwards;
    animation.removedOnCompletion = NO;

    [self.topNode addAnimation:animation forKey:nil];
    
    
    
    SCNAnimationEvent *event1 = [SCNAnimationEvent animationEventWithKeyTime:0.5 block:^(id<SCNAnimation>  _Nonnull animation, id  _Nonnull animatedObject, BOOL playingBackward) {
      
      [self.downNode removeAllAnimations];
      [self.downNode removeFromParentNode];
    }];
    
    CABasicAnimation *animation1 = [CABasicAnimation animationWithKeyPath:@"position.y"];
    animation1.duration = 1;
    animation1.toValue = @"-5";
    animation1.animationEvents = @[event1];
    animation1.repeatCount = 0;
    animation1.fillMode=kCAFillModeForwards;
    animation1.removedOnCompletion = NO;
    
    [self.downNode addAnimation:animation1 forKey:nil];
    
//    // 开盖后偏移
//    SCNAction *action = [SCNAction rotateToX:0.8 y:0 z:0 duration:0.5];
//    SCNAction *sequence =[SCNAction sequence:@[action]];
//    [self.downNode runAction:sequence];
//    [self.liningNode runAction:sequence];
    
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
    animation.animationEvents = @[event];
    animation.repeatCount = 0;
    
    [self.scnView.scene.rootNode addChildNode:self.topNode];
    [self.topNode addAnimation:animation forKey:nil];
    
    // 恢复之前的偏移
    SCNAction *action = [SCNAction rotateToX:0 y:0 z:0 duration:0.5];
    SCNAction *sequence =[SCNAction sequence:@[action]];
    [self.downNode runAction:sequence];
    [self.liningNode runAction:sequence];
  }
  self.cameraNode.position = SCNVector3Make(0, 10, 50);
}

// 模型旋转
-(void)nodeTurnAround {

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
  
  self.nodeArray = @[self.topNode,self.liningNode,self.downNode];
}

#pragma marks - getters
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
  }
  return _scnView;
}
- (void)pinch:(UIPinchGestureRecognizer *)recognizer{
  
  CGFloat scale = recognizer.scale;
  
  //放大情况
  if(scale > 1.0){
    if(self.totalScale > MaxSCale) return;
  }
  
  //缩小情况
  if (scale < 1.0) {
    if (self.totalScale < MinScale) return;
  }
  self.scene.rootNode.scale =  SCNVector3Make(scale, scale, scale);
  self.totalScale *=scale;
  //recognizer.scale = 1.0;
  
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

// 视角
-(SCNNode *)cameraNode {
  if (!_cameraNode) {
    _cameraNode = [SCNNode node];
    _cameraNode.camera = [SCNCamera camera];
    _cameraNode.camera.automaticallyAdjustsZRange = true;
    _cameraNode.position = SCNVector3Make(0, 10, 70);
  }
  return _cameraNode;
}


// 上盖模型
-(SCNNode *)topNode {
  if (!_topNode) {
    _topNode = [self.scene.rootNode childNodeWithName:@"boxtop01" recursively:YES];
  }
  return _topNode;
}

// 内衬模型
-(SCNNode *)liningNode {
  if (!_liningNode) {
    _liningNode = [self.scene.rootNode childNodeWithName:@"lining1" recursively:YES];
  }
  return _liningNode;
}

// 下盖模型
-(SCNNode *)downNode {
  if (!_downNode) {
    _downNode =  [self.scene.rootNode childNodeWithName:@"boxdown02" recursively:YES];
  }
  return _downNode;
}

@end
