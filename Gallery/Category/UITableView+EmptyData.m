//
//  UITableView+EmptyData.m
//  Tourmaline
//
//  Created by previz on 16/7/20.
//  Copyright © 2016年 dongan. All rights reserved.
//

#import "UITableView+EmptyData.h"


@implementation UITableView (EmptyData)

- (void)tableViewDisplayWithRowCount:(NSInteger)rowCount {
  
  if (rowCount > 0) {
    [self setTableFooterView:[UIView new]];
  } else {
    UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCALE_SIZE*418)];
    UIImageView *imgView = [[UIImageView alloc] init];

    if (rowCount == 0) {
      [imgView setFrame:CGRectMake((SCREEN_WIDTH-SCALE_SIZE*139)/2, SCALE_SIZE*160, SCALE_SIZE*139, SCALE_SIZE*140)];
      [imgView setImage:[UIImage imageNamed:@"noData"]];

    } else {
      [imgView setFrame:CGRectMake((SCREEN_WIDTH-42)/2, 170, 42, 42)];
      [imgView setImage:[UIImage imageNamed:@"fail_Connected"]];

    }

    [backView addSubview:imgView];
    [self setTableFooterView:backView];
  }

}



@end
