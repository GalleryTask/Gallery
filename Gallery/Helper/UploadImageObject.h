//
//  UploadImageObject.h
//  Tourmaline
//
//  Created by previz on 16/8/8.
//  Copyright © 2016年 dongan. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^UploadImageBlock)(UIImage *image);

@interface UploadImageObject : UIView <UIImagePickerControllerDelegate, UINavigationControllerDelegate>

/**
 选择照片或拍照

 @param controller 当前controller
 @param block 返回image
 */
- (void)uploadImageWithController:(UIViewController *)controller Block:(UploadImageBlock)block;

@end
