//
//  SceneView.h
//  3DModelShow
//
//  Created by 安东 on 2018/7/18.
//  Copyright © 2018年 安东. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <SceneKit/SceneKit.h>

@interface SceneView : UIView

@property (nonatomic, strong) SCNNode     *cameraNode; // 角度

- (id)initWithSceneName:(NSString *)sceneName frame:(CGRect)frame;

// 移除节点
- (void)removeNode;
// 添加节点
- (void)addNode;
// 模型转一圈
- (void)nodeTurnAround;

- (void)nodeOpenTopAndBottom;

- (void)nodeCloseTopAndBottom;

// 更换贴图图片
- (void)changeNodeDiffuseWithImageNameArray:(NSArray *)array;
@end
