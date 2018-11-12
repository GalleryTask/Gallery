//
//  PageRoundScrollview.h
//  Gallery
//
//  Created by 安东 on 12/11/2018.
//  Copyright © 2018 安东. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol  PageRoundScrollViewDelegate  <NSObject>

- (void)pageRoundScrollWithPage:(int)page;

@end

@interface PageRoundScrollView : UIView

@property (nonatomic, weak) id <PageRoundScrollViewDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
