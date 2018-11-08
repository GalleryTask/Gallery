//
//  SceneView.h
//  3DModelShow
//
//  Created by 安东 on 2018/7/18.
//  Copyright © 2018年 安东. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SceneView : UIView


- (id)initWithSceneName:(NSString *)sceneName frame:(CGRect)frame;
// 设置反光效果
- (void)sceneViewReflectiveImage:(UIImage *)image;
// 设置贴图图片
- (void)sceneViewDiffuseImage:(UIImage *)image;
// 移除节点
- (void)removeNode;
// 添加节点
- (void)addNode;
// 改变模型位置
- (void)changeCameraNodePosition;
@end
