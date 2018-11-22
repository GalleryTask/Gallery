//
//  OrderCell.h
//  Gallery
//
//  Created by 安东 on 22/11/2018.
//  Copyright © 2018 安东. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface OrderHeaderCell : UITableViewCell

- (id)initWithTitle:(NSString *)title tag:(NSString *)tagTitle isEdit:(BOOL)isEdit;
@end

NS_ASSUME_NONNULL_END
