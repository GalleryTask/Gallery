//
//  AddressEditView.h
//  Gallery
//
//  Created by admin on 2018/11/16.
//  Copyright © 2018 安东. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@protocol AddressEditDelegate <NSObject>
//地址类型的代理
-(void)addressEditType:(NSString *)typeString;
//是否设置默认地址
-(void)addressEditDefaultSwitch:(BOOL)isOn;

@end
@interface AddressEditView : UIView

@property (strong, nonatomic) UITextField        *nameTextField;//收货人
@property (strong, nonatomic) UITextField        *phoneTextField;//手机账号
@property (strong, nonatomic) UIButton           *cityBtn;//所造城市
@property (strong, nonatomic) UITextField        *addressTextField;//收货地址
@property (strong, nonatomic) UITextField        *detailAddressField;//门牌号

@property (weak,   nonatomic) id <AddressEditDelegate> delegate;
@end

NS_ASSUME_NONNULL_END
