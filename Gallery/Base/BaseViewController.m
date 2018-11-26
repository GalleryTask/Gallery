//
//  BaseViewController.m
//  Tourmaline
//
//  Created by 安东 on 2017/2/20.
//  Copyright © 2017年 安东. All rights reserved.
//

#import "BaseViewController.h"
#import "MBProgressHUD.h"

@interface BaseViewController () <UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate>

@property (nonatomic,   copy) headerRefreshingBlock     headerBlock;         // 头部刷新block
@property (nonatomic,   copy) footerRefreshingBlock     footerBlock;         // 尾部加载block
@property (nonatomic, strong) MBProgressHUD             *hud;                // 提示框

@end

@implementation BaseViewController


- (void)viewDidLoad {
  [super viewDidLoad];

  // 设置默认的背景颜色为白色
  [self.view setBackgroundColor:[UIColor whiteColor]];
}
-(void)viewWillAppear:(BOOL)animated {
  [super viewWillAppear:animated];
  [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
}

#pragma mark tableview delegate
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  
  UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
  return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  
  return 0;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
  
  [tableView deselectRowAtIndexPath:indexPath animated:YES];
}


#pragma mark - 刷新
- (void)tableViewHeaderRefreshWithTableView:(UIScrollView *)tableView
                           headerClickBlock:(headerRefreshingBlock)block {
  MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingTarget:self
                                                                   refreshingAction:@selector(headerRefreshing)];
  header.stateLabel.textColor = BASECOLOR_BLACK;
  header.stateLabel.font = FONTSIZE(14);
  header.lastUpdatedTimeLabel.hidden = YES;
  [header setTitle:@"下拉刷新" forState:MJRefreshStateIdle];
  [header setTitle:@"释放更新" forState:MJRefreshStatePulling];
  [header setTitle:@"加载中 ..." forState:MJRefreshStateRefreshing];
  tableView.mj_header = header;
  self.headerBlock = block;
}

#pragma mark - 加载
- (void)tableViewFooterRefreshWithTableView:(UIScrollView *)tableView
                           footerClickBlock:(footerRefreshingBlock)block {
  MJRefreshBackNormalFooter *footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self
                                                                           refreshingAction:@selector(footerRefreshing)];
  footer.stateLabel.textColor = BASECOLOR_BLACK;
  footer.stateLabel.font = FONTSIZE(14);
  [footer setTitle:@"上拉刷新" forState:MJRefreshStateIdle];
  [footer setTitle:@"释放更新" forState:MJRefreshStatePulling];
  [footer setTitle:@"加载中 ..." forState:MJRefreshStateRefreshing];
  [footer setTitle:@"没有更多数据" forState:MJRefreshStateNoMoreData];
  tableView.mj_footer = footer;
  self.footerBlock = block;
}

#pragma mark 刷新
- (void)headerRefreshing {
  self.headerBlock();
}

#pragma mark - 加载
- (void)footerRefreshing {
  self.footerBlock();
}

#pragma mark - tableview 停止刷新
- (void)tableViewEndRefreshingWithNewCount:(NSInteger)count {
  [self.tableView.mj_header endRefreshing];
  if (count == 0) {
    [self.tableView.mj_footer endRefreshingWithNoMoreData];
  } else {
    [self.tableView.mj_footer endRefreshing];
  }
}

#pragma mark - 创建tableview  tableview懒加载
- (UITableView *)tableView {
  if (!_tableView) {
    _tableView = [[UITableView alloc] init];
    [_tableView setDelegate:self];
    [_tableView setDataSource:self];
    [_tableView setTableFooterView:[[UIView alloc] init]];
    [_tableView setShowsVerticalScrollIndicator:NO];
//    [_tableView setBackgroundColor:BASECOLOR_BACKGROUND_GRAY];
    [_tableView setRowHeight:0];
    [_tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    [self.view addSubview:_tableView];
    
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
      make.edges.equalTo(self.view);
    }];
    // 适配iOS11 iPhone X
    AdjustsScrollViewInsetNever(self, _tableView);
    
  }
  return _tableView;
}

#pragma mark - MBProgressHUD提示
- (void)promptHudViewWithText:(NSString *)text isHidden:(BOOL)isHidden {
  self.hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
  if (text) {
    self.hud.mode = MBProgressHUDModeText;
    self.hud.label.text = text;
    self.hud.label.textColor = BASECOLOR_BLACK_333;
    self.hud.label.font = FONTSIZE_LIGHT(14);
    
  } else {
    self.hud.mode = MBProgressHUDModeIndeterminate;
  }
  // 设置背景透明度
  self.hud.bezelView.style = MBProgressHUDBackgroundStyleSolidColor;
  self.hud.bezelView.color = [BASECOLOR_GRAY_E9 colorWithAlphaComponent:0.9];
  
  self.hud.bezelView.layer.cornerRadius = 5;
  
  // 显示、隐藏动画样式
  self.hud.animationType = MBProgressHUDAnimationZoomOut;
  // HUD的相对于父视图 x 的偏移，默认居中
  self.hud.offset = CGPointMake(0.f, 0.f);
  // HUD内部视图相对于HUD的边距
  self.hud.margin = 16;

//  self.hud.bezelView.
  isHidden ? [self.hud hideAnimated:YES afterDelay:1.f] :nil;
}

- (void)promptHudViewHide {
  [self.hud hideAnimated:YES];
}

#pragma mark - getters and setters
- (NSMutableArray *)dataSource {
  if (!_dataSource) {
    _dataSource = [NSMutableArray array];
  }
  return _dataSource;
}

- (DataRequest *)dataRequest {
  if (!_dataRequest) {
    _dataRequest = [[DataRequest alloc] init];
  }
  return _dataRequest;
}

-(UserInfoSingleton *)userInfo {
  if (!_userInfo) {
    _userInfo = [UserInfoSingleton shareData];
  }
  return _userInfo;
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
