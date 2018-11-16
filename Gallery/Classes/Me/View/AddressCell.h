//
//  AddressCell.h
//  Gallery
//
//  Created by admin on 2018/11/15.
//  Copyright © 2018 安东. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol AddressCellDelegate <NSObject>

-(void)addressCelleditBtnClick;

@end
@interface AddressCell : UITableViewCell

@property (nonatomic, weak)   id <AddressCellDelegate> delegate;
@end

NS_ASSUME_NONNULL_END
