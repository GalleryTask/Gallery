//
//  CategoryDetallController.m
//  Gallery
//
//  Created by admin on 2018/11/8.
//  Copyright © 2018 安东. All rights reserved.
//

#import "CategoryDetailController.h"
#import "CategoryDetallCell.h"
#import "ShopDetailViewController.h"
@interface CategoryDetailController ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>



@property(nonatomic, strong)UICollectionView *listCollection;


@end
static NSString *cellIdentList = @"listCell";
@implementation CategoryDetailController

- (void)viewDidLoad {
  [super viewDidLoad];
  self.title = @"水果农特";
  [self.view addSubview:self.listCollection];
  
}

#pragma maek -UICollectionViewDelegateFlowLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
  return CGSizeMake((SCREEN_WIDTH - SCALE_SIZE*20)/2, (SCREEN_WIDTH - SCALE_SIZE*20)/2 + SCALE_SIZE*30);
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
  return UIEdgeInsetsMake(0,SCALE_SIZE*10,0,SCALE_SIZE*10);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
  
  return 0;
}
//列
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
  return 0;
  
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
  return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
  return 9;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
  CategoryDetallCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellIdentList forIndexPath:indexPath];
  return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
  
  ShopDetailViewController *detailVC = [[ShopDetailViewController alloc] init];
  [self.navigationController pushViewController:detailVC animated:YES];
}

-(UICollectionView *)listCollection {
  if (!_listCollection) {
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    
    //2.初始化collectionView
    _listCollection = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-NAVIGATIONBAR_HEIGHT -50) collectionViewLayout:layout];
    
    _listCollection.backgroundColor = [UIColor whiteColor];
    //注意，此处的ReuseIdentifier 必须和 cellForItemAtIndexPath 方法中 一致 均为 cellId
    [_listCollection registerClass:[CategoryDetallCell class] forCellWithReuseIdentifier:cellIdentList];
    //4.设置代理
    _listCollection.delegate = self;
    _listCollection.dataSource = self;
    
   
    
  }
  return _listCollection;
}


- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

@end
