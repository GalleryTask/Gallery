//
//  SelectedAddressView.h
//  Gallery
//
//  Created by 安东 on 19/11/2018.
//  Copyright © 2018 安东. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol  SelectedAddressViewDelegate  <NSObject>

@optional
- (void)addressViewClick;

@end

@interface SelectedAddressView : UIView

@property (nonatomic, weak) id <SelectedAddressViewDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
