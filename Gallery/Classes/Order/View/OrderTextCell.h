//
//  OrderTextCell.h
//  Gallery
//
//  Created by 安东 on 22/11/2018.
//  Copyright © 2018 安东. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN


@interface OrderTextCell : UITableViewCell

/**
 初始化cell

 @param data 数据源
 @param isCorner cell是否圆角显示
 @param isEdit cell的编辑状态
 @return cell
 */
-(id)initWithData:(PlaceOrderArr *)data bottomCorner:(BOOL)isCorner isEdit:(BOOL)isEdit;

@end

NS_ASSUME_NONNULL_END
