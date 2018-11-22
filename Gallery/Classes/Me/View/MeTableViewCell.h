//
//  MeTableViewCell.h
//  Gallery
//
//  Created by admin on 2018/11/22.
//  Copyright © 2018 安东. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@protocol MeTableViewCellDelegate <NSObject>

-(void)meCellButtonIndex:(NSInteger)index;

@end
@interface MeTableViewCell : UITableViewCell

@property (nonatomic, weak)   id <MeTableViewCellDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
