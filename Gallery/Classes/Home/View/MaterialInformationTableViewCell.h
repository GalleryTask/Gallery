//
//  MaterialInformationTableViewCell.h
//  Gallery
//
//  Created by admin on 2018/9/19.
//  Copyright © 2018年 安东. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MaterialInformationTableViewCell : UITableViewCell

@property(nonatomic, strong)NSString *titleStr;
@property(nonatomic, strong)NSString *detailStr;
@property(nonatomic, strong)NSString *placeholderStr;

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier;

@end
