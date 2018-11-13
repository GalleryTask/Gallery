//
//  PackagingCustomView.h
//  Gallery
//
//  Created by 安东 on 13/11/2018.
//  Copyright © 2018 安东. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void (^PackagingSelectedItemBlock)(id sender);

@interface PackagingCustomView : UIView

- (instancetype)initWithFrame:(CGRect)frame
                        title:(NSString *)title
                   itemsArray:(NSArray *)items
            selectedItemBlock:(PackagingSelectedItemBlock)block;

@end

NS_ASSUME_NONNULL_END
