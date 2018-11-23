//
//  SettleView.h
//  Gallery
//
//  Created by 安东 on 23/11/2018.
//  Copyright © 2018 安东. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol  SettleViewDelegate  <NSObject>

- (void)settleViewAllSelectedBtnClickWithSelected:(BOOL)selected;

@end

@interface SettleView : UIView

@property (nonatomic, weak) id <SettleViewDelegate> delegate;

- (void)settleViewWithSettleCount:(int)count;

@end

NS_ASSUME_NONNULL_END
