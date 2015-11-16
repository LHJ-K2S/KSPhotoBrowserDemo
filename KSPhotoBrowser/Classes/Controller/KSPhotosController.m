//
//  KSPhotosController.m
//  KSPhotoBrowser
//
//  Created by lhj on 11/9/15.
//  Copyright © 2015 lhj. All rights reserved.
//

#import "KSPhotosController.h"
#import "KSPhoto.h"
#import "SVProgressHUD.h"
#import "KSPhotoCell.h"
#import "KSDetailController.h"


@interface KSPhotosController () <UICollectionViewDataSource,UICollectionViewDelegate,KSDetailControllerDelegate,UIScrollViewDelegate>

@property (nonatomic, assign) CGFloat itemWidth;
@property (nonatomic, assign) CGFloat offsetY;
@property (nonatomic, strong) NSMutableArray *selectedPhotos;
@property (nonatomic, assign) BOOL showAnimated;
@property (nonatomic, assign) BOOL selectState;

@end

@implementation KSPhotosController

- (void)viewDidLoad {
    [super viewDidLoad];
    [UIApplication sharedApplication].keyWindow.backgroundColor = [UIColor whiteColor];
    self.view.backgroundColor = [UIColor whiteColor];

    [self setupCollectionView];
//    [self setupNavigationItem];
    [self setupKSToolBar];
    [self setupKSToolBar2];
}

//- (void)setupNavigationItem{
//    
//    
//    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"选择" style:UIBarButtonItemStyleDone target:self action:@selector(selectClick)];
//    [self updateNavigationBar];
//}

- (void)setupCollectionView{
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        
        if (!self.numberOfRows) {
            self.numberOfRows = 3;
        }
        self.itemWidth = self.view.bounds.size.width / self.numberOfRows - 2;
        
        
        layout.itemSize = CGSizeMake(self.itemWidth, self.itemWidth);
        layout.minimumLineSpacing = 3;
        layout.minimumInteritemSpacing = 2;
        
        UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:layout];
        collectionView.delegate = self;
        collectionView.dataSource = self;
        collectionView.backgroundColor = [UIColor whiteColor];
        collectionView.bounces = YES;
        collectionView.contentInset = UIEdgeInsetsMake(0, 0, 100, 0);
        collectionView.alwaysBounceVertical = YES;
        [self.view addSubview:collectionView];
        self.collectionView = collectionView;
        
        [collectionView registerClass:[KSPhotoCell class] forCellWithReuseIdentifier:@"cell"];
        
        UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPress)];
        [collectionView addGestureRecognizer:longPress];
    }
}

- (void)setupKSToolBar{
    if (!_KSToolBar) {
        // 底部条
        UIView *KSToolBar = [[UIView alloc] initWithFrame:CGRectMake(0, self.view.bounds.size.height, KSScreenW, 44)];
        KSToolBar.backgroundColor = [UIColor colorWithRed:240 / 255.0 green:240 / 255.0 blue:240 / 255.0 alpha:1.0];
        _KSToolBar = KSToolBar;
        [self.view addSubview:KSToolBar];
        
        UIView *separateView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 1)];
        separateView.backgroundColor = [UIColor grayColor];
        [KSToolBar addSubview:separateView];
        
        
        UIButton *saveBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        //    saveBtn.frame = CGRectMake(CScreenWidth / 2 - 15, 7, 30, 30);
        saveBtn.frame = CGRectMake(10, 7, 30, 30);
        [saveBtn setBackgroundImage:[UIImage imageNamed:@"还原"] forState:UIControlStateNormal];
        [saveBtn addTarget:self action:@selector(saveClick) forControlEvents:UIControlEventTouchUpInside];
        [KSToolBar addSubview:saveBtn];
        
        UIButton *deleteBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        deleteBtn.frame = CGRectMake(KSScreenW - 40, 7, 30, 30);
        [deleteBtn setBackgroundImage:[UIImage imageNamed:@"删除"] forState:UIControlStateNormal];
        [deleteBtn addTarget:self action:@selector(delete) forControlEvents:UIControlEventTouchUpInside];
        [KSToolBar addSubview:deleteBtn];
    }
}

- (void)setupKSToolBar2{
    if (!_KSToolBar2) {
        UIView *KSToolBar2 = [[UIView alloc] initWithFrame:CGRectMake(0, self.view.bounds.size.height, KSScreenW, 44)];
        KSToolBar2.backgroundColor = KSColor(240, 240, 240);
        [self.view addSubview:KSToolBar2];
        _KSToolBar2 = KSToolBar2;
        
        UIView *separateView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, KSScreenW, 1)];
        separateView.backgroundColor = [UIColor grayColor];
        [KSToolBar2 addSubview:separateView];
        
        UIButton *selectAllBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        selectAllBtn.frame = CGRectMake(10, 10, 70, 30);
        [selectAllBtn setTitle:@"全部选择" forState:UIControlStateNormal];
        selectAllBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        selectAllBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
        [selectAllBtn setTitleColor:[UIColor colorWithRed:18/255.0 green:140/255.0 blue:227/255.0 alpha:1.0] forState:UIControlStateNormal];
        [selectAllBtn setTitleColor:[UIColor colorWithRed:220/255.0 green:220/255.0 blue:220/255.0 alpha:1.0] forState:UIControlStateHighlighted];
        [selectAllBtn setBackgroundColor:[UIColor colorWithRed:200 / 255.0 green:200 / 255.0 blue:200 / 255.0 alpha:1.0]];
        selectAllBtn.layer.cornerRadius = 3;
        selectAllBtn.clipsToBounds = YES;
        selectAllBtn.contentEdgeInsets = UIEdgeInsetsMake(3, 8, 3, 8);
        [selectAllBtn addTarget:self action:@selector(selectAllClick) forControlEvents:UIControlEventTouchUpInside];
        [selectAllBtn sizeToFit];
        [KSToolBar2 addSubview:selectAllBtn];
        
        UIButton *cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
        cancelButton.frame = CGRectMake(KSToolBar2.bounds.size.width - 60, 10, 50, 30);
        [cancelButton setTitle:@"取消" forState:UIControlStateNormal];
        [cancelButton setTitleColor:[UIColor colorWithRed:18/255.0 green:140/255.0 blue:227/255.0 alpha:1.0] forState:UIControlStateNormal];
        [cancelButton setTitleColor:[UIColor colorWithRed:220/255.0 green:220/255.0 blue:220/255.0 alpha:1.0] forState:UIControlStateHighlighted];
        [cancelButton setBackgroundColor:[UIColor colorWithRed:200 / 255.0 green:200 / 255.0 blue:200 / 255.0 alpha:1.0]];
        cancelButton.layer.cornerRadius = 3;
        cancelButton.clipsToBounds = YES;
        [cancelButton sizeToFit];
        [cancelButton addTarget:self action:@selector(cancelClick) forControlEvents:UIControlEventTouchUpInside];
    }
}



- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    if (self.showAnimated) {
        self.view.alpha = 0;
//        self.KSToolBar.frame = CGRectMake(0, self.view.bounds.size.height - 44, self.view.bounds.size.width, 44);
        [UIView animateWithDuration:2 animations:^{
            self.view.alpha = 1.0;
//            self.KSToolBar.frame = CGRectMake(0, self.view.bounds.size.height, self.view.bounds.size.width, 44);
        }completion:^(BOOL finished) {
            //            self.vacancyIndex = 0;
            [self.collectionView reloadData];
            self.showAnimated = NO;
        }];
    }
    
}

- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
}

#pragma mark - 逻辑方法

- (void)updateNavigationBar{
    
    if (!self.photos.count) {
        self.navigationItem.rightBarButtonItem.enabled = NO;
        self.navigationItem.rightBarButtonItem.title = @"";
        
        
    }else{
        
        self.navigationItem.rightBarButtonItem.enabled = YES;
        if (self.selectState) {
            self.navigationItem.rightBarButtonItem.title = @"取消";
        }else{
            self.navigationItem.rightBarButtonItem.title = @"选择";
        }
    }
}

- (void)selectAllClick{
    
    [self.selectedPhotos removeAllObjects];
    for (KSPhoto *photo in self.photos) {
        photo.selectState = YES;
        photo.selectStateYES = YES;
    }
    [self.selectedPhotos addObjectsFromArray:self.photos];
    [UIView animateWithDuration:0.15 animations:^{
        self.KSToolBar2.frame = CGRectMake(0, self.view.bounds.size.height, KSScreenW, 44);
    }completion:^(BOOL finished) {
        [UIView animateWithDuration:0.15 animations:^{
            self.KSToolBar.frame = CGRectMake(0, self.view.bounds.size.height - 44, KSScreenW, 44);
        }];
    }];
    
    [self.collectionView reloadData];
}

- (void)cancelClick{
    [self.selectedPhotos removeAllObjects];
    [UIView animateWithDuration:0.15 animations:^{
        self.KSToolBar2.frame = CGRectMake(0, self.view.bounds.size.height, KSScreenW, 44);
    }completion:^(BOOL finished) {
        [UIView animateWithDuration:0.15 animations:^{
            self.KSToolBar.frame = CGRectMake(0, self.view.bounds.size.height - 44, KSScreenW, 44);
        }];
    }];
    [self.collectionView reloadData];
}

- (void)saveClick{
    [SVProgressHUD show];
    
    if (self.selectedPhotos.count) {
        [self savePhoto];
    }
    
}

- (void)savePhoto{
    if (self.selectedPhotos.count) {
        KSPhoto *photo = self.selectedPhotos[0];
//        UIImage *photo = [UIImage imageWithContentsOfFile:photo.fullName];
        UIImage *image = [UIImage imageNamed:photo.name];
        UIImageWriteToSavedPhotosAlbum(image, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
    }else{
        [SVProgressHUD showSuccessWithStatus:@"保存成功！"];
//        [self selectClick];
    }
}

- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo{
    if (error) {
        [SVProgressHUD showErrorWithStatus:@"保存失败！"];
        
        NSLog(@"%@",error.description);
//        [self selectClick];
        
    }else{
        [self.selectedPhotos removeObjectAtIndex:0];
        [self savePhoto];
    }
}

- (void)delete{

    if (self.photos.count) {
        if (self.selectedPhotos.count) {
            [self deletePhotoWithPhotoArray:self.selectedPhotos];
        }
        
    }
}

- (void)deletePhotoWithPhotoArray:(NSArray *)photos{
//    NSFileManager *manager = [NSFileManager defaultManager];
    // 弹出确认框
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"温馨提示" message:@"确定要删除吗？" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:nil];
    UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
//        for (KSPhoto *photo in photos){
            // 删除本地存储
//            if ([manager fileExistsAtPath:photoModel.fullName]) {
//                NSError *err;
//                [manager removeItemAtPath:photoModel.fullName error:&err];
//            }
//        }
        // 删除模型
        [self.photos removeObjectsInArray:photos];
        
        // 更新界面
        [self.collectionView reloadData];
        
        [self updateNavigationBar];
        
//        [self selectClick];
        //        if (self.photoModels.count == 0){
        //            [self leftBtnClick];
        //        }
    }];
    
    [alert addAction:action1];
    [alert addAction:action2];
    [self presentViewController:alert animated:YES completion:nil];
}

- (void)longPress{
    [self.selectedPhotos removeAllObjects];
    self.selectState = YES;
    [self.collectionView reloadData];
    [UIView animateWithDuration:0.25 animations:^{
        self.KSToolBar2.frame = CGRectMake(0, self.view.bounds.size.height - 44, self.view.bounds.size.width, 44);
    }];
}

#pragma mark - 数据方法




#pragma mark - <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return self.photos.count;
    
}

#warning 更改cell的创建方法，把collectionView传过去

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    KSPhotoCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    KSPhoto *photo = self.photos[indexPath.row];
    cell.photo = photo;
    cell.photoView.contentMode = UIViewContentModeScaleAspectFill;
    
    photo.selectState = self.selectState;

    return cell;
    
    
}

#pragma mark <UICollectionViewDelegate>

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    if (!self.selectState) {
        
        KSDetailController *detailController = [[KSDetailController alloc] init];
        detailController.photos = self.photos;
        detailController.currentIndex = indexPath.row;
        detailController.rowWidth = self.itemWidth;
        detailController.numberOfRows = self.numberOfRows;
        detailController.LastOffsetY = self.offsetY;
        detailController.LastOriginY = self.collectionView.frame.origin.y;
        detailController.delegate = self;
        if (!self.backgroundColorForDetail) {
            self.backgroundColorForDetail = [UIColor whiteColor];
        }
        detailController.view.backgroundColor = self.backgroundColorForDetail;
        
        // 设置画面淡入效果
        UIImageView *animatView = [[UIImageView alloc] initWithFrame:CGRectMake((self.itemWidth + 2) * (indexPath.row % self.numberOfRows), (self.itemWidth + 2) * (indexPath.row / self.numberOfRows) + self.collectionView.frame.origin.y - self.offsetY, self.itemWidth, self.itemWidth)];
        
        
        KSPhoto *photo = self.photos[indexPath.row];
        animatView.image = photo.image;

        
        animatView.contentMode = UIViewContentModeScaleAspectFit;
        [[UIApplication sharedApplication].keyWindow addSubview:animatView];
        
        [UIView animateWithDuration:2 animations:^{
            self.view.alpha = 0;
            // 设置detailVc滚动至显示的画面
            detailController.collectionView.contentOffset = CGPointMake(indexPath.row * detailController.collectionView.bounds.size.width, 0);
            animatView.frame = CGRectMake([UIScreen mainScreen].bounds.origin.x, [UIScreen mainScreen].bounds.origin.y, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - 44);
            
        } completion:^(BOOL finished) {
            
            [self presentViewController:detailController animated:NO completion:^{
                animatView.hidden = YES;
            }];

            
            
        }];
        
        
        
        
        
        
    }else{
        // 如果是浏览小图的时候点击cell，那么改模型为selected
        KSPhotoCell *cell = (KSPhotoCell *)[collectionView cellForItemAtIndexPath:indexPath];
//        cell.selectStateYES = !cell.selectStateYES;
        
        KSPhoto *photomodel = self.photos[indexPath.row];
        photomodel.selectStateYES = !photomodel.selectStateYES;
        cell.photo = photomodel;
        if (photomodel.selectStateYES) {
            [self.selectedPhotos addObject:photomodel];
        }else{
            [self.selectedPhotos removeObject:photomodel];
        }
        
        
        // 如果有cell被选中，那么显示bottomView
        if (self.selectedPhotos.count) {
            [UIView animateWithDuration:0.15 animations:^{
                self.KSToolBar2.frame = CGRectMake(0, self.view.bounds.size.height, self.view.bounds.size.width, 44);
            }completion:^(BOOL finished) {
                [UIView animateWithDuration:0.15 animations:^{
                    self.KSToolBar.frame = CGRectMake(0, self.view.bounds.size.height - 44, self.view.bounds.size.width, 44);
                }];
            }];
        }else{// 没有cell被选中，那么显示anotherBottomView
            [UIView animateWithDuration:0.15 animations:^{
                self.KSToolBar.frame = CGRectMake(0, self.view.bounds.size.height, self.view.bounds.size.width, 44);
            }completion:^(BOOL finished) {
                [UIView animateWithDuration:0.15 animations:^{
                    self.KSToolBar2.frame = CGRectMake(0, self.view.bounds.size.height - 44, self.view.bounds.size.width, 44);
                }];
            }];
        }
    }
}

#pragma mark <UICollectionViewDelegate>

#pragma mark <UIScrollViewDelegate>

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    
    self.offsetY = self.collectionView.contentOffset.y;
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    
    self.offsetY = self.collectionView.contentOffset.y;
}

#pragma mark <PhotoDetailControllerDelegate>



- (void)KSDetailController:(KSDetailController *)KSDetailController photos:(NSMutableArray *)photos vacancyIndex:(NSInteger)index{
    self.showAnimated = YES;
    self.photos = photos;
    [self.collectionView reloadData];
}


#pragma mark - lazy

- (NSMutableArray *)selectedPhotos{
    if (!_selectedPhotos) {
        NSMutableArray *array = [NSMutableArray array];
        _selectedPhotos = array;
    }
    return _selectedPhotos;
}


- (NSMutableArray *)photos{
    if (!_photos) {
        _photos = [NSMutableArray array];
    }
    return _photos;
}


@end
