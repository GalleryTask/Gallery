//
//  CategoryDetailSlideController.m
//  Gallery
//
//  Created by admin on 2018/11/9.
//  Copyright © 2018 安东. All rights reserved.
//

#import "CategoryDetailSlideController.h"
#import "XLSlideSwitch.h"
#import "CategoryDetailController.h"
@interface CategoryDetailSlideController ()<XLSlideSwitchDelegate>
@property (nonatomic, strong) NSArray  *titleArray;  // 商品列表数据源
@property(nonatomic, strong)XLSlideSwitch *slideSwitch;
@end

@implementation CategoryDetailSlideController

- (void)viewDidLoad {
    [super viewDidLoad];

  self.titleArray = @[@"美妆护理",@"数码3C",@"水果农特",@"医药保健",@"服装",@"酒水饮料",@"日化家纺",
                      @"家具",@"家用电器",@"玩具饰品",@"家装五金",@"日化家纺",@"工业防护",@"工业防护",
                      @"鞋袜箱包",@"鞋袜箱包",@"文化体育",@"仓储物流",@"汽车用品"];
  [self.view addSubview:self.slideSwitch];
}


#pragma mark -
#pragma mark SlideSwitchDelegate

- (void)slideSwitchDidselectAtIndex:(NSInteger)index {
  NSLog(@"切换到了第 -- %zd -- 个视图",index);
}
-(XLSlideSwitch *)slideSwitch{
  if (!_slideSwitch) {
    //创建滚动视图
    NSMutableArray *viewControllers = [[NSMutableArray alloc] init];
    for (NSInteger i = 0 ; i<self.titleArray.count; i++) {
      UIViewController *vc = [self viewControllerOfIndex:i];
      [viewControllers addObject:vc];
    }
    _slideSwitch = [[XLSlideSwitch alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-NAVIGATIONBAR_HEIGHT) Titles:self.titleArray viewControllers:viewControllers];
    //设置代理
    _slideSwitch.delegate = self;
    //设置按钮选中和未选中状态的标题颜色
    _slideSwitch.itemSelectedColor = BASECOLOR_BLACK_333;
    _slideSwitch.itemNormalColor = BASECOLOR_BLACK_333;
    //标题横向间距
    _slideSwitch.customTitleSpacing = 30;
    //更多按钮
    //  _slideSwitch.moreButton = [self moreButton];
    //显示方法
    [_slideSwitch showInViewController:self];
  }
  return _slideSwitch;
}
- (UIViewController *)viewControllerOfIndex:(NSInteger)index {
  UIViewController *vc;
  vc = [[CategoryDetailController alloc] init];
  return vc;
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
