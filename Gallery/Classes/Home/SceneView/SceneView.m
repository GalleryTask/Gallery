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
@property (nonatomic, strong) SCNNode     *omiNode; // 泛光源
@property (nonatomic, strong) SCNScene    *scene;
@property (nonatomic, strong) SCNMaterial *material;

@property (nonatomic, strong) SCNNode  *topNode;
@property (nonatomic, strong) SCNNode  *liningNode;
@property (nonatomic, strong) SCNNode  *downNode;
@property (nonatomic, assign) CGFloat  totalScale;
@property (nonatomic, strong) NSArray  *nodeArray;

@end

@implementation SceneView

- (id)initWithSceneName:(NSString *)sceneName frame:(CGRect)frame {
  if (self = [super init]) {
    [self setFrame:frame];
    self.totalScale = 1.0;
    [self createSceneViewWithSceneName:sceneName];
  }
  return self;
}

// 设置反光效果
//-(void)sceneViewReflectiveImage:(UIImage *)image {
//  self.material.fresnelExponent = 1.7;
//  self.material.reflective.contents = image;
//
//  for (SCNNode *aNode in self.scene.rootNode.childNodes) {
//    [aNode.geometry setMaterials:@[self.material]];
//  }
//}


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
    
    SCNAnimationEvent *event = [SCNAnimationEvent animationEventWithKeyTime:0.5
                                                                      block:^(id<SCNAnimation>  _Nonnull animation, id  _Nonnull animatedObject, BOOL playingBackward) {
      [self.topNode removeAllAnimations];
      [self.topNode removeFromParentNode];
    }];
    
    
    CABasicAnimation *animation = [self animationWithKeyPath:@"position.y" duration:1 fromValue:@"0" toValue:@"100" repeatCount:0];
    animation.animationEvents = @[event];
    [self.topNode addAnimation:animation forKey:nil];
    
    // 开盖后偏移
    [self nodeActionWithX:0.8 y:0 z:0 duration:0.5];
  }
}


// 添加节点
- (void)addNode {

  if (![self.scene.rootNode.childNodes containsObject:self.topNode]) {

    [self.topNode addAnimation:[self animationWithKeyPath:@"position.y" duration:0.5 fromValue:@"100" toValue:@"0" repeatCount:0] forKey:nil];
    [self.scnView.scene.rootNode addChildNode:self.topNode];
    
    // 恢复之前的偏移
    [self nodeActionWithX:0 y:0 z:0 duration:0.5];
  }
  
  self.cameraNode.position = SCNVector3Make(0, 10, 50);
}

// 模型旋转
-(void)nodeTurnAround {

  SCNAction *repeatAction = [SCNAction repeatAction:[SCNAction rotateByX:0 y:1 z:0 duration:0.3] count:4];
  for (SCNNode *node in self.nodeArray) {
    [node runAction:repeatAction];
  }
}

- (void)nodeOpenTopAndBottom {

  [self.topNode addAnimation:[self animationWithKeyPath:@"position.y" duration:0.5 fromValue:@"0" toValue:@"5" repeatCount:0] forKey:nil];
  [self.downNode addAnimation:[self animationWithKeyPath:@"position.y" duration:0.5 fromValue:@"0" toValue:@"-10" repeatCount:0] forKey:nil];
}

- (void)nodeCloseTopAndBottom {
  
  [self.topNode addAnimation:[self animationWithKeyPath:@"position.y" duration:0.5 fromValue:@"5" toValue:@"0" repeatCount:0] forKey:nil];
  [self.downNode addAnimation:[self animationWithKeyPath:@"position.y" duration:0.5 fromValue:@"-10" toValue:@"0" repeatCount:0] forKey:nil];
}


#pragma mark - 创建3D模型场景
- (void)createSceneViewWithSceneName:(NSString *)sceneName {
  
  // 初始化场景
  self.scene = [SCNScene sceneNamed:sceneName];
//   self.scene = [SCNScene sceneWithURL:sceneName options:nil error:nil];
  
  [self.scene.rootNode addChildNode:self.cameraNode];
  // 创建灯光
//  [self.scene.rootNode addChildNode:self.spotNode];
//  [self.cameraNode addChildNode:self.omiNode];
  // 创建展示场景
  [self addSubview:self.scnView];
  
  self.nodeArray = @[self.topNode,self.liningNode,self.downNode];
  
  SCNNode *node = [self.scene.rootNode childNodeWithName:@"tubiao01" recursively:YES];
//  SCNNode *node2 = [self.scene.rootNode childNodeWithName:@"tubiao02" recursively:YES];
//  SCNNode *node3 = [self.scene.rootNode childNodeWithName:@"tubiao03" recursively:YES];
//  NSArray *array = @[node1,node2,node3];
//
//  for (int i = 0; i < 3; i++) {
  
    SCNMaterial *material = [SCNMaterial new];
    material.lightingModelName = SCNLightingModelLambert;
    material.diffuse.contents = [UIImage imageNamed:@"3_tubiao"];
//    SCNNode *node = array[i];
  
    [node.childNodes[0].geometry setMaterials:@[material]];
    SCNAction *repeatAction = [SCNAction repeatActionForever:[SCNAction fadeOpacityBy:0 duration:10] ];
    [node runAction:repeatAction];
//  }

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

/**
 动画
 
 @param keypath 偏移方向 position.x position.y
 @param duration 动画时长
 @param fromValue 开始位置
 @param toValue 结束位置
 @param count 执行次数
 @return CABasicAnimation
 */
- (CABasicAnimation *)animationWithKeyPath:(NSString *)keypath
                                  duration:(CGFloat)duration
                                 fromValue:(NSString *)fromValue
                                   toValue:(NSString *)toValue
                               repeatCount:(NSInteger)count {
  CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:keypath];
  animation.duration = duration;
  animation.fromValue = fromValue;
  animation.toValue = toValue;
  animation.repeatCount = count;
  animation.fillMode=kCAFillModeForwards;
  animation.removedOnCompletion = NO;
  return animation;
}


/**
 模型偏移

 @param x x方向
 @param y y方向
 @param z z方向
 @param duration 时长
 */
- (void)nodeActionWithX:(CGFloat)x y:(CGFloat)y z:(CGFloat)z duration:(CGFloat)duration {
  SCNAction *action = [SCNAction rotateToX:x y:y z:z duration:duration];
  SCNAction *sequence = [SCNAction sequence:@[action]];
  for (SCNNode *node in self.nodeArray) {
    [node runAction:sequence];
  }
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
//    _scnView.backgroundColor = [UIColor clearColor];
    // 允许控制摄像机位置
    _scnView.allowsCameraControl = YES;
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

// 创建环境光
- (SCNNode *)spotNode{
  if (!_spotNode) {
//    _spotNode = [self.scene.rootNode childNodeWithName:@"EnvironmentAmbientLight" recursively:YES];
    SCNLight *light = [SCNLight light];// 创建光对象
    light.type = SCNLightTypeAmbient;// 设置类型
    light.spotOuterAngle = 2;
    light.color = [UIColor colorWithWhite:0.9 alpha:1.0]; // 设置光的颜色
    _spotNode = [SCNNode node];
    _spotNode.light = light;
  }
  return _spotNode;
}

// 创建泛光源
-(SCNNode *)omiNode {
  if (!_omiNode) {
    SCNLight *light = [SCNLight light];// 创建光对象
    light.type = SCNLightTypeOmni;// 设置类型
    light.spotOuterAngle = 2;
    light.color = [UIColor whiteColor]; // 设置光的颜色
    light.castsShadow = true;
    _omiNode = [SCNNode node];
    _omiNode.position = SCNVector3Make(50, 50, 20);
    _omiNode.light = light;
  }
  return _omiNode;
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
    _topNode = [self.scene.rootNode childNodeWithName:@"boxtop" recursively:YES];
  }
  return _topNode;
}

// 内衬模型
-(SCNNode *)liningNode {
  if (!_liningNode) {
    _liningNode = [self.scene.rootNode childNodeWithName:@"lining" recursively:YES];
  }
  return _liningNode;
}

// 下盖模型
-(SCNNode *)downNode {
  if (!_downNode) {
    _downNode =  [self.scene.rootNode childNodeWithName:@"boxdown" recursively:YES];
  }
  return _downNode;
}

@end
