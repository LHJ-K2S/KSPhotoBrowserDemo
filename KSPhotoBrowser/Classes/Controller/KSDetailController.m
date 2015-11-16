//
//  KSDetailController.m
//  KSPhotoBrowser
//
//  Created by lhj on 11/10/15.
//  Copyright © 2015 lhj. All rights reserved.
//

#import "KSDetailController.h"
#import "KSDetailCell.h"
#import "SVProgressHUD.h"
#import "KSPhotosController.h"
#import "KSPhoto.h"

@interface KSDetailController () <UICollectionViewDataSource,UICollectionViewDelegate>

@end

@implementation KSDetailController

static NSString * const reuseIdentifier = @"Cell";
static NSInteger const detailViewPadding = 20;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    

    [self setupCollectionView];
    
    [self setupBottomView];
    
}

- (void)setupCollectionView{
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        layout.minimumLineSpacing = detailViewPadding;
        
        layout.itemSize = CGSizeMake(self.view.bounds.size.width, self.view.bounds.size.height - 44);
        
        UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width + detailViewPadding, [UIScreen mainScreen].bounds.size.height - 44) collectionViewLayout:layout];
        collectionView.backgroundColor = [UIColor whiteColor];
        collectionView.pagingEnabled = YES;
        collectionView.contentInset = UIEdgeInsetsMake(0, 0, 0, detailViewPadding);
        
        [collectionView registerClass:[KSDetailCell class] forCellWithReuseIdentifier:reuseIdentifier];
        collectionView.dataSource = self;
        collectionView.delegate = self;
        [self.view addSubview:collectionView];
        self.collectionView = collectionView;
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(collectionViewTap)];
        [collectionView addGestureRecognizer:tap];
    }
    
}


- (void)setupBottomView{
    
    if (!_bottomBar) {
        UIView *bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, self.view.bounds.size.height, self.view.bounds.size.width, 44)];
        
        bottomView.backgroundColor = KSColor(240, 240, 240);
        [self.view addSubview:bottomView];
        self.bottomBar = bottomView;
        
        UIView *separateView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 1)];
        separateView.backgroundColor = [UIColor grayColor];
        [bottomView addSubview:separateView];
        
        
        UIButton *saveBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        saveBtn.frame = CGRectMake(10, 7, 30, 30);
        [saveBtn setBackgroundImage:[UIImage imageNamed:@"还原"] forState:UIControlStateNormal];
        [saveBtn addTarget:self action:@selector(saveClick) forControlEvents:UIControlEventTouchUpInside];
        [bottomView addSubview:saveBtn];
        
        UIButton *deleteBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        deleteBtn.frame = CGRectMake(self.view.bounds.size.width - 40, 7, 30, 30);
        [deleteBtn setBackgroundImage:[UIImage imageNamed:@"删除"] forState:UIControlStateNormal];
        [deleteBtn addTarget:self action:@selector(deleteClick) forControlEvents:UIControlEventTouchUpInside];
        [bottomView addSubview:deleteBtn];
    }

    
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    [UIView animateWithDuration:0.15 animations:^{
        self.bottomBar.frame = CGRectMake(0, self.view.bounds.size.height - 44, self.view.bounds.size.width, 44);
    }];
    
}

- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    // 如果有数据才做动画
    if (self.photos.count) {
        UIImageView *animatView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height - 44)];
        
        KSPhoto *photo = self.photos[self.currentIndex];
        animatView.image = photo.image;
        animatView.contentMode = UIViewContentModeScaleAspectFit;
        [[UIApplication sharedApplication].keyWindow addSubview:animatView];
        
        [UIView animateWithDuration:2 animations:^{
            animatView.frame = CGRectMake((self.rowWidth + 2) * (self.currentIndex % self.numberOfRows), (self.rowWidth + 2) * (self.currentIndex / self.numberOfRows) + self.LastOriginY - self.LastOffsetY, self.rowWidth, self.rowWidth);
        
        } completion:^(BOOL finished) {
            
            animatView.hidden = YES;
            
            
        }];
    }
    
    
}

#pragma mark - 逻辑方法

- (void)saveClick{
    [SVProgressHUD show];
    
    if (self.currentIndex) {
        KSPhoto *photo = self.photos[self.currentIndex];
        UIImage *image = [UIImage imageNamed:photo.name];
        UIImageWriteToSavedPhotosAlbum(image, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
    }
}

- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo{
    if (error) {
        [SVProgressHUD showErrorWithStatus:@"保存失败！"];
        
        NSLog(@"%@",error.description);
        
    }else{
        [SVProgressHUD showSuccessWithStatus:@"保存成功！"];
    }
}


- (void)deleteClick{
//    if ([self.delegate respondsToSelector:@selector(PhotoDetailController:didDeletePhoto:)]) {
//        [self.delegate PhotoDetailController:self didDeletePhoto:self.photoModels[self.currentIndex]];
//    }
//    
//    
//    PhotoModel *photoModel = self.photoModels[self.currentIndex];
//    [self deletePhotoWithModels:@[photoModel]];
}

- (void)deletePhotoWithModels:(NSArray *)photoModels{
//    NSFileManager *manager = [NSFileManager defaultManager];
//    // 弹出确认框
//    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"温馨提示" message:@"确定要删除吗？" preferredStyle:UIAlertControllerStyleAlert];
//    UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:nil];
//    UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//        
//        for (PhotoModel *photoModel in photoModels){
//            // 删除本地存储
//            if ([manager fileExistsAtPath:photoModel.fullName]) {
//                NSError *err;
//                [manager removeItemAtPath:photoModel.fullName error:&err];
//            }
//        }
//        // 删除模型
//        [self.photoModels removeObjectsInArray:photoModels];
//        
//        // 更新界面
//        [self.collectionView reloadData];
//        
//        
//        if (self.photoModels.count == 0){
//            [self leftButtonClick];
//        }
//    }];
//    
//    [alert addAction:action1];
//    [alert addAction:action2];
//    [self presentViewController:alert animated:YES completion:nil];
}

- (void)collectionViewTap{
    if ([self.delegate respondsToSelector:@selector(KSDetailController:photos:vacancyIndex:)]) {
        [self.delegate KSDetailController:self photos:self.photos vacancyIndex:self.currentIndex];
    }
    [self dismissViewControllerAnimated:NO completion:nil];
}

#pragma mark <UICollectionViewDataSource>

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return self.photos.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    KSDetailCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    self.currentIndex = indexPath.row;
    cell.photo = self.photos[indexPath.row];
    
    return cell;
}

#pragma mark <UICollectionViewDelegate>

- (void)collectionView:(UICollectionView *)collectionView didEndDisplayingCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath{
    KSDetailCell *lastCell = (KSDetailCell *)cell;
    lastCell.photoView.bounds = lastCell.bounds;
    //    NSLog(@"%@",NSStringFromCGRect(lastCell.bounds));
    lastCell.scrollView.zoomScale = 1.0;
    lastCell.scrollView.contentSize = lastCell.bounds.size;
}

#pragma mark <UIScrollViewDelegate>

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    CGFloat index = self.collectionView.contentOffset.x / self.collectionView.bounds.size.width;
    self.currentIndex = index;
    //    self.offsetY = 
}

@end
