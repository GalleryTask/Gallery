//
//  QuoteViewController.m
//  Gallery
//
//  Created by 安东 on 2018/9/19.
//  Copyright © 2018年 安东. All rights reserved.
//

#import "QuoteViewController.h"
#import "MateriaIInformationViewController.h"

@interface QuoteViewController ()

@property (nonatomic, copy) NSString  *titleString;
@end

@implementation QuoteViewController

- (void)viewDidLoad {
    [super viewDidLoad];

  self.title = [NSString stringWithFormat:@"%@报价",self.titleString] ;
  
  BaseNavigationController *navController = (BaseNavigationController *)self.navigationController;
  [navController setNavigationBarRightItemWithButtonTitle:@"配材"];
  [navController showRightNavBtnWithClick:^(id sender) {
    MateriaIInformationViewController *materiaVC = [[MateriaIInformationViewController alloc] init];
    [self.navigationController pushViewController:materiaVC animated:YES];
  }];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
