//
//  OrderCell.h
//  Gallery
//
//  Created by 安东 on 22/11/2018.
//  Copyright © 2018 安东. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol  OrderHeaderCellDelegate  <NSObject>

- (void)orderHeaderCellWithSelected:(BOOL)selected index:(NSInteger)index;

@end

@interface OrderHeaderCell : UITableViewCell

@property (nonatomic, weak) id <OrderHeaderCellDelegate> delegate;
@property (nonatomic, strong) NSIndexPath  *indexPath;

- (id)initWithData:(PlaceOrderResult *)data isEdit:(BOOL)isEdit;
@end

NS_ASSUME_NONNULL_END
