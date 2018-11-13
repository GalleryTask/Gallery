//
//  PackagingPalletController.m
//  Gallery
//
//  Created by 安东 on 13/11/2018.
//  Copyright © 2018 安东. All rights reserved.
//

#import "PackagingPalletController.h"
#import "PackagingCustomView.h"

// 方案定制托盘
@interface PackagingPalletController ()

@end

@implementation PackagingPalletController

- (void)viewDidLoad {
    [super viewDidLoad];
  
  [self.scrollView setContentSize:CGSizeMake(0, SCALE_SIZE*206)];
  
  PackagingCustomView *customOne = [[PackagingCustomView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCALE_SIZE*94)
                                                                         title:@"标准"
                                                                    itemsArray:@[@"国际",@"欧标"]
                                                             selectedItemBlock:^(id  _Nonnull sender) {
                                                               NSLog(@"%@",sender);
                                                             }];
  [self.scrollView addSubview:customOne];
  
  PackagingCustomView *customTwo = [[PackagingCustomView alloc] initWithFrame:CGRectMake(0, SCALE_SIZE*94, SCREEN_WIDTH, SCALE_SIZE*94)
                                                                        title:@"托盘"
                                                                   itemsArray:@[@"塑料托盘",@"金属托盘",@"吸塑托盘",@"泡沫托盘"]
                                                            selectedItemBlock:^(id  _Nonnull sender) {
                                                              NSLog(@"%@",sender);
                                                            }];
  [self.scrollView addSubview:customTwo];
  

}

- (void)viewDidLayoutSubviews {
  [super viewDidLayoutSubviews];
  
}
@end
