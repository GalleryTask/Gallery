//
//  SceneView.h
//  3DModelShow
//
//  Created by 安东 on 2018/7/18.
//  Copyright © 2018年 安东. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SceneView : UIView


- (id)initWithSceneName:(NSURL *)sceneName frame:(CGRect)frame;

- (void)sceneViewReflectiveImage:(UIImage *)image;

- (void)sceneViewDiffuseImage:(UIImage *)image;

- (void)removeNode;

- (void)addNode;
@end
