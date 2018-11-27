//
//  UploadImageObject.m
//  Tourmaline
//
//  Created by previz on 16/8/8.
//  Copyright © 2016年 dongan. All rights reserved.
//


#import "UploadImageObject.h"
#import <AVFoundation/AVFoundation.h>

@interface UploadImageObject() <UIAlertViewDelegate>

@property (nonatomic, copy) UploadImageBlock        imageBlock;
@property (nonatomic, strong) UIViewController      *myController;
@property (nonatomic, copy) UIImagePickerController *imagePicker;
@property (nonatomic, strong) UIAlertController     *alertVC;

@end

@implementation UploadImageObject


- (void)uploadImageWithController:(UIViewController *)controller Block:(UploadImageBlock)block {
  
  self.myController = controller;
  [self.myController.view addSubview:self];
  self.imageBlock = block;
  
  [self.myController presentViewController:self.alertVC animated:YES completion:nil];
}



- (void)actionSheetClickAtIndex:(NSInteger)index {
  
  switch (index) {
    case 0:
      // 相册上传
      self.imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
      break;
    case 1:
      // 拍照
    {
      NSString *mediaType = AVMediaTypeVideo;//读取媒体类型
      AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:mediaType];//读取设备授权状态
      if(authStatus == AVAuthorizationStatusRestricted || authStatus == AVAuthorizationStatusDenied) {
        NSString *errorStr = @"应用相机权限受限,请在设置中启用";
        [CommonUtil promptViewWithText:errorStr view:ROOTVIEWCONTROLLER.view hidden:YES];
        return;
      } else {
        if ([self isCameraAvailable]) {
          self.imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
        }
      }
    }
      break;
      
    default:
      [self removeFromSuperview];
      break;
  }
}


#pragma mark-
#pragma mark imagepicker Delegate
// 选中照片
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
  
  NSString *type = [info objectForKey:UIImagePickerControllerMediaType];
  
  // 当选择的类型是图片
  if ([type isEqualToString:@"public.image"]) {
    
    UIImage *image = [info objectForKey:UIImagePickerControllerEditedImage];
    
    // 关闭相册界面
    [picker dismissViewControllerAnimated:YES completion:NULL];
    self.imageBlock(image);
    picker.delegate = nil;
    self.imagePicker = nil;
    [self removeFromSuperview];
  }
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
  [picker dismissViewControllerAnimated:YES completion:NULL];
  picker.delegate = nil;
  picker = nil;
}

// 判断设备是否有摄像头
- (BOOL)isCameraAvailable {
  return [UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera];
}


#pragma mark - setters and getters
- (UIImagePickerController *)imagePicker {
  if (!_imagePicker) {
    _imagePicker = [[UIImagePickerController alloc] init];
    [_imagePicker setDelegate:self];
    [_imagePicker setAllowsEditing:YES];
    UIImagePickerControllerSourceType type = [self isCameraAvailable] ?
           UIImagePickerControllerSourceTypeCamera : UIImagePickerControllerSourceTypePhotoLibrary;
    _imagePicker.sourceType = type;
    [self.myController presentViewController:_imagePicker animated:YES completion:nil];
  }
  return _imagePicker;
}


-(UIAlertController *)alertVC {
  if (!_alertVC) {
    @weakify(self);
    _alertVC = [[UIAlertController alloc] init];
    UIAlertAction *seriveOnline = [UIAlertAction actionWithTitle:@"相册上传"
                                                           style:UIAlertActionStyleDefault
                                                         handler:^(UIAlertAction * _Nonnull action) {
                                                           @strongify(self);
                                                           [self actionSheetClickAtIndex:0];
                                                         }];
    UIAlertAction *serivePhone = [UIAlertAction actionWithTitle:@"拍照"
                                                          style:UIAlertActionStyleDefault
                                                        handler:^(UIAlertAction * _Nonnull action) {
                                                          @strongify(self);
                                                          [self actionSheetClickAtIndex:1];
                                                        }];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消"
                                                           style:UIAlertActionStyleCancel
                                                         handler:^(UIAlertAction * _Nonnull action) {
                                                           @strongify(self);
                                                           [self actionSheetClickAtIndex:2];
                                                         }];
    [_alertVC addAction:seriveOnline];
    [_alertVC addAction:serivePhone];
    [_alertVC addAction:cancelAction];
  }
  return _alertVC;
}

@end
