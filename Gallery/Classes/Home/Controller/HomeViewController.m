//
//  HomeViewController.m
//  Gallery
//
//  Created by 安东 on 2018/9/19.
//  Copyright © 2018年 安东. All rights reserved.
//

#import "HomeViewController.h"
#import "SceneView.h"
#import "UploadImageObject.h"
#import "AFNetworking.h"
#import "SSZipArchive.h"
@interface HomeViewController ()

@property (nonatomic, strong) UIScrollView  *scrollView;
@property (nonatomic, strong) NSArray  *boxList;

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"报价";
    BaseNavigationController *nav = (BaseNavigationController *)self.navigationController;
    [nav setNavigationBarRightItemWithButtonTitle:@"上传图片"];
    [nav showRightNavBtnWithClick:^(id sender) {
        [self uploadImage];
    }];
  
    [self downloadZip];
    UIButton *addBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [addBtn setFrame:CGRectMake(50, 500*SCALE_SIZE, 100, 50)];
    [addBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [addBtn setTitle:@"加" forState:UIControlStateNormal];
    [addBtn addTarget:self action:@selector(addBtn) forControlEvents:UIControlEventTouchUpInside];
    [self.scrollView addSubview:addBtn];
  
    
    UIButton *deleBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [deleBtn setFrame:CGRectMake(250, 500*SCALE_SIZE, 100, 50)];
    [deleBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [deleBtn setTitle:@"减" forState:UIControlStateNormal];
    [deleBtn addTarget:self action:@selector(deleBtn) forControlEvents:UIControlEventTouchUpInside];
    [self.scrollView addSubview:deleBtn];
}

- (void)addBtn {
  SceneView *sceneView = [self.scrollView viewWithTag:100];
  [sceneView addNode];
}

- (void)deleBtn {
  SceneView *sceneView = [self.scrollView viewWithTag:100];
  [sceneView removeNode];
}

- (void)downloadZip {
    
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
    //这里我们用本地链接替代一下，可以使用任意url链接
    NSURL *URL = [NSURL URLWithString:@"file:///Users/andong/Desktop/model.scnassets.zip"];
    NSURLRequest *request = [NSURLRequest requestWithURL:URL];
    
    NSURLSessionDownloadTask *downloadTask = [manager downloadTaskWithRequest:request progress:nil destination:^NSURL *(NSURL *targetPath, NSURLResponse *response) {
        
        NSURL *documentsDirectoryURL = [[NSFileManager defaultManager] URLForDirectory:NSDocumentDirectory inDomain:NSUserDomainMask appropriateForURL:nil create:NO error:nil];
        return [documentsDirectoryURL URLByAppendingPathComponent:[response suggestedFilename]];
        
    } completionHandler:^(NSURLResponse *response, NSURL *filePath, NSError *error) {
        NSLog(@"File downloaded to: %@", filePath);
        NSArray  *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *documentsDirectory = [paths objectAtIndex:0];
        NSString *inputPath = [documentsDirectory stringByAppendingPathComponent:@"/model.scnassets.zip"];
        
        NSError *zipError = nil;
        
        [SSZipArchive unzipFileAtPath:inputPath toDestination:documentsDirectory overwrite:YES password:nil error:&zipError];
        
        if( zipError ){
            NSLog(@"[GameVC] Something went wrong while unzipping: %@", zipError.debugDescription);
        }else {
            NSLog(@"[GameVC] Archive unzipped successfully");
            [self  clearFlie:inputPath];
            [self createSceneView];
        }
        
    }];
    [downloadTask resume];
}
-(void)clearFlie:(NSString *)filePath{
    NSError * error = nil ;
    [[NSFileManager defaultManager ] removeItemAtPath :filePath error :&error];
}

- (void)createSceneView {
    
    NSURL *documentsDirectoryURL = [[NSFileManager defaultManager] URLForDirectory:NSDocumentDirectory inDomain:NSUserDomainMask appropriateForURL:nil create:NO error:nil];
    // 这里的dae文件名字是我们导出时定义的文件名，下面一段代码中加载的SCNNode是我们之前在面板中改过的模型名
    documentsDirectoryURL = [documentsDirectoryURL URLByAppendingPathComponent:@"model.scnassets/nbox3gai.dae"];
    for (int i = 0; i < self.boxList.count; i++) {
        
        // 创建3D展示view
        SceneView *sceneView = [[SceneView alloc] initWithSceneName:documentsDirectoryURL
                                                              frame:CGRectMake((SCREEN_WIDTH-30)*i+10, SCALE_SIZE*70, SCREEN_WIDTH-40, SCREEN_WIDTH-40)];
        sceneView.tag = 100;
        [self.scrollView addSubview:sceneView];
        
        if (i == 1) {
            [sceneView sceneViewDiffuseImage:[UIImage imageNamed:@"180X180"]];
            [sceneView sceneViewReflectiveImage:[UIImage imageNamed:@"180X180"]];
        } else {
            if (i == 0) {
                
            } else {
                [sceneView sceneViewDiffuseImage:[UIImage imageNamed:@"180X180"]];
            }
        }
        
        // 添加点击手势
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(btnClick:)];
        [sceneView addGestureRecognizer:tap];
        
        UIView *tapView = [tap view];
        [tapView setTag:(100 + i)];
        
        UILabel *titleLabel = [[UILabel alloc] init];
        [titleLabel setText:self.boxList[i][@"boxTitle"]];
        [_scrollView addSubview:titleLabel];
        [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(sceneView);
            make.top.mas_equalTo(sceneView.mas_bottom).offset(SCALE_SIZE*20);
        }];
    }
}

- (void)uploadImage {
    UploadImageObject *upload = [[UploadImageObject alloc] init];
    [upload uploadImageWithController:self Block:^(UIImage *image) {
        SceneView *sceneView = [self.scrollView viewWithTag:100];
        [sceneView sceneViewDiffuseImage:image];
        [sceneView sceneViewReflectiveImage:image];
    }];
}

- (void)btnClick:(id)sender {
    
    //  UITapGestureRecognizer *tap = (UITapGestureRecognizer *)sender;
    //  QuoteViewController *vc = [[QuoteViewController alloc] init];
    //  [vc setValue:self.boxList[[tap view].tag-100][@"boxTitle"] forKey:@"titleString"];
    //  [vc setValue:self.boxList[[tap view].tag-100][@"boxId"] forKey:@"boxId"];
    //  [self.navigationController pushViewController:vc animated:YES];
}

#pragma marks - getters
-(UIScrollView *)scrollView {
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] init];
        [_scrollView setFrame:self.view.frame];
        [_scrollView setContentSize:CGSizeMake((SCREEN_WIDTH-40)*12 + 130, 0)];
        [self.view addSubview:_scrollView];
        
    }
    return _scrollView;
}

-(NSArray *)boxList {
    if (!_boxList) {
        _boxList = [[[NSDictionary alloc] initWithContentsOfFile:
                     [[NSBundle mainBundle] pathForResource:@"DataList.plist"ofType:nil]]
                    objectForKey:@"BoxList"] ;
    }
    return _boxList;
}

@end

