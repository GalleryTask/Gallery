//
//  ProductsViewController.m
//  Gallery
//
//  Created by 安东 on 06/11/2018.
//  Copyright © 2018 安东. All rights reserved.
//

#import "ProductsViewController.h"

@interface ProductsViewController ()

@end

@implementation ProductsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
  [self.view setFrame:CGRectMake(SCREEN_WIDTH*0.2, 0, SCREEN_WIDTH*0.8, SCREEN_HEIGHT)];
//  [self.view setBackgroundColor:BASECOLOR_LIGHTGRAY];

}

#pragma mark - 一级tableView滚动时 实现当前类tableView的联动
- (void)scrollToSelectedIndexPath:(NSIndexPath *)indexPath {
  
//  [self.tableView selectRowAtIndexPath:([NSIndexPath indexPathForRow:0 inSection:indexPath.row])
//                              animated:YES
//                        scrollPosition:UITableViewScrollPositionTop];
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
