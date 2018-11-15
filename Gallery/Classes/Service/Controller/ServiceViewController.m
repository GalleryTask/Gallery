- (void)addBtn {
  SceneView *sceneView = [self.scrollView viewWithTag:100];
  [sceneView addNode];
  
//  [sceneView sceneViewDiffuseImage:[UIImage imageNamed:@"home_1"]];
//  MMKV *mv = [MMKV defaultMMKV];
//  [mv setObject:@"sssssssssssssssssss" forKey:@"string"];
//  [mv setObject:@"123" forKey:@"string"];
//  NSLog(@"%@",[mv getObjectOfClass:NSString.class forKey:@"string"]) ;
//  [mv removeValueForKey:@"string"];
//  NSLog(@"%@",[mv getObjectOfClass:NSString.class forKey:@"string"]) ;
}

- (void)deleBtn {
  SceneView *sceneView = [self.scrollView viewWithTag:100];
  [sceneView removeNode];
  
//  [sceneView changeCameraNodePosition];
}

- (void)downloadZip {
  
  [self.dataRequest downloadFile];
  @weakify(self);
  [self.dataRequest setBlockWithReturnBlock:^(id returnValue) {
    @strongify(self);
    [self createSceneView];
  } WithErrorBlock:^(id errorCode) {

  } WithFailureBlock:^{

  }];
}

- (void)createSceneView {
    
    NSURL *documentsDirectoryURL = [[NSFileManager defaultManager] URLForDirectory:NSDocumentDirectory inDomain:NSUserDomainMask appropriateForURL:nil create:NO error:nil];
    // 这里的dae文件名字是我们导出时定义的文件名，下面一段代码中加载的SCNNode是我们之前在面板中改过的模型名
    documentsDirectoryURL = [documentsDirectoryURL URLByAppendingPathComponent:@"model.scnassets/nbox3gai.dae"];
    for (int i = 0; i < self.boxList.count; i++) {
        
        // 创建3D展示view
        SceneView *sceneView = [[SceneView alloc] initWithSceneName:@"tianmaojingling.DAE"
                                                              frame:CGRectMake((SCREEN_WIDTH-30)*i, SCALE_SIZE*70, SCREEN_WIDTH, SCREEN_WIDTH)];
        sceneView.tag = 100;
        [self.scrollView addSubview:sceneView];

      [sceneView sceneViewDiffuseImage:[UIImage imageNamed:@"2_timg.jpg"]];
//      [sceneView sceneViewReflectiveImage:[UIImage imageNamed:@"B.tga"]];
        
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
        [self.view addSubview:_scrollView];
        
    }
    return _scrollView;
}

-(NSArray *)boxList {
    if (!_boxList) {
      _boxList = @[@{@"boxTitle":@"",@"boxId":@""}];
    }
    return _boxList;
}

@end

