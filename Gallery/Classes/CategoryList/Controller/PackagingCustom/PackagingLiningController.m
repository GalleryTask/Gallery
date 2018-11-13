//
//  PackagingLiningController.m
//  Gallery
//
//  Created by 安东 on 13/11/2018.
//  Copyright © 2018 安东. All rights reserved.
//

#import "PackagingLiningController.h"
#import "PackagingCustomView.h"

// 方案定制内衬
@interface PackagingLiningController ()

@end

@implementation PackagingLiningController

- (void)viewDidLoad {
  [super viewDidLoad];
  
  [self.scrollView setContentSize:CGSizeMake(0, SCALE_SIZE*330)];
  
  PackagingCustomView *customOne = [[PackagingCustomView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCALE_SIZE*94)
                                                                        title:@"EPE结构（不需要EPE网套）"
                                                                   itemsArray:@[@"结构一 / 规格18g/L",@"结构二 / 规格18g/L"]
                                                            selectedItemBlock:^(id  _Nonnull sender) {
                                                              NSLog(@"%@",sender);
                                                            }];
  [self.scrollView addSubview:customOne];
  
  PackagingCustomView *customTwo = [[PackagingCustomView alloc] initWithFrame:CGRectMake(0, SCALE_SIZE*94, SCREEN_WIDTH, SCALE_SIZE*94)
                                                                        title:@"瓦楞卡纸"
                                                                   itemsArray:@[@"B楞",@"E楞"]
                                                            selectedItemBlock:^(id  _Nonnull sender) {
                                                              NSLog(@"%@",sender);
                                                            }];
  [self.scrollView addSubview:customTwo];
  
  PackagingCustomView *customThree = [[PackagingCustomView alloc] initWithFrame:CGRectMake(0, SCALE_SIZE*188, SCREEN_WIDTH, SCALE_SIZE*94)
                                                                        title:@"吸塑托"
                                                                   itemsArray:@[@"PET",@"PP"]
                                                            selectedItemBlock:^(id  _Nonnull sender) {
                                                              NSLog(@"%@",sender);
                                                            }];
  [self.scrollView addSubview:customThree];
}


@end
