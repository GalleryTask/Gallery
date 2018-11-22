//
//  MeOrderTableViewCell.h
//  Gallery
//
//  Created by admin on 2018/11/22.
//  Copyright © 2018 安东. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@protocol MeOrderTableViewCellDelegate <NSObject>

-(void)orderButtonIndex:(NSInteger)index;
-(void)meLogisticsClick;
@end
@interface MeOrderTableViewCell : UITableViewCell

@property (nonatomic, weak)   id <MeOrderTableViewCellDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
