//
//  ServiceDetailController.m
//  Gallery
//
//  Created by admin on 2018/11/16.
//  Copyright © 2018 安东. All rights reserved.
//

#import "ServiceDetailController.h"
#import "ServiceDetailCell.h"
@interface ServiceDetailController ()

@property(nonatomic, strong)UIView *headderView;
@property(nonatomic, strong)NSArray *titleArray;
@property(nonatomic, strong)NSArray *detailArray;
@end

@implementation ServiceDetailController

- (void)viewDidLoad {
  [super viewDidLoad];
  self.title = @"定制服务明细";
  [self createInterfaceBuilder];
}
-(void)createInterfaceBuilder {
  
  self.titleArray = @[@"内容物",@"包装使用方向",@"期望包装价格范围",@"内容物尺寸",@"内容物规格",@"是否需要标签",@"是否需要托盘"];
  self.detailArray = @[@"苹果",@"礼盒包装",@"2～5元",@"直径100mm",@"5个装",@"是",@"是"];
  
  [self.tableView setBackgroundColor:BASECOLOR_BACKGROUND_GRAY];
  [self.tableView registerClass:[ServiceDetailCell class] forCellReuseIdentifier:@"ServiceDetailCell"];
  [self.tableView setContentInset:UIEdgeInsetsMake(0, 0, 0, 0)];
  self.tableView.separatorStyle =UITableViewCellSeparatorStyleNone;
}
#pragma mark - tableview delegate dataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
  return 3;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  if (section == 1) {
    return self.titleArray.count;
  }else if (section == 2){
    return 3;
  }else{
    return 1;
  }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  ServiceDetailCell *serviceCell = [tableView dequeueReusableCellWithIdentifier:@"ServiceDetailCell" forIndexPath:indexPath];
  serviceCell.selectionStyle = UITableViewCellSelectionStyleNone;
  
  if (indexPath.section == 1) {
    [serviceCell setTitleString:self.titleArray[indexPath.row]];
    [serviceCell setDetailString:self.detailArray[indexPath.row]];
    if (indexPath.row == 6) {
      [serviceCell setLastString:@"1"];
    }else{
      [serviceCell setLastString:@"0"];
    }
  }else if(indexPath.section == 2){
    if (indexPath.row == 0) {
      [serviceCell setLastString:@"0"];
      [serviceCell setTitleString:@"产品包装方案样品"];
      [serviceCell setDetailString:@"1套"];
    }else if (indexPath.row == 1){
      [serviceCell setLastString:@"1"];
      [serviceCell setTitleString:@"物流包装方案样品"];
      [serviceCell setDetailString:@"1套"];
    }else{
      [serviceCell.lineView setHidden:NO];
      [serviceCell setLastString:@"2"];
      [serviceCell setTitleString:@"服务价格"];
      [serviceCell setDetailString:@"¥2000.00"];
    }
  }
  return serviceCell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
  
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
  if (indexPath.section == 0) {
    return 35;
  }else{
    if (indexPath.row == 0) {
      return SCALE_SIZE *32;
    }else if (indexPath.section == 2 && indexPath.row == 2) {
      return SCALE_SIZE * 44;
    }else if (indexPath.section == 1 && indexPath.row == 6) {
      return SCALE_SIZE * 32;
    }else if (indexPath.section == 2 && indexPath.row == 1) {
      return SCALE_SIZE * 32;
    }else{
      return SCALE_SIZE * 28;
    }
  }
  
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
  UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH,SCALE_SIZE * 56)];
  headerView.backgroundColor =BASECOLOR_BACKGROUND_GRAY;
  
  UIView *view1 = [[UIView alloc] initWithFrame:CGRectMake(0, SCALE_SIZE * 10, SCREEN_WIDTH, SCALE_SIZE * 46)];
  view1.backgroundColor = [UIColor whiteColor];
  [headerView addSubview:view1];
  
  UIView *line1 = [[UIView alloc] initWithFrame:CGRectMake(0, SCALE_SIZE * 55.5, SCREEN_WIDTH, 0.5)];;
  line1.backgroundColor = BASECOLOR_LINE;
  [headerView addSubview:line1];
  
  UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(SCALE_SIZE * 15, SCALE_SIZE * 15, SCREEN_WIDTH, SCALE_SIZE * 16)];
  titleLabel.font = [UIFont systemFontOfSize:SCALE_SIZE * 16];
  titleLabel.textColor = BASECOLOR_BLACK_333;
  [view1 addSubview:titleLabel];
  if (section == 1) {
    titleLabel.text = @"所需信息";
  }else if (section == 2){
    titleLabel.text = @"服务内容";
  }
  return headerView;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
  if (section ==0) {
    return 0;
  }else{
    return SCALE_SIZE * 56;
  }
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
