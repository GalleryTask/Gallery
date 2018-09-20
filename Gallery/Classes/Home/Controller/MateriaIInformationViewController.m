//
//  MateriaIInformationViewController.m
//  Gallery
//
//  Created by admin on 2018/9/19.
//  Copyright © 2018年 安东. All rights reserved.
//

#import "MateriaIInformationViewController.h"
#import "MaterialInformationTableViewCell.h"
#import "PickerView.h"

@interface MateriaIInformationViewController ()<UITableViewDelegate,UITableViewDataSource, PickerViewDelegate>

@property(nonatomic, strong)NSArray* sectionArray;
@property (nonatomic, strong) PickerView  *pickerView;
@end

@implementation MateriaIInformationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"配材信息";
    self.sectionArray = @[@"配材",@"面纸",@"楞纸",@"里纸"];
    
    [self.tableView registerClass:[MaterialInformationTableViewCell class] forCellReuseIdentifier:@"MaterialInformationTableViewCell"];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.sectionArray.count;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 1;
    }else if(section == 2){
        return 5;
    }else{
        return 4;
    }
    
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MaterialInformationTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MaterialInformationTableViewCell" forIndexPath:indexPath];
    if (indexPath.section == 0) {

        cell.titleStr = @"层数";
        cell.detailStr = @"三层";
    }else{
        cell.detailStr = @"";
        if (indexPath.row == 0) {
            cell.titleStr = @"类型";
            cell.placeholderStr = @"请选择类型";
        }else if (indexPath.row == 1){
            cell.titleStr = @"等级";
            cell.placeholderStr = @"请选择等级";
        }else if (indexPath.row == 2){
            cell.titleStr = @"克重";
            cell.placeholderStr = @"请选择克重";
        }else if (indexPath.section == 2 && indexPath.row == 3){
            cell.titleStr = @"楞型";
            cell.placeholderStr = @"请选择楞型";
        }else{
            cell.titleStr = @"品牌系列";
            cell.placeholderStr = @"";
        }
    }
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 50)];
    UIView *line2 = [[UIView alloc] initWithFrame:CGRectMake(0, 49.5, SCREEN_WIDTH, 0.5)];
    line2.backgroundColor = BASECOLOR_BACKGROUND_GRAY;
    [headerView addSubview:line2];
    
    
    UIView *view1 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 49.5)];
    view1.backgroundColor = BASECOLOR_BACKGROUND_GRAY;
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, SCREEN_WIDTH, 49.5)];
    [titleLabel setFont:FONTSIZE(15)];
    [view1 addSubview:titleLabel];
    titleLabel.text = self.sectionArray[section];
    [headerView addSubview:view1];
    return headerView;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 50;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
  
  if (indexPath.row == 0) {
    
    NSArray *array = @[@"最大面",@"次小面",@"最小面"];
    [self.pickerView pickerViewWithDelegate:self dataSource:array title:@"配材"];
  } else {
    NSArray *array = @[@"最大面",@"次小面",@"最面",@"fgdfh",@"sdffg"];
     [self.pickerView pickerViewWithDelegate:self dataSource:array title:@"等级"];
  }
}

-(void)pickerViewWithSelectedRow:(NSInteger)row selectedTitle:(NSString *)title {
  NSLog(@"%ld,%@",row,title);
}

-(PickerView *)pickerView {
  if (!_pickerView) {
    _pickerView = [[PickerView alloc] init];
  }
  return _pickerView;
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
