//
//  ModelLoadingNode.m
//  Gallery
//
//  Created by 安东 on 17/12/2018.
//  Copyright © 2018 安东. All rights reserved.
//

#import "ModelLoadingNode.h"

@implementation ModelLoadingNode

-(instancetype)init {
  if (self = [super init]) {
    NSURL *url = [[NSBundle mainBundle] URLForResource:@"box" withExtension:@"DAE"];
    SCNNode *node = [SCNReferenceNode referenceNodeWithURL:url];
    [self addChildNode:node];
  }
  return self;
}

@end
