//
//  CategoryDetallCell.h
//  Gallery
//
//  Created by admin on 2018/11/8.
//  Copyright © 2018 安东. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
  ProductsType,
  CategoryDetailType,
} CellType;

NS_ASSUME_NONNULL_BEGIN

@interface CategoryDetallCell : UICollectionViewCell

@property (nonatomic, strong) NSDictionary  *dataDic;

@property (nonatomic, assign) CellType type;

@end

NS_ASSUME_NONNULL_END
