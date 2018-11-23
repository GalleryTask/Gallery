//
//  ResultModel.h
//  Gallery
//
//  Created by 安东 on 2018/9/28.
//  Copyright © 2018年 安东. All rights reserved.
//

#import "JSONModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface ResultModel : JSONModel

@property (copy, nonatomic) NSString <Optional> *statusCode; ///< 状态码

@end


@protocol CountyTree <NSObject>
@end
@interface CountyTree:JSONModel

@property (copy,   nonatomic) NSString <Optional> *countyCode;   ///< 城市编码
@property (copy,   nonatomic) NSString <Optional> *level;
@property (copy,   nonatomic) NSString <Optional> *name;   ///< 区县名

@end

@protocol CityTree <NSObject>
@end
@interface CityTree:JSONModel

@property (strong, nonatomic) NSArray <Optional,CountyTree> *children;  // 区县
@property (copy,   nonatomic) NSString <Optional> *name;   ///< 市名

@end

@protocol ProvinceTree <NSObject>
@end
@interface ProvinceTree:JSONModel

@property (copy,   nonatomic) NSString <Optional> *code;   ///< 城市编码
@property (copy,   nonatomic) NSString <Optional> *level;
@property (copy,   nonatomic) NSString <Optional> *name;   ///< 省名
@property (strong, nonatomic) NSArray <Optional,CityTree> *children;  // 市

@end

@interface AreaTreeResult:ResultModel

@property (strong, nonatomic) NSArray <Optional,ProvinceTree> *data;

@end

@protocol PlaceOrderArr <NSObject>
@end
@interface PlaceOrderArr : JSONModel

@property (nonatomic, copy) NSString  *title;
@property (nonatomic, copy) NSString  *price;
@property (nonatomic, copy) NSString  *count;

@end

@interface PlaceOrderResult : JSONModel

@property (nonatomic, strong) NSArray <Optional,PlaceOrderArr>  *list;
@property (nonatomic, copy)   NSString  *title;
@property (nonatomic, copy)   NSString  *tag;   // 0没有标签 1打样订单 2 生产订单
@property (nonatomic, assign) BOOL  isSelected;

@end

NS_ASSUME_NONNULL_END
