//
//  SceneViewController.m
//  Gallery
//
//  Created by 安东 on 09/11/2018.
//  Copyright © 2018 安东. All rights reserved.
//

#import "SceneViewController.h"
#import "SceneView.h"
#import "TopPageSlideController.h"
#import "ARViewController.h"
#import "SSZipArchive.h"

@interface SceneViewController ()

@property (nonatomic, strong) SceneView  *sceneView;
@property (nonatomic, strong) UIButton   *customizedBtn; // 开始定制
@property (nonatomic, assign) BOOL  isChangeDiffuseImage;

@end

@implementation SceneViewController

- (void)viewDidLoad {
    [super viewDidLoad];
  self.navigationItem.title = @"3D苹果包装方案";
  [self getData];
 
//  [self.view addSubview:self.customizedBtn];
//  [self.sceneView nodeTurnAround];
  
  BaseNavigationController *nav = (BaseNavigationController *)self.navigationController;
  [nav setNavigationBarRightItemWithButtonTitle:@"AR实景" clickBlock:^(id sender) {
    ARViewController *arVC = [[ARViewController alloc] init];
    [self.navigationController pushViewController:arVC animated:YES];
  }];
  
  UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT-SafeAreaBottomHeight-50-NAVIGATIONBAR_HEIGHT, SCREEN_WIDTH, 50)];
  [backView setBackgroundColor:[UIColor whiteColor]];
  [self.view addSubview:backView];
  NSArray *array = @[@"开盖",@"合盖",@"更换内衬",@"收回",@"更换贴图"];
  for (int i = 0; i < 5; i++) {
    
    UIButton *openBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [openBtn setTitle:array[i] forState:UIControlStateNormal];
    [[openBtn titleLabel] setFont:FONTSIZE(14)];
    openBtn.tag = 100 + i;
    [openBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [openBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [openBtn setFrame:CGRectMake(SCREEN_WIDTH/5*i, 0, SCREEN_WIDTH/5, 50)];
    [backView addSubview:openBtn];
  }
  
}

-(void)viewDidDisappear:(BOOL)animated {
  [super viewDidDisappear:animated];
}

- (void)btnClick:(UIButton *)btn {
  switch (btn.tag-100) {
    case 0:
      [self.sceneView removeNode];
      break;
    case 1:
      [self.sceneView addNode];
      break;
    case 2:
      [self.sceneView changeLiningNode];
      break;
    case 3:
      [self.sceneView nodeCloseTopAndBottom];
      break;
    case 4:
    {
      if (self.isChangeDiffuseImage) {
        
        [self.sceneView changeNodeDiffuseWithImageNameArray:@[@"art.scnassets/one_boxtop.png",@"art.scnassets/one_lining.png",@"art.scnassets/one_boxdown.png"]];
        self.isChangeDiffuseImage = false;
      } else {
        
        [self.sceneView changeNodeDiffuseWithImageNameArray:@[@"art.scnassets/two_boxtop.png",@"art.scnassets/two_lining.png",@"art.scnassets/two_boxdown.png"]];
        self.isChangeDiffuseImage = true;
      }
    }
      break;
      
      
    default:
      break;
  }
}

// 开始定制按钮点击事件
- (void)customizedBtnClick:(id)sender {
  TopPageSlideController * vc = [[TopPageSlideController alloc] initPackagingCustomVC];
  [vc setTitle:@"3D包装方案"];
  [self.navigationController pushViewController:vc animated:YES];
}

- (void)getData {
  NSArray  *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
  NSString *documentsDirectory = [paths objectAtIndex:0];
  NSString *inputPath = [documentsDirectory stringByAppendingPathComponent:@"/yisideModel/tianmao.zip"];
  
  NSError *zipError = nil;
  
  [SSZipArchive unzipFileAtPath:inputPath toDestination:[documentsDirectory stringByAppendingPathComponent:@"/yisideModel"] overwrite:NO password:nil error:&zipError];
  
  if( zipError ){
    [self createSceneView];
    NSLog(@"解压失败: %@", zipError.debugDescription);
    [self createSceneView];
  }else {
    NSLog(@"解压成功");
//    [self  clearFlie:inputPath];
    [self createSceneView];
  }
}

- (void)createSceneView {
  
  NSURL *documentsDirectoryURL = [[NSFileManager defaultManager] URLForDirectory:NSDocumentDirectory inDomain:NSUserDomainMask appropriateForURL:nil create:NO error:nil];
  // 这里的dae文件名字是我们导出时定义的文件名，下面一段代码中加载的SCNNode是我们之前在面板中改过的模型名
  documentsDirectoryURL = [documentsDirectoryURL URLByAppendingPathComponent:@"yisideModel/tianmao.scnassets"];

//  NSString *string = [documentsDirectoryURL absoluteString];
  NSString *string = [[[NSBundle mainBundle] URLForResource:@"art.scnassets/box_4.0" withExtension:@"DAE"] absoluteString];
  self.sceneView = [[SceneView alloc] initWithSceneName:string
                                                  frame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-50-SafeAreaBottomHeight)];
  [self.view addSubview:self.sceneView];
}

-(void)clearFlie:(NSString *)filePath{
  NSError * error = nil ;
  [[NSFileManager defaultManager ] removeItemAtPath :filePath error :&error];
}

#pragma marks - getters
-(UIButton *)customizedBtn {
  if (!_customizedBtn) {
    _customizedBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_customizedBtn setFrame:CGRectMake(0, SCREEN_HEIGHT-SafeAreaBottomHeight-50-NAVIGATIONBAR_HEIGHT, SCREEN_WIDTH, 50)];
    [_customizedBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_customizedBtn setTitle:@"开始定制" forState:UIControlStateNormal];
    [[_customizedBtn titleLabel] setFont:FONTSIZE(16)];
    [_customizedBtn setBackgroundColor:BASECOLOR_BLACK_333];
    [_customizedBtn addTarget:self action:@selector(customizedBtnClick:) forControlEvents:UIControlEventTouchUpInside];
  }
  return _customizedBtn;
}


//-(SceneView *)sceneView {
//  if (!_sceneView) {
//    _sceneView = [[SceneView alloc] initWithSceneName:@"art.scnassets/box.DAE"
//                                                frame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-50-SafeAreaBottomHeight)];
//  }
//  return _sceneView;
//}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
