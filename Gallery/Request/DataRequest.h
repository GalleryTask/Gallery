//
//  Model.h
//  YSD
//
//  Created by 安东 on 2017/2/20.
//  Copyright © 2017年 安东. All rights reserved.
//

#import "BaseDataRequest.h"

@interface DataRequest : BaseDataRequest

/**
 获取省市区信息
 */
- (void)getAreaTree;

@end
