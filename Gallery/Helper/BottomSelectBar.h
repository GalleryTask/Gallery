//
//  BottomSelectBar.h
//  Gallery
//
//  Created by 安东 on 16/11/2018.
//  Copyright © 2018 安东. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol  BottomSelectBarDelegate  <NSObject>

@optional
- (void)bottomBarWithLeftBtnClick:(id)sender;
- (void)bottomBarWithRightBtnClick:(id)sender;

@end

@interface BottomSelectBar : UIView

@property (nonatomic, weak) id <BottomSelectBarDelegate> delegate;
-(instancetype)initWithLeftTitle:(NSString *)leftTitle rightTitle:(NSString *)rightTitle delegate:(id <BottomSelectBarDelegate>)delegate;

@end

NS_ASSUME_NONNULL_END
