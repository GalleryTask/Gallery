//
//  ResultModel.m
//  Gallery
//
//  Created by 安东 on 2018/9/28.
//  Copyright © 2018年 安东. All rights reserved.
//

#import "ResultModel.h"

@implementation ResultModel

@end


@implementation CountyTree

+(JSONKeyMapper *)keyMapper {
  return [[JSONKeyMapper alloc] initWithModelToJSONDictionary:@{@"countyCode":@"code"}];
}

@end

@implementation CityTree

@end

@implementation ProvinceTree

@end

@implementation AreaTreeResult

@end
