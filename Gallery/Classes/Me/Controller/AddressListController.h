//
//  AddressListController.h
//  Gallery
//
//  Created by admin on 2018/11/15.
//  Copyright © 2018 安东. All rights reserved.
//

#import "BaseViewController.h"

@protocol  AddressListControllerDelegate  <NSObject>

- (void)addressListSelectedWithAddress:(NSDictionary *)address;

@end

@interface AddressListController : BaseViewController

@property (nonatomic, weak) id <AddressListControllerDelegate> delegate;

@end


