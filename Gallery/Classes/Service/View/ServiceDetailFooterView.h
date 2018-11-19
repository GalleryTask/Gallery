//
//  ServiceDetailFooterView.h
//  Gallery
//
//  Created by admin on 2018/11/19.
//  Copyright © 2018 安东. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@protocol ServiceDetailFooterDelegate <NSObject>

//条框前面选择框点击事件
-(void)ServiceDetailFooterSelect:(BOOL)isOn;
@end
@interface ServiceDetailFooterView : UIView

@property(weak, nonatomic) id<ServiceDetailFooterDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
