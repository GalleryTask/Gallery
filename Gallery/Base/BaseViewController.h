//
//  BaseViewController.h
//  Tourmaline
//
//  Created by 安东 on 2017/2/20.
//  Copyright © 2017年 安东. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MJRefresh.h"

@class DataRequest;
@class UserInfoSingleton;
@class TableViewDataSource;

typedef void (^leftNavigationClickBlock)(id sender);
typedef void (^rightNavigationClickBlock)(id sender);
typedef void (^headerRefreshingBlock)(void);
typedef void (^footerRefreshingBlock)(void);

typedef NS_ENUM(NSUInteger,DataStatus) {
  dataFail         = -1,  // 获取数据失败
  dataEmpty        =  0,  // 数据为空
};

/**
 父类controller 所有controller都继承与此controller
 */
@interface BaseViewController : UIViewController


/**
 数据源
 */
@property (nonatomic, strong) NSMutableArray     *dataSource;

/**
 数据请求
 */
@property (nonatomic, strong) DataRequest        *dataRequest;

/**
 单例
 */
@property (nonatomic, strong) UserInfoSingleton  *userInfo;


@property (nonatomic, strong) TableViewDataSource *tbDataSource;
/**
 表示图
 */
@property (nonatomic, strong) UITableView    *tableView;


/**
 navigation left button
 */
@property (nonatomic, strong) UIButton      *leftNavigationBtn;

/**
 navigation right button
 */
@property (nonatomic, strong) UIButton      *rightNavigationBtn;



/**
 显示navigation left button

 @param leftClickBlock left button click block
 */
- (void)showLeftNavBtnWithClick:(leftNavigationClickBlock)leftClickBlock;


/**
 显示navigation right button

 @param rightClickBlock right button click block
 */
- (void)showRightNavBtnWithClick:(rightNavigationClickBlock)rightClickBlock;


/**
 刷新

 @param tableView 需要刷新的控件 tableview collectionview
 @param block 刷新回调
 */
- (void)tableViewHeaderRefreshWithTableView:(UIScrollView *)tableView
                           headerClickBlock:(headerRefreshingBlock)block;

/**
 加载

 @param tableView 需要刷新的控件 tableview collectionview
 @param block 加载回调
 */
- (void)tableViewFooterRefreshWithTableView:(UIScrollView *)tableView
                           footerClickBlock:(footerRefreshingBlock)block;


/**
 停止刷新

 @param count 新请求的数据个数
 */
- (void)tableViewEndRefreshingWithNewCount:(NSInteger)count;

/**
 提示
 
 @param text 文字
 @param isHidden 显示完是否隐藏
 */
- (void) promptHudViewWithText:(NSString *)text isHidden:(BOOL)isHidden;

/**
 隐藏提示
 */
- (void)promptHudViewHide;

@end
