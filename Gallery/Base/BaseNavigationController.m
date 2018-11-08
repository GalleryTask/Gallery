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
@property (nonatomic, strong) UIViewController  *myController;
@property (nonatomic, strong) UIBarButtonItem   *leftBtnItem;
@property (nonatomic, strong) UIButton          *rightNavigationBtn;

@end

@implementation BaseNavigationController


+ (void)load {
  [super load];
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
  
  if (gestureRecognizer == self.interactivePopGestureRecognizer) {
    // 屏蔽调用rootViewController的滑动返回手势，避免右滑返回手势引起死机问题
    if (self.viewControllers.count < 2 ||
        self.visibleViewController == [self.viewControllers objectAtIndex:0]) {
      return NO;
    }
  }
  return YES;
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
  if (self.viewControllers.count > 0) {
    viewController.hidesBottomBarWhenPushed = YES;
    viewController.navigationItem.leftBarButtonItem = self.leftBtnItem;
    self.myController = viewController;
  }
  [super pushViewController:viewController animated:animated];
}


#pragma mark - navigationBar button click
- (void)showLeftNavBtnWithClick:(leftNavigationClickBlock)leftClickBlock {

  self.leftNavBlock = leftClickBlock;
}

- (void)showRightNavBtnWithClick:(rightNavigationClickBlock)rightClickBlock {
  [self rightNavigationBtn];
  self.rightNavBlock = rightClickBlock;
}


- (void)backBtnClick:(UIButton *)backBtn {
  if (self.leftNavBlock) {
    self.leftNavBlock(backBtn);
    self.leftNavBlock = nil;
  } else {
    [self popViewControllerAnimated:YES];
  }
}

- (void)rightNavigationBtnClick:(UIButton *)rightNavigationBtn {
  if (self.rightNavBlock) {
    self.rightNavBlock(rightNavigationBtn);
  }
}

#pragma mark - navigation right button 展示样式
-(void)setNavigationBarRightItemWithImageName:(NSString *)imageName
                           highlightImageName:(NSString *)highlightImageName {
  
  [self.rightNavigationBtn setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
  [self.rightNavigationBtn setImage:[UIImage imageNamed:highlightImageName] forState:UIControlStateHighlighted];
}

-(void)setNavigationBarRightItemWithButtonTitle:(NSString *)title {
  
  [self.rightNavigationBtn setTitle:title forState:UIControlStateNormal];
}

#pragma mark - getters
-(UIBarButtonItem *)leftBtnItem {
  if (!_leftBtnItem) {
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [backBtn setFrame:CGRectMake(0, 0, BASE_HEIGHT*2, BASE_HEIGHT)];
    [backBtn setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
    [backBtn setTitleColor:BASECOLOR_BLACK forState:UIControlStateNormal];
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

-(UIButton *)rightNavigationBtn {
  if (!_rightNavigationBtn) {
    _rightNavigationBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_rightNavigationBtn setFrame:CGRectMake(0, 0, BASE_HEIGHT*2, BASE_HEIGHT)];
    [_rightNavigationBtn setContentHorizontalAlignment:UIControlContentHorizontalAlignmentRight];
    [_rightNavigationBtn addTarget:self
                            action:@selector(rightNavigationBtnClick:)
                  forControlEvents:UIControlEventTouchUpInside];
    [_rightNavigationBtn setTitleColor:BASECOLOR_BLACK forState:UIControlStateNormal];
    [[_rightNavigationBtn titleLabel] setFont:FONTSIZE(14)];
  }
  if (!self.myController) {
    self.myController = [CommonUtil getCurrentVC];
  }
  UIBarButtonItem *rightBtnItem = [[UIBarButtonItem alloc] initWithCustomView:_rightNavigationBtn];
  self.myController.navigationItem.rightBarButtonItem = rightBtnItem;
  return _rightNavigationBtn;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
