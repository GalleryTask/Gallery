//
//  ProductsViewController.m
//  Gallery
//
//  Created by 安东 on 06/11/2018.
//  Copyright © 2018 安东. All rights reserved.
//

#import "ProductsViewController.h"
#import "CategoryListCollectionViewCell.h"
@interface ProductsViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>

@property(nonatomic, strong)UICollectionView *listCollection;

@end
static NSString *cellIdentList = @"listCell";
@implementation ProductsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
  [self.view setFrame:CGRectMake(SCREEN_WIDTH*0.2, 0, SCREEN_WIDTH*0.8, SCREEN_HEIGHT)];
//  [self.view setBackgroundColor:BASECOLOR_LIGHTGRAY];

    [self.listCollection setContentInset:UIEdgeInsetsMake(0, 0, SafeAreaBottomHeight+BASE_HEIGHT, 0)];
}

#pragma maek -UICollectionViewDelegateFlowLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    //return CGSizeMake((SCREEN_WIDTH*0.8-(SCALE_SIZE*10))/2, (SCREEN_WIDTH*0.8-(SCALE_SIZE*10))/2+ SCALE_SIZE*30);
    return CGSizeMake((SCREEN_WIDTH*0.8-(SCALE_SIZE*10))/2, ((SCREEN_WIDTH*0.8-(SCALE_SIZE*10))/2-SCALE_SIZE*10) /124 *100 + SCALE_SIZE * 40);
}
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(0,SCALE_SIZE*5,0,SCALE_SIZE*5);
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    
    return 0;
}
//列
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return 0;
    
}
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 7;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    CategoryListCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellIdentList forIndexPath:indexPath];
  
    if (indexPath.row == 0) {
        cell.contentView.backgroundColor = [UIColor redColor];
    }
    return cell;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
  
    
}



#pragma mark - 一级tableView滚动时 实现当前类tableView的联动
- (void)scrollToSelectedIndexPath:(NSIndexPath *)indexPath {
  
//  [self.tableView selectRowAtIndexPath:([NSIndexPath indexPathForRow:0 inSection:indexPath.row])
//                              animated:YES
//                        scrollPosition:UITableViewScrollPositionTop];
}

-(UICollectionView *)listCollection
{
    if (!_listCollection) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        //设置collectionView滚动方向
        //    [layout setScrollDirection:UICollectionViewScrollDirectionHorizontal];
        //该方法也可以设置itemSize
        //layout.itemSize =CGSizeMake(110, 150);
        
        //2.初始化collectionView
        _listCollection = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH*0.8, SCREEN_HEIGHT) collectionViewLayout:layout];
        
        _listCollection.backgroundColor = [UIColor whiteColor];
        //注意，此处的ReuseIdentifier 必须和 cellForItemAtIndexPath 方法中 一致 均为 cellId
        [_listCollection registerClass:[CategoryListCollectionViewCell class] forCellWithReuseIdentifier:cellIdentList];
        //4.设置代理
        _listCollection.delegate = self;
        _listCollection.dataSource = self;
        
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
