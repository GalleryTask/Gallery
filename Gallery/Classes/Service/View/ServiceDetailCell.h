//
//  ServiceDetailCell.h
//  Gallery
//
//  Created by admin on 2018/11/16.
//  Copyright © 2018 安东. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ServiceDetailCell : UITableViewCell

@property(nonatomic, strong)NSString *titleString;
@property(nonatomic, strong)NSString *detailString;
@property(nonatomic, strong)NSString *lastString;
@property(nonatomic, strong)UIView   *lineView;
@end

NS_ASSUME_NONNULL_END
