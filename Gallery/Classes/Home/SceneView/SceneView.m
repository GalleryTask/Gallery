//
//  SceneView.m
//  3DModelShow
//
//  Created by 安东 on 2018/7/18.
//  Copyright © 2018年 安东. All rights reserved.
//

#import "SceneView.h"

#define MaxSCale 1.5  //最大缩放比例
#define MinScale 0.5  //最小缩放比例

@interface SceneView()

@property (nonatomic, strong) SCNView     *scnView;
@property (nonatomic, strong) SCNNode     *spotNode;  // 灯光节点
@property (nonatomic, strong) SCNNode     *omiNode; // 泛光源
@property (nonatomic, strong) SCNScene    *scene;
//@property (nonatomic, strong) SCNMaterial *material;

@property (nonatomic, strong) SCNNode  *topNode;
@property (nonatomic, strong) SCNNode  *liningNode;
@property (nonatomic, strong) SCNNode  *downNode;
@property (nonatomic, strong) SCNNode  *tapTopNode;
@property (nonatomic, strong) SCNNode  *tapLiningNode;
@property (nonatomic, strong) SCNNode  *tapDownNode;
@property (nonatomic, strong) SCNNode  *shadowNode;
@property (nonatomic, assign) CGFloat  lastScale;
@property (nonatomic, strong) NSArray  *nodeArray;

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
    [node.geometry setMaterials:@[material]];
  }
}

// 删除节点
- (void)removeNode {

  if ([self.scnView.scene.rootNode.childNodes containsObject:self.topNode]) {
    
    SCNAnimationEvent *event = [SCNAnimationEvent animationEventWithKeyTime:0.5
                                                                      block:^(id<SCNAnimation>  _Nonnull animation, id  _Nonnull animatedObject, BOOL playingBackward) {
      [self.topNode removeAllAnimations];
      [self.topNode removeFromParentNode];
      [self.tapTopNode removeAllAnimations];
      [self.tapTopNode removeFromParentNode];
                                                                        
    }];
    
    
    CABasicAnimation *animation = [self animationWithKeyPath:@"position.y" duration:1 fromValue:@"0" toValue:@"100" repeatCount:0];
    animation.animationEvents = @[event];
    [self.topNode addAnimation:animation forKey:nil];
    [self.tapTopNode addAnimation:animation forKey:nil];
    // 开盖后偏移
    [self nodeActionWithX:0.8 y:0 z:0 duration:0.5];
  }
}


// 添加节点
- (void)addNode {

  if (![self.scene.rootNode.childNodes containsObject:self.topNode]) {

    [self.topNode addAnimation:[self animationWithKeyPath:@"position.y" duration:0.5 fromValue:@"100" toValue:@"0" repeatCount:0] forKey:nil];
    [self.scnView.scene.rootNode addChildNode:self.topNode];
    [self.tapTopNode addAnimation:[self animationWithKeyPath:@"position.y" duration:0.5 fromValue:@"100" toValue:@"0" repeatCount:0] forKey:nil];
    [self.scnView.scene.rootNode addChildNode:self.tapTopNode];
    
   
    [self.downNode addAnimation:[self animationWithKeyPath:@"position.y" duration:0.5 fromValue:[NSString stringWithFormat:@"%.2f",self.downNode.position.y] toValue:@"0" repeatCount:0] forKey:nil];
    [self.scnView.scene.rootNode addChildNode:self.downNode];
    [self.tapDownNode addAnimation:[self animationWithKeyPath:@"position.y" duration:0.5 fromValue:[NSString stringWithFormat:@"%.2f",self.downNode.position.y] toValue:@"0" repeatCount:0] forKey:nil];
    [self.scnView.scene.rootNode addChildNode:self.tapDownNode];
    
    
    
    // 恢复之前的偏移
    [self nodeActionWithX:0 y:0 z:0 duration:0.5];
  }
  
//  self.cameraNode.position = SCNVector3Make(0, 10, 50);
}

// 模型旋转
-(void)nodeTurnAround {

  SCNAction *repeatAction = [SCNAction repeatActionForever:[SCNAction rotateByX:0 y:1 z:0 duration:5]];
  for (SCNNode *node in self.nodeArray) {
    [node runAction:repeatAction];
  }
}

// 模型展开
- (void)nodeOpenTopAndBottom {

  [self.topNode addAnimation:[self animationWithKeyPath:@"position.y" duration:0.5 fromValue:@"0" toValue:@"5" repeatCount:0] forKey:nil];
  [self.downNode addAnimation:[self animationWithKeyPath:@"position.y" duration:0.5 fromValue:@"0" toValue:@"-10" repeatCount:0] forKey:nil];
  [self.tapTopNode addAnimation:[self animationWithKeyPath:@"position.y" duration:0.5 fromValue:@"0" toValue:@"5" repeatCount:0] forKey:nil];
  [self.tapDownNode addAnimation:[self animationWithKeyPath:@"position.y" duration:0.5 fromValue:@"0" toValue:@"-10" repeatCount:0] forKey:nil];
  [self.shadowNode addAnimation:[self animationWithKeyPath:@"position.y" duration:0.5 fromValue:@"0" toValue:@"-10" repeatCount:0] forKey:nil];
}

// 模型收回
- (void)nodeCloseTopAndBottom {
  
  [self.topNode addAnimation:[self animationWithKeyPath:@"position.y" duration:0.5 fromValue:@"5" toValue:@"0" repeatCount:0] forKey:nil];
  [self.downNode addAnimation:[self animationWithKeyPath:@"position.y" duration:0.5 fromValue:@"-10" toValue:@"0" repeatCount:0] forKey:nil];
  [self.tapTopNode addAnimation:[self animationWithKeyPath:@"position.y" duration:0.5 fromValue:@"5" toValue:@"0" repeatCount:0] forKey:nil];
  [self.tapDownNode addAnimation:[self animationWithKeyPath:@"position.y" duration:0.5 fromValue:@"-10" toValue:@"0" repeatCount:0] forKey:nil];
  [self.shadowNode addAnimation:[self animationWithKeyPath:@"position.y" duration:0.5 fromValue:@"-10" toValue:@"0" repeatCount:0] forKey:nil];
}

// 移除模型动效
- (void)removeAllAction {
  for (SCNNode *node in self.nodeArray) {
    [node removeAllActions];
  }
}


// 系统方法响应者链
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
  
  if (self.scene.rootNode) {
    
    [self removeAllAction];
    
    CGPoint tapPoint  = [[touches anyObject] locationInView:self.scnView]; // 该点就是手指的点击位置
    
    NSDictionary *hitTestOptions = [NSDictionary dictionaryWithObjectsAndKeys:@(true),SCNHitTestBoundingBoxOnlyKey, nil];
    
    NSArray<SCNHitTestResult *> * results= [self.scnView hitTest:tapPoint options:hitTestOptions];
    
    for (SCNHitTestResult *res in results) { // 遍历所有的返回结果中的node
      
      if ([self isTopNodeClick:res.node]) {
        
        [self nodeOpenTopAndBottom];
        [self.tapTopNode removeFromParentNode];
//        SCNMaterial *material = [SCNMaterial new];
//        material.lightingModelName = SCNLightingModelLambert;
//        material.diffuse.contents = [UIImage imageNamed:@"3_tubiao"];
//
//        [self.tapLiningNode.geometry setMaterials:@[material]];
        [self changeNodeOpacity:self.tapLiningNode];
        break;
      }
      
      if ([self isLiningNodeClick:res.node]) {
        [self.topNode removeFromParentNode];
        [self.downNode removeFromParentNode];
        [self.tapLiningNode removeFromParentNode];
        [self.tapTopNode removeFromParentNode];
        [self.tapDownNode removeFromParentNode];
        break;
      }
    }
  }
}

- (BOOL)isTopNodeClick:(SCNNode *)node {
  
  return [self isNodePartOfVirtualObject:node selectedNode:self.tapTopNode];
}

- (BOOL)isLiningNodeClick:(SCNNode *)node {
  
  return [self isNodePartOfVirtualObject:node selectedNode:self.tapLiningNode];
}

- (BOOL)isNodePartOfVirtualObject:(SCNNode*)node selectedNode:(SCNNode *)selectedNode {
  
  if ([selectedNode.name isEqualToString:node.name]) {
    
    return true;
    
  }
  
  if (node.parentNode != nil) {
    
    return [self isNodePartOfVirtualObject:node.parentNode selectedNode:selectedNode];
  }
  
  return false;
}

// 手势缩放
- (void)pinch:(UIPinchGestureRecognizer *)recognizer {
  
  CGFloat scale = recognizer.scale;
  switch (recognizer.state) {
      case UIGestureRecognizerStateBegan:
      scale = self.lastScale;
      break;
    case UIGestureRecognizerStateChanged:
    {

      if (scale >= MaxSCale || scale <= MinScale) {
        return;
      }
      
      for (SCNNode *node in self.nodeArray) {
        
        node.scale = SCNVector3Make(scale, scale, scale);
      }
    }
      break;
    case UIGestureRecognizerStateEnded:
      self.lastScale = scale;
      break;
      
    default:
      break;
  }
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

/**
 模型改变透明度
 
 */
-(void)changeNodeOpacity:(SCNNode *)node {
  
  @autoreleasepool {
    __block BOOL opacityBool;
    // GCD定时器
    static dispatch_source_t _timer;
    NSTimeInterval period = 0.15; //设置时间间隔
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    dispatch_source_set_timer(_timer, dispatch_walltime(NULL, 0), period * NSEC_PER_SEC, 0); //每秒执行
    // 事件回调
    dispatch_source_set_event_handler(_timer, ^{
      dispatch_async(dispatch_get_main_queue(), ^{
     
        if (node.opacity <= 0) {
          opacityBool = NO;
        }else if(node.opacity >= 1){
          opacityBool = YES;
        }
        if (opacityBool) {
          node.opacity -= 0.15;
        }else{
          node.opacity += 0.15;
        }
      });
    });
    // 开启定时器
    dispatch_resume(_timer);
  }
}

#pragma mark - 创建3D模型场景
- (void)createSceneViewWithSceneName:(NSString *)sceneName {
  
  // 初始化场景
  self.scene = [SCNScene sceneNamed:sceneName];
  //   self.scene = [SCNScene sceneWithURL:sceneName options:nil error:nil];
  
  [self.scene.rootNode addChildNode:self.cameraNode];
  
  // 创建展示场景
  [self addSubview:self.scnView];
  

  self.nodeArray = @[self.topNode,self.liningNode,self.downNode,self.tapTopNode,self.tapLiningNode,self.tapDownNode,self.shadowNode];

//  [self nodeActionWithX:0.5 y:0 z:0 duration:0];
//    SCNMaterial *material = [SCNMaterial new];
//    material.lightingModelName = SCNLightingModelLambert;
//    material.diffuse.contents = [UIImage imageNamed:@"3_tubiao"];
  
//    [self.tapTopNode.geometry setMaterials:@[material]];
  
  [self changeNodeDiffuseWithImageNameArray:@[@"art.scnassets/one_boxtop.png",@"art.scnassets/one_lining.jpg",@"art.scnassets/one_boxdown.png"]];
  
  [self changeNodeOpacity:self.tapTopNode];
}

#pragma marks - getters
// 创建展示场景
-(SCNView *)scnView {
  if (!_scnView) {
    // 创建展示场景
    _scnView = [[SCNView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    // 设置场景
    _scnView.scene = self.scene;
    // 自动开启默认光源
    _scnView.autoenablesDefaultLighting = true;
    // 设置背景颜色
//    _scnView.backgroundColor = [UIColor hexStringToColor:@"#F5F5F5"];
    _scnView.backgroundColor = [UIColor clearColor];
    // 允许控制摄像机位置
    _scnView.allowsCameraControl = YES;
    UIPinchGestureRecognizer *tap = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(pinch:)];
    [_scnView addGestureRecognizer:tap];
  }
  return _scnView;
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

-(SCNNode *)tapTopNode {
  if (!_tapTopNode) {
    _tapTopNode = [self.scene.rootNode childNodeWithName:@"tubiao009" recursively:YES];
  }
  return _tapTopNode;
}

-(SCNNode *)tapLiningNode {
  if (!_tapLiningNode) {
    _tapLiningNode = [self.scene.rootNode childNodeWithName:@"tubiao011" recursively:YES];
  }
  return _tapLiningNode;
}

-(SCNNode *)tapDownNode {
  if (!_tapDownNode) {
    _tapDownNode = [self.scene.rootNode childNodeWithName:@"tubiao010" recursively:YES];
  }
  return _tapDownNode;
}

-(SCNNode *)shadowNode {
  if (!_shadowNode) {
    _shadowNode = [self.scene.rootNode childNodeWithName:@"touying" recursively:YES];
    _shadowNode.opacity = 0.1;
  }
  return _shadowNode;
}

@end
