//
//  ProductsViewController.m
//  Gallery
//
//  Created by 安东 on 06/11/2018.
//  Copyright © 2018 安东. All rights reserved.
//

#import "ProductsViewController.h"
#import "CategoryDetallCell.h"
#import "TopPageSlideController.h"
#import "AddressListController.h"
@interface ProductsViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>

@property(nonatomic, strong)UICollectionView *listCollection;

@end

static NSString *cellIdentList = @"listCell";

@implementation ProductsViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  [self.view setFrame:CGRectMake(SCREEN_WIDTH*0.24, 40, SCREEN_WIDTH*0.76, SCREEN_HEIGHT-40)];
  
  NSDictionary *dic = [[NSDictionary alloc] initWithContentsOfFile:
                       [[NSBundle mainBundle] pathForResource:@"DataList.plist"ofType:nil]];
  self.dataSource = dic[@"CategoryList"];
  [self.listCollection registerClass:[CategoryDetallCell class] forCellWithReuseIdentifier:cellIdentList];
  

}

#pragma maek -UICollectionViewDelegateFlowLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
  return CGSizeMake((SCREEN_WIDTH*0.76-(SCALE_SIZE*10))/2, ((SCREEN_WIDTH*0.76-(SCALE_SIZE*10))/2-SCALE_SIZE*10) /124 *100 + SCALE_SIZE * 40);
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
  return UIEdgeInsetsMake(0,SCALE_SIZE*5,0,SCALE_SIZE*5);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
  
  return 0;
}

// 列
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
  return 0;
  
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
  return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
  return self.dataSource.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
  CategoryDetallCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellIdentList forIndexPath:indexPath];
  [cell setType:ProductsType];
  [cell setDataDic:self.dataSource[indexPath.row]];
  return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
  
  if (indexPath.row == 3) {
    AddressListController *addressVC = [[AddressListController alloc] init];
    [self.navigationController pushViewController:addressVC animated:YES];
  }else{
    TopPageSlideController * detailVC = [[TopPageSlideController alloc] initCategoryDetailVC];
    detailVC.title = @"水果农特";
    [self.navigationController pushViewController:detailVC animated:YES];
  }
}

#pragma mark - 一级tableView滚动时 实现当前类tableView的联动
- (void)scrollToSelectedIndexPath:(NSIndexPath *)indexPath {
  
  
//  [self.listCollection selectItemAtIndexPath:[NSIndexPath indexPathForRow:indexPath.row inSection:0]
//                                    animated:YES
//                              scrollPosition:UICollectionViewScrollPositionTop];
}

-(UICollectionView *)listCollection {
  if (!_listCollection) {
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    
    //2.初始化collectionView
    _listCollection = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH*0.76, SCREEN_HEIGHT-49-SafeAreaBottomHeight-NAVIGATIONBAR_HEIGHT-40) collectionViewLayout:layout];
    
    _listCollection.backgroundColor = [UIColor whiteColor];
    //注意，此处的ReuseIdentifier 必须和 cellForItemAtIndexPath 方法中 一致 均为 cellId
    //4.设置代理
    _listCollection.delegate = self;
    _listCollection.dataSource = self;
    _listCollection.alwaysBounceVertical = YES;
    
    [self.view addSubview:_listCollection];
    
  }
  return _listCollection;
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
