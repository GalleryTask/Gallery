//
//  SceneView.m
//  3DModelShow
//
//  Created by 安东 on 2018/7/18.
//  Copyright © 2018年 安东. All rights reserved.
//

#import "SceneView.h"

#define MaxSCale 2.0  //最大缩放比例
#define MinScale 0.7  //最小缩放比例
@interface SceneView()

@property (nonatomic, strong) SCNView     *scnView;
@property (nonatomic, strong) SCNNode     *spotNode;  // 灯光节点
@property (nonatomic, strong) SCNNode     *omiNode; // 泛光源
@property (nonatomic, strong) SCNScene    *scene;

@property (nonatomic, strong) SCNNode  *groupNode;
@property (nonatomic, strong) SCNNode  *topNode;
@property (nonatomic, strong) SCNNode  *liningNode;
@property (nonatomic, strong) SCNNode  *liningTwoNode;
@property (nonatomic, strong) SCNNode  *downNode;
@property (nonatomic, strong) SCNNode  *tapTopNode;
@property (nonatomic, strong) SCNNode  *tapLiningNode;
@property (nonatomic, strong) SCNNode  *tapDownNode;
@property (nonatomic, strong) SCNNode  *shadowNode;
@property (nonatomic, assign) CGFloat  lastScale;
@property (nonatomic, assign) CGFloat  startScale;
@property (nonatomic, assign) BOOL  isChangeLining;  // 是否更换内衬

@property (nonatomic, strong) CAAnimationGroup  *boxAnimationGroup; // 动画组
@property (nonatomic, assign) CFTimeInterval maxDuration;  // 动画执行时长


@end

@implementation SceneView

- (id)initWithSceneName:(NSString *)sceneName frame:(CGRect)frame {
  if (self = [super init]) {
    [self setFrame:frame];
    [self createSceneViewWithSceneName:sceneName];
  }
  return self;
}


-(UIImage *) getImageFromURL:(NSString *)fileURL {
  
  UIImage * result;
  
  NSData * data = [NSData dataWithContentsOfURL:[NSURL URLWithString:fileURL]];
  
  result = [UIImage imageWithData:data];
  
  return result;
}

- (void)changeModelWithName:(NSString *)name {
  [self.scnView removeFromSuperview];
  [self createSceneViewWithSceneName:name];
}

// 更换node的贴图图片
- (void)changeNodeDiffuseWithImageNameArray:(NSArray *)array {
  
  SCNMaterial *materialTop = [SCNMaterial new];
  materialTop.lightingModelName = SCNLightingModelLambert;
  materialTop.diffuse.contents = [UIImage imageNamed:array[0]];
  materialTop.ambientOcclusion.contents = [UIImage imageNamed:@"art.scnassets/boxtop_AO.jpg"];
  materialTop.normal.contents = [UIImage imageNamed:@"art.scnassets/boxtop_NRM.jpg"];
  [self.topNode.geometry setMaterials:@[materialTop]];
  
  SCNMaterial *materialLining = [SCNMaterial new];
  materialLining.lightingModelName = SCNLightingModelBlinn;
  materialLining.diffuse.contents = [UIImage imageNamed:array[1]];
  materialLining.normal.contents = [UIImage imageNamed:@"art.scnassets/lining_Normal.jpg"];
  materialLining.ambientOcclusion.contents = [UIImage imageNamed:@"art.scnassets/lining_AO.jpg"];
  [self.liningTwoNode.geometry setMaterials:@[materialLining]];
  [self.liningNode.geometry setMaterials:@[materialLining]];
  
  SCNMaterial *materialDown = [SCNMaterial new];
  materialDown.lightingModelName = SCNLightingModelLambert;
  materialDown.diffuse.contents = [UIImage imageNamed:array[2]];
  materialDown.ambientOcclusion.contents = [UIImage imageNamed:@"art.scnassets/boxdown_AO.jpg"];
  materialDown.normal.contents = [UIImage imageNamed:@"art.scnassets/boxdown_NRM.jpg"];
  [self.downNode.geometry setMaterials:@[materialDown]];
}

// 删除节点 开箱效果 天地盒时移除节点  为拉链纸箱时执行动画
- (void)removeNode {
  
  // 拉链纸箱时执行动画
  if (self.boxAnimationGroup) {
     [self removeAllAction];
    self.boxAnimationGroup.speed = 1;
    [self.scene.rootNode addAnimation:self.boxAnimationGroup forKey:nil];
    return;
  }

  // 天地盒时移除节点
  if ([self.groupNode.childNodes containsObject:self.topNode]) {
    [self removeAllAction];
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
//    [self nodeActionWithX:0.8 y:0 z:0 duration:0.5];
  }
}


// 添加节点 关箱效果 天地盒时添加  拉链纸箱时执行动画
- (void)addNode {
  // 拉链纸箱时执行动画
  if (self.boxAnimationGroup) {
     [self removeAllAction];
    self.boxAnimationGroup.speed = -1;
    [self.scene.rootNode addAnimation:self.boxAnimationGroup forKey:nil];
    return;
  }

  if (![self.groupNode.childNodes containsObject:self.topNode]) {

    [self.topNode addAnimation:[self animationWithKeyPath:@"position.y" duration:0.5 fromValue:@"100" toValue:@"0" repeatCount:0] forKey:nil];
    [self.groupNode addChildNode:self.topNode];
    [self.tapTopNode addAnimation:[self animationWithKeyPath:@"position.y" duration:0.5 fromValue:@"100" toValue:@"0" repeatCount:0] forKey:nil];
    [self.groupNode addChildNode:self.tapTopNode];
    
   
    [self.downNode addAnimation:[self animationWithKeyPath:@"position.y" duration:0.5 fromValue:[NSString stringWithFormat:@"%.2f",self.downNode.position.y] toValue:@"0" repeatCount:0] forKey:nil];
    [self.groupNode addChildNode:self.downNode];
    [self.tapDownNode addAnimation:[self animationWithKeyPath:@"position.y" duration:0.5 fromValue:[NSString stringWithFormat:@"%.2f",self.downNode.position.y] toValue:@"0" repeatCount:0] forKey:nil];
    
    
    // 恢复之前的偏移
    [self nodeActionWithX:0 y:0 z:0 duration:0.5];
  }
}

// 模型旋转
-(void)nodeTurnAround {

  SCNAction *repeatAction = [SCNAction repeatActionForever:[SCNAction rotateByX:0 y:1 z:0 duration:5]];
  [self.groupNode runAction:repeatAction];
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
  [self.groupNode removeAllActions];
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
//        [self changeNodeOpacity:self.tapLiningNode];
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

  if (recognizer.state == UIGestureRecognizerStateBegan) {
    // 记录捏合手势开始时的缩放系数
    self.startScale = self.lastScale;
  }
  
  // 捏合手势默认的系数是1.0
  // 当识别为放大手势时，系数会从1.0开始递加； 当识别为缩小手势时，系数会从1.0开始递减，直到为0.0
  if (self.startScale == 0.0) {
    self.startScale = 1.0;
  }
  CGFloat scale = recognizer.scale + self.startScale - 1.0;
  // 锁定缩放倍数
  if (scale - MinScale < 0.000001) {
    scale = MinScale;
  } else if (scale - MaxSCale > 0.000001) {
    scale  = MaxSCale;
  }
  
  self.lastScale = scale;
  
  self.groupNode.scale = SCNVector3Make(scale, scale, scale);
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
  [self.groupNode runAction:sequence];
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

// 更换模型内衬
- (void)changeLiningNode {

  SCNNode *node;
  if (self.isChangeLining) {
    self.isChangeLining = false;
    node = self.liningNode;
    [self.liningTwoNode removeFromParentNode];
  } else {
    self.isChangeLining = true;
    node = self.liningTwoNode;
    [self.liningNode removeFromParentNode];
  }
  
  [self.groupNode addChildNode:node];
}



/**
 加载开箱动画效果

 @param source 资源
 */
- (BOOL)loadAnimationWithSource:(SCNSceneSource *)source {
  NSArray *animationIDs =  [source identifiersOfEntriesWithClass:[CAAnimation class]];
  
  NSUInteger animationCount = [animationIDs count];
  if (animationCount > 0) {
    
    NSMutableArray *longAnimations = [[NSMutableArray alloc] initWithCapacity:animationCount];
    self.maxDuration = 0;
    for (NSInteger index = 0; index < animationCount; index++) {
      CAAnimation *animation = [source entryWithIdentifier:animationIDs[index] withClass:[CAAnimation class]];
      if (animation) {
        self.maxDuration = MAX(self.maxDuration, animation.duration);
        [longAnimations addObject:animation];
      }
    }
    
    // 开箱动画
    self.boxAnimationGroup = [[CAAnimationGroup alloc] init];
    self.boxAnimationGroup.animations = longAnimations;
    self.boxAnimationGroup.duration = self.maxDuration;
    self.boxAnimationGroup.speed = 0;
    self.boxAnimationGroup.repeatCount = 1;
    // 动画完成后保持最新状态
    self.boxAnimationGroup.removedOnCompletion = NO;
    self.boxAnimationGroup.fillMode = kCAFillModeForwards;
    [self.scene.rootNode addAnimation:self.boxAnimationGroup forKey:nil];
    return true;
  }
  return false;
}

#pragma mark - 创建3D模型场景
- (void)createSceneViewWithSceneName:(NSString *)sceneName {
  
//  self.scene = [SCNScene sceneNamed:sceneName];
//  self.scene = [SCNScene sceneWithURL:[NSURL URLWithString:[sceneName stringByAppendingString:@"/box.DAE"]] options:nil error:nil];
  // 初始化场景
 SCNSceneSource *sceneSource = [SCNSceneSource sceneSourceWithURL:[NSURL URLWithString:sceneName] options:nil];
 self.scene  = [sceneSource sceneWithOptions:nil error:nil];
 
  
  // 设置照相机节点
  [self.scene.rootNode addChildNode:self.cameraNode];
  
  self.groupNode = [self.scene.rootNode childNodeWithName:@"Group001" recursively:YES];
  if (!self.groupNode) {
    self.groupNode = self.scene.rootNode;
  }
  
  // 设置背景图片
  self.scene.background.contents = [UIImage imageNamed:@"scene_background2"];
  // 创建展示场景
  [self addSubview:self.scnView];
  
  self.shadowNode.opacity = 0.2;
  
  // 是否存在动画 不存在则是天地盒 
  if (![self loadAnimationWithSource:sceneSource]) {
    [self.liningTwoNode removeFromParentNode];
    [self.tapDownNode removeFromParentNode];
    
    //  [self changeNodeDiffuseWithImageNameArray:@[[sceneName stringByAppendingString:@"one_boxtop.png"],[sceneName stringByAppendingString:@"one_lining.png"],[sceneName stringByAppendingString:@"one_boxdown.png"]]];
    [self changeNodeDiffuseWithImageNameArray:@[@"art.scnassets/one_boxtop.png",@"art.scnassets/one_lining.png",@"art.scnassets/one_boxdown.png"]];
    
    [self changeNodeOpacity:self.tapTopNode];
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
    // 自动开启默认光源
    _scnView.autoenablesDefaultLighting = true;
    // 场景渲染抗锯齿模式
    _scnView.antialiasingMode = SCNAntialiasingModeMultisampling4X;
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
    _topNode = [self.groupNode childNodeWithName:@"boxtop" recursively:YES];
  }
  return _topNode;
}

// 内衬模型
-(SCNNode *)liningNode {
  if (!_liningNode) {
    _liningNode = [self.groupNode childNodeWithName:@"lining" recursively:YES];
  }
  return _liningNode;
}

-(SCNNode *)liningTwoNode {
  if (!_liningTwoNode) {
    _liningTwoNode = [self.groupNode childNodeWithName:@"lining01" recursively:YES];
    [_liningTwoNode removeFromParentNode];
  }
  return _liningTwoNode;
}

// 下盖模型
-(SCNNode *)downNode {
  if (!_downNode) {
    _downNode =  [self.groupNode childNodeWithName:@"boxdown" recursively:YES];
  }
  return _downNode;
}

-(SCNNode *)tapTopNode {
  if (!_tapTopNode) {
    _tapTopNode = [self.groupNode childNodeWithName:@"tubiao03" recursively:YES];
  }
  return _tapTopNode;
}

-(SCNNode *)tapLiningNode {
  if (!_tapLiningNode) {
    _tapLiningNode = [self.groupNode childNodeWithName:@"tubiao01" recursively:YES];
    [_tapLiningNode removeFromParentNode];
  }
  return _tapLiningNode;
}

-(SCNNode *)tapDownNode {
  if (!_tapDownNode) {
    _tapDownNode = [self.groupNode childNodeWithName:@"tubiao02" recursively:YES];
    
  }
  return _tapDownNode;
}

-(SCNNode *)shadowNode {
  if (!_shadowNode) {
    _shadowNode = [self.groupNode childNodeWithName:@"touying" recursively:YES];
  }
  return _shadowNode;
}

@end
