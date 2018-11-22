//
//  BaseNavigationController.m
//  NBox
//
//  Created by 安东 on 2018/9/4.
//  Copyright © 2018年 安东. All rights reserved.
//

#import "BaseNavigationController.h"

@interface BaseNavigationController () <UIGestureRecognizerDelegate>

@property (nonatomic,   copy) leftNavigationClickBlock  leftNavBlock;        // 左边标题栏block
@property (nonatomic,   copy) rightNavigationClickBlock rightNavBlock;       // 右边标题栏block
@property (nonatomic, strong) UIBarButtonItem   *leftBtnItem;

@end

@implementation BaseNavigationController


//APP生命周期中 只会执行一次
+ (void)initialize {
  // appearance方法返回一个导航栏的外观对象
  UINavigationBar *navigationBar = [UINavigationBar appearance];
  
  // 设置navigationBar上title的颜色与字体
  NSMutableDictionary *dict = [NSMutableDictionary dictionary];
  [dict setObject:BASECOLOR_BLACK_333 forKey:NSForegroundColorAttributeName];
  [dict setObject:[UIFont systemFontOfSize:18.f weight:UIFontWeightBold] forKey:NSFontAttributeName];
  navigationBar.titleTextAttributes = dict;
  
  // 去掉navigation bar 上的分割线
  [navigationBar setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];
  [navigationBar setShadowImage:[[UIImage alloc] init]];
  // 不透明
  navigationBar.translucent = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];

  // 设全屏启动右滑返回手势
  id target = self.interactivePopGestureRecognizer.delegate;
  SEL handler = NSSelectorFromString(@"handleNavigationTransition:");
  // 获取添加系统边缘触发手势的View
  UIView *targetView = self.interactivePopGestureRecognizer.view;
  // 创建pan手势 作用范围是全屏
  UIPanGestureRecognizer *fullScreenGes = [[UIPanGestureRecognizer alloc]initWithTarget:target action:handler];
  fullScreenGes.delegate = self;
  [targetView addGestureRecognizer:fullScreenGes];
  // 关闭边缘触发手势 防止和原有边缘手势冲突（也可不用关闭）
  [self.interactivePopGestureRecognizer setEnabled:NO];

  @weakify(self);
  if ([self respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
    @strongify(self);
    self.interactivePopGestureRecognizer.delegate = (id)self;
  }
}

#pragma mark - UIGestureRecognizerDelegate
// 这个方法是在手势将要激活前调用：返回YES允许右滑手势的激活，返回NO不允许右滑手势的激活
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
  // 根视图禁用右滑
  if (self.childViewControllers.count == 1) {
    return NO;
  }
  if (gestureRecognizer == self.interactivePopGestureRecognizer) {
    // 屏蔽调用rootViewController的滑动返回手势，避免右滑返回手势引起死机问题
    if (self.viewControllers.count < 2 ||
        self.visibleViewController == [self.viewControllers objectAtIndex:0]) {
      return NO;
    }
  }
  return YES;
}

// push时隐藏tabbar
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
  if (self.viewControllers.count > 0) {
    viewController.hidesBottomBarWhenPushed = YES;
    viewController.navigationItem.leftBarButtonItem = self.leftBtnItem;
  }
  [super pushViewController:viewController animated:animated];
}


#pragma mark 导航控制器的子控制器被pop[移除]的时候会调用
-(UIViewController *)popViewControllerAnimated:(BOOL)animated {

  return [super popViewControllerAnimated:animated];
}

#pragma mark - navigationBar button click
- (void)showLeftNavBtnWithClick:(leftNavigationClickBlock)leftClickBlock {

  [CommonUtil getCurrentVC].navigationItem.leftBarButtonItem = self.leftBtnItem;
  self.leftNavBlock = leftClickBlock;
}

- (void)backBtnClick:(UIButton *)backBtn {
  if (self.leftNavBlock) {
    self.leftNavBlock(backBtn);
    self.leftNavBlock = nil;
  } else {
    if (self.viewControllers.count > 1 && self.topViewController == [CommonUtil getCurrentVC]) {
      // push
      [self popViewControllerAnimated:YES];
    } else {
      // present方式
      [[CommonUtil getCurrentVC] dismissViewControllerAnimated:YES completion:nil];
    }
  }
}

- (void)rightNavigationBtnClick:(UIButton *)rightNavigationBtn {
  if (self.rightNavBlock) {
    self.rightNavBlock(rightNavigationBtn);
  }
}

#pragma mark - navigation right button 展示样式
-(void)setNavigationBarRightItemWithImageName:(NSString *)imageName
                           highlightImageName:(NSString *)highlightImageName
                                   clickBlock:(rightNavigationClickBlock)block {
  self.rightNavBlock = block;
  UIButton *button = [self rightBtn];
  [button setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
  [button setImage:[UIImage imageNamed:highlightImageName] forState:UIControlStateHighlighted];
  UIBarButtonItem *rightBtnItem = [[UIBarButtonItem alloc] initWithCustomView:button];
  [CommonUtil getCurrentVC].navigationItem.rightBarButtonItem = rightBtnItem;
}

-(void)setNavigationBarRightItemWithButtonTitle:(NSString *)title clickBlock:(rightNavigationClickBlock)block {
  self.rightNavBlock = block;
  UIButton *button = [self rightBtn];
  [button setTitle:title forState:UIControlStateNormal];
  UIBarButtonItem *rightBtnItem = [[UIBarButtonItem alloc] initWithCustomView:button];
  [CommonUtil getCurrentVC].navigationItem.rightBarButtonItem = rightBtnItem;
}

- (UIButton *)rightBtn {
  UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
  [button setFrame:CGRectMake(0, 0, BASE_HEIGHT*2, BASE_HEIGHT)];
  [button setContentHorizontalAlignment:UIControlContentHorizontalAlignmentRight];
  [button addTarget:self
             action:@selector(rightNavigationBtnClick:)
   forControlEvents:UIControlEventTouchUpInside];
  [button setTitleColor:BASECOLOR_BLACK_333 forState:UIControlStateNormal];
  [[button titleLabel] setFont:FONTSIZE(14)];
  
  return button;
}

#pragma mark - getters
-(UIBarButtonItem *)leftBtnItem {
  if (!_leftBtnItem) {
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [backBtn setFrame:CGRectMake(0, 0, BASE_HEIGHT*2, BASE_HEIGHT)];
    [backBtn setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
    [backBtn setTitleColor:BASECOLOR_BLACK_333 forState:UIControlStateNormal];
    [[backBtn titleLabel] setFont:FONTSIZE(14)];
    [backBtn setImage:[UIImage imageNamed:@"nav_button_left_back_default"] forState:UIControlStateNormal];
    [backBtn setImage:[UIImage imageNamed:@"nav_button_left_back_pressed"] forState:UIControlStateHighlighted];
    [backBtn addTarget:self
                action:@selector(backBtnClick:)
      forControlEvents:UIControlEventTouchUpInside];
    _leftBtnItem = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
  }
  
  return _leftBtnItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
