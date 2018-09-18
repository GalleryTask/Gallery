//
//  TabBarController.m
//  YSD_SaaS
//
//  Created by 安东 on 2018/9/7.
//  Copyright © 2018年 安东. All rights reserved.
//

#import "TabBarController.h"

@interface TabBarController () <UITabBarControllerDelegate>

@end

@implementation TabBarController

- (void)viewDidLoad {
  [super viewDidLoad];
  // 设代理为自己
  [self setDelegate:self];
  // 设置默认文字的颜色
  [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary
                                                     dictionaryWithObjectsAndKeys: BASECOLOR_BLACK,
                                                     NSForegroundColorAttributeName, nil]
                                           forState:UIControlStateNormal];
  // 设置选中文字的颜色
  [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary
                                                     dictionaryWithObjectsAndKeys: BASECOLOR_BLUE,
                                                     NSForegroundColorAttributeName, nil]
                                           forState:UIControlStateSelected];
  
  // 从本地文件读出item信息
  NSDictionary *dic = [[[NSDictionary alloc] initWithContentsOfFile:
                        [[NSBundle mainBundle] pathForResource:@"DataList.plist"ofType:nil]]
                       objectForKey:@"TabBarDic"] ;
  
  NSArray *controllers = dic[@"controllers"];
  
  // 遍历数组获取到每一个controller 并为其item赋值
  for (int i = 0; i < controllers.count ; i++) {
    Class class = NSClassFromString(controllers[i]);
    UIViewController *controller = class.new;
    
    
    UITabBarItem *tabBarItem  = [[UITabBarItem alloc] init];
    
    // 设置items选中图片
    tabBarItem.selectedImage = [[UIImage imageNamed:dic[@"tabBarSelectedImg"][i]]
                             imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    // 设置items默认图片
    tabBarItem.image = [[UIImage imageNamed:dic[@"tabBarDefaultImg"][i]]
                     imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    // 设置items图片和文字的距离
    tabBarItem.titlePositionAdjustment = UIOffsetMake([dic[@"positionX"][i] intValue], -3);
    // 设置items的文字
    tabBarItem.title = dic[@"titles"][i];

    [controller setTabBarItem:tabBarItem];
    
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:controller];
    [self addChildViewController:nav];
  }
}

- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController {
  
//  if (viewController == tabBarController.viewControllers[2]) {
//    PlaceOrderController *vc = [[PlaceOrderController alloc] init];
//    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
//    [self presentViewController:nav animated:YES completion:nil];
//    return NO;
//  }
  return YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
