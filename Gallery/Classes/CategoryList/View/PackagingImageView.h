//
//  PackagingImageView.h
//  Gallery
//
//  Created by 安东 on 15/11/2018.
//  Copyright © 2018 安东. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface PackagingImageView : UIView

- (instancetype)initWithFrame:(CGRect)frame
                       images:(NSArray *)images
                       titles:(NSArray *)titles
                isUploadImage:(BOOL)isUpload;

@end

NS_ASSUME_NONNULL_END
