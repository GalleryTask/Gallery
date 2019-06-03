//
//  ARViewController.m
//  3DModelShow
//
//  Created by 安东 on 2018/7/26.
//  Copyright © 2018年 安东. All rights reserved.
//

#import "ARViewController.h"
//#import "SceneView.h"

// ARKit框架
#import <ARKit/ARKit.h>

// 3D游戏框架
#import <SceneKit/SceneKit.h>

API_AVAILABLE(ios(11.0))
// A9芯片及以上支持ARKit
@interface ARViewController () <ARSCNViewDelegate>

// AR场景视图，展示3D界面
@property (nonatomic, strong) ARSCNView  *arSCNView;

// 会话追踪配置：负责追踪相机的运动
@property (nonatomic, strong) ARWorldTrackingConfiguration  *arConfiguration;

// AR会话，负责管理相机追踪配置及3D相机坐标
@property(nonatomic,strong) ARSession *arSession;

@property (nonatomic, assign) ARTrackingState  currentTrackingState;    // 位置跟踪质量的可能值

@property (nonatomic, strong) UISwitch  *switchBtn;

@end

@implementation ARViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  
  self.title = @"AR实景";
  
  [self.view setBackgroundColor:[UIColor whiteColor]];
  self.currentTrackingState = ARTrackingStateNormal;
  
  // 创建手势
  [self setupRecognizers];
  
}

-(void)viewDidAppear:(BOOL)animated {
  [super viewDidAppear:animated];
  // 1.将AR视图添加到当前视图
  [self.view addSubview:self.arSCNView];
  [self.view addSubview:self.switchBtn];
  // 2.开启AR会话
  [self.arSCNView.session runWithConfiguration:self.arConfiguration options:0];
}


-(void)viewDidDisappear:(BOOL)animated {
  [super viewDidDisappear:animated];
  
  [self.arSCNView.session pause];
}

#pragma mark - ARSCNViewDelegate 代理方法

- (void)renderer:(id <SCNSceneRenderer>)renderer updateAtTime:(NSTimeInterval)time {
  if (@available(iOS 11.0, *)) {
    ARLightEstimate *estimate = self.arSCNView.session.currentFrame.lightEstimate;
    if (!estimate) {
      return;
    }
    
    // A value of 1000 is considered neutral, lighting environment intensity normalizes
    // 1.0 to neutral so we need to scale the ambientIntensity value
    CGFloat intensity = estimate.ambientIntensity / 1000.0;
    self.arSCNView.scene.lightingEnvironment.intensity = intensity;
  } else {
    // Fallback on earlier versions
  }
 
}

/**
 有新的 node 被映射到给定的 anchor 时调用。
 每次 ARKit 自认为检测到了平面时都会调用此方法
 
 @param renderer 将会用于渲染 scene 的 renderer。
 @param node 映射到 anchor 的 node。
 @param anchor 新添加的 anchor。
 */
- (void)renderer:(id <SCNSceneRenderer>)renderer didAddNode:(SCNNode *)node forAnchor:(ARAnchor *)anchor  API_AVAILABLE(ios(11.0)) {
  if (![anchor isKindOfClass:[ARPlaneAnchor class]]) {
    return;
  }
  
  NSLog(@"捕捉到平地");
  dispatch_async(dispatch_get_main_queue(), ^{
    // UI更新代码
    
//    [self.messageView queueMessage:@"检测平面完成"];
    [self promptHudViewWithText:@"平面区域检测成功" isHidden:YES];
  });
  // 1.获取捕捉到的平面锚点
  if (@available(iOS 11.0, *)) {
    ARPlaneAnchor *planeAnchor = (ARPlaneAnchor *)anchor;
    // 2.创建一个3D物体模型 （参数分别是长宽高和圆角）
    SCNBox *plane = [SCNBox boxWithWidth:planeAnchor.extent.x*0.3 height:0 length:planeAnchor.extent.x*0.3 chamferRadius:0];
    // 3.使用Material渲染3D物体模型的节点 （默认是白色的）
    plane.firstMaterial.diffuse.contents = [UIColor clearColor];
    // 4.创建一个基于3D物体模型的节点
    SCNNode *planeNode = [SCNNode nodeWithGeometry:plane];
    // 5.设置节点的位置为捕捉到的平地锚点的中心位置 SceneKit框架中节点的位置position是一个基于3D坐标系的矢量坐标SCNVector3Make
    planeNode.position = SCNVector3Make(planeAnchor.center.x, 0, planeAnchor.center.z);
    
    [node addChildNode:planeNode];
    
    //2.当捕捉到平地时，2s之后开始在平地上添加一个3D模型
    
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//      //1.创建一个花瓶场景
//      SCNScene *scene = [SCNScene sceneNamed:@"art.scnassets/box.DAE"];
//
//      //2.获取花瓶节点（一个场景会有多个节点，此处我们只写，花瓶节点则默认是场景子节点的第一个）
//      //所有的场景有且只有一个根节点，其他所有节点都是根节点的子节点
//      SCNNode *vaseNode = scene.rootNode;
//      vaseNode.scale = SCNVector3Make(0.1, 0.1, 0.1);
//      vaseNode.position = SCNVector3Make(planeAnchor.center.x, 0, planeAnchor.center.z);
//
//      for (SCNNode *anode in node.childNodes) {
//
//        anode.scale = SCNVector3Make(0.1, 0.1, 0.1);
//
//        anode.position = SCNVector3Make(planeAnchor.center.x, 0, planeAnchor.center.z);
//      }
//
//      //5.将花瓶节点添加到当前屏幕中
//      //!!!此处一定要注意：花瓶节点是添加到代理捕捉到的节点中，而不是AR试图的根节点。因为捕捉到的平地锚点是一个本地坐标系，而不是世界坐标系
//      //    [node addChildNode:vaseNode];
//      [planeNode addChildNode:vaseNode];
//
//    });
  } else {
    // Fallback on earlier versions
  }
 
  
  

}

/**
 Called when a node has been updated with data from the given anchor.
 
 @param renderer The renderer that will render the scene.
 @param node The node that was updated.
 @param anchor The anchor that was updated.
 */
- (void)renderer:(id <SCNSceneRenderer>)renderer didUpdateNode:(SCNNode *)node forAnchor:(ARAnchor *)anchor  API_AVAILABLE(ios(11.0)) {
//  Plane *plane = [self.planes objectForKey:anchor.identifier];
//  if (plane == nil) {
//    return;
//  }
//
//  // When an anchor is updated we need to also update our 3D geometry too. For example
//  // the width and height of the plane detection may have changed so we need to update
//  // our SceneKit geometry to match that
//  [plane update:(ARPlaneAnchor *)anchor];
}

/**
 Called when a mapped node has been removed from the scene graph for the given anchor.
 
 @param renderer The renderer that will render the scene.
 @param node The node that was removed.
 @param anchor The anchor that was removed.
 */
- (void)renderer:(id <SCNSceneRenderer>)renderer didRemoveNode:(SCNNode *)node forAnchor:(ARAnchor *)anchor  API_AVAILABLE(ios(11.0)) {
  // Nodes will be removed if planes multiple individual planes that are detected to all be
  // part of a larger plane are merged.
//  [self.planes removeObjectForKey:anchor.identifier];
}

/**
 Called when a node will be updated with data from the given anchor.
 
 @param renderer The renderer that will render the scene.
 @param node The node that will be updated.
 @param anchor The anchor that was updated.
 */
- (void)renderer:(id <SCNSceneRenderer>)renderer willUpdateNode:(SCNNode *)node forAnchor:(ARAnchor *)anchor  API_AVAILABLE(ios(11.0)) {
  
}


- (void)session:(ARSession *)session cameraDidChangeTrackingState:(ARCamera *)camera  API_AVAILABLE(ios(11.0)) {
  ARTrackingState trackingState = camera.trackingState;
  if (self.currentTrackingState == trackingState) {
    return;
  }
  self.currentTrackingState = trackingState;
  NSString *string;
  switch(trackingState) {
    case ARTrackingStateNotAvailable:
      string = @"相机位置跟踪不可用";
      break;
      
    case ARTrackingStateLimited:
      string = @"跟踪是可用的，但结果的质量是可疑的";
      switch(camera.trackingStateReason) {
        case ARTrackingStateReasonNone:
          string = @"当前的跟踪状态不受限制";
          break;
        case ARTrackingStateReasonInitializing:
          string = @"ARSession尚未收集足够的相机或动作数据来提供跟踪信息";
          break;
        case ARTrackingStateReasonExcessiveMotion:
          string = @"该设备移动得太快，无法进行精确的基于图像的位置跟踪";
          break;
        case ARTrackingStateReasonInsufficientFeatures:
          string = @"相机可见的场景不包含足够的区分特征用于基于图像的位置跟踪";
          break;
        case ARTrackingStateReasonRelocalizing:
          string = @"ARSession尝试在中断后继续";
          break;
      }
      break;
      
    case ARTrackingStateNormal:
      string = @"相机位置跟踪提供最佳结果";
      break;
  }

  [self promptHudViewWithText:string isHidden:YES];
}

- (void)sessionWasInterrupted:(ARSession *)session  API_AVAILABLE(ios(11.0)) {
  
  NSLog(@"ARSession中断");
}


- (void)refresh {

  if (self.switchBtn.isOn) {
    [self.switchBtn setOn:NO];
    for (int i = 0; i < self.dataSource.count; i++) {
      
      SCNNode *node = self.dataSource[i];
      node.opacity = 1;
      [self.arSCNView.scene.rootNode addChildNode:node];
    }
  } else {
    [self.switchBtn setOn:YES];
    for (int i = 0; i < self.dataSource.count; i++) {
      
      SCNNode *node = self.dataSource[i];
      node.opacity = 0.3;
      [self.arSCNView.scene.rootNode addChildNode:node];
    }
  }
}
#pragma mark - 创建手势
- (void)setupRecognizers {

  UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(insertCubeFrom:)];
  tapGestureRecognizer.numberOfTapsRequired = 1;
  [self.arSCNView addGestureRecognizer:tapGestureRecognizer];
  
  // Press and hold will open a config menu for the selected geometry
//  UILongPressGestureRecognizer *materialGestureRecognizer = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(geometryConfigFrom:)];
//  materialGestureRecognizer.minimumPressDuration = 0.5;
//  [self.arSCNView addGestureRecognizer:materialGestureRecognizer];
//
//  // Press and hold with two fingers causes an explosion
//  UILongPressGestureRecognizer *explodeGestureRecognizer = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(explodeFrom:)];
//  explodeGestureRecognizer.minimumPressDuration = 1;
//  explodeGestureRecognizer.numberOfTouchesRequired = 2;
//  [self.arSCNView addGestureRecognizer:explodeGestureRecognizer];
}

#pragma mark - 点击手势点击事件
- (void)insertCubeFrom: (UITapGestureRecognizer *)recognizer {
  CGPoint tapPoint = [recognizer locationInView:self.arSCNView];
  if (@available(iOS 11.0, *)) {
    NSArray<ARHitTestResult *> *result = [self.arSCNView hitTest:tapPoint types:ARHitTestResultTypeExistingPlaneUsingExtent];
    if (result.count == 0) {
      return;
    }
    
    ARHitTestResult * hitResult = [result firstObject];
    [self insertCube:hitResult];
  } else {
    // Fallback on earlier versions
  }
  
}

#pragma mark - 加入立方体箱子
- (void)insertCube:(ARHitTestResult *)hitResult  API_AVAILABLE(ios(11.0)) {
  
  if (self.dataSource.count == 0 ) {
    
    // 震动反馈
    UIImpactFeedbackGenerator *generator = [[UIImpactFeedbackGenerator alloc] initWithStyle: UIImpactFeedbackStyleMedium];
    [generator prepare];
    [generator impactOccurred];
    
    SCNVector3 position = SCNVector3Make(
                                         hitResult.worldTransform.columns[3].x,
                                         hitResult.worldTransform.columns[3].y,
                                         hitResult.worldTransform.columns[3].z
                                         );
    
    SCNScene *scene = [SCNScene sceneNamed:@"art.scnassets/box.DAE"];
    SCNNode *node = scene.rootNode;
    
    // 调整模型的位置并缩放，模型较大
    node.scale = SCNVector3Make(0.07, 0.07, 0.07);
    node.position = position;
    
    // 子节点要一起调整位置并缩放，否则会设置无效
    for (SCNNode *anode in node.childNodes) {
      
      anode.scale = SCNVector3Make(0.07, 0.07, 0.07);
      anode.position = position;
    }
    
    
    if (self.switchBtn.isOn) {
      node.opacity = 0.3;
    } else {
      node.opacity = 1;
    }
    
    [self.arSCNView.scene.rootNode addChildNode:node];
    [self.dataSource addObject:node];
  }
  
}

#pragma mark - setters and getters
-(ARSCNView *)arSCNView  API_AVAILABLE(ios(11.0)){
  if (!_arSCNView) {
    _arSCNView = [[ARSCNView alloc] initWithFrame:self.view.bounds];
    
    _arSCNView.antialiasingMode =SCNAntialiasingModeMultisampling4X;
    // 添加代理
    _arSCNView.delegate = self;
    _arSCNView.autoenablesDefaultLighting = true;
    _arSCNView.session = self.arSession;
    
    SCNScene *scene = [SCNScene new];
    _arSCNView.scene = scene;
  }
  return _arSCNView;
}

- (ARSession *)arSession  API_AVAILABLE(ios(11.0)) {
  if(_arSession != nil)
  {
    return _arSession;
  }
  _arSession = [[ARSession alloc] init];

  return _arSession;
}


-(ARWorldTrackingConfiguration *)arConfiguration  API_AVAILABLE(ios(11.0)) {
  if (!_arConfiguration) {
    // 1.创建世界追踪会话配置
    _arConfiguration = [[ARWorldTrackingConfiguration alloc] init];
    // 2.检测水平面 设置追踪方向
    _arConfiguration.planeDetection = ARPlaneDetectionHorizontal;
    // 3.自适应灯光
    _arConfiguration.lightEstimationEnabled = YES;
  }
  return _arConfiguration;
}


-(UISwitch *)switchBtn {
  if (!_switchBtn) {
    _switchBtn = [[UISwitch alloc] initWithFrame:CGRectMake(self.view.bounds.size.width-100, self.view.bounds.size.height-100, 0, 0)];
    [_switchBtn addTarget:self action:@selector(refresh) forControlEvents:UIControlEventValueChanged];
  }
  return _switchBtn;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
