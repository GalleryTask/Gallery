//
//  PickerView.h
//  Gallery
//
//  Created by 安东 on 2018/9/20.
//  Copyright © 2018年 安东. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@protocol  PickerViewDelegate  <NSObject>

@optional
- (void)pickerViewWithSelectedRow:(NSInteger)row selectedTitle:(NSString *)title selectedId:(NSString *)selectedId;

@end

@interface PickerView : UIView

@property (nonatomic, strong) NSArray  *dataArray;
@property (nonatomic, weak) id <PickerViewDelegate> delegate;

/**
 pickerview

 @param delegate 代理
 @param array 数据源
 @param title 显示标题
 */
- (void)pickerViewWithDelegate:(id<PickerViewDelegate>)delegate
                    dataSource:(NSArray *)array
                         title:(NSString *)title
                   selectedRow:(NSInteger)selectedRow;

- (void)pickerViewWithDelegate:(id<PickerViewDelegate>)delegate dataSource:(NSArray *)array title:(NSString *)title;

@end

NS_ASSUME_NONNULL_END
