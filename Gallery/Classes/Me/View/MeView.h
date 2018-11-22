//
//  MeView.h
//  Gallery
//
//  Created by admin on 2018/11/22.
//  Copyright © 2018 安东. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@protocol meViewDelegate <NSObject>

-(void)meViewHeadButtonClick;


@end
@interface MeView : UIView

@property (nonatomic, weak)   id <meViewDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
