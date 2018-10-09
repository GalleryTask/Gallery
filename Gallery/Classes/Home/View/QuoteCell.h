//
//  QuoteCell.h
//  Gallery
//
//  Created by 安东 on 2018/9/25.
//  Copyright © 2018年 安东. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@protocol  QuoteCellDelegate  <NSObject>

@optional
- (void)quoteCellTextFieldShouldBeginEditing:(NSIndexPath *)indexPath;
- (void)quoteCellTextFieldShouldBeginEditing:(UITextField *)textField indexPath:(NSIndexPath *)indexPath;

@end
@interface QuoteCell : UITableViewCell

@property (nonatomic, copy) NSString  *titleString;
@property (nonatomic, copy) NSString  *detailString;
@property (nonatomic, strong) UITextField  *textField; // 长度宽度高度输入框
@property (nonatomic, strong) NSIndexPath  *indexPath;
@property (nonatomic, weak) id <QuoteCellDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
