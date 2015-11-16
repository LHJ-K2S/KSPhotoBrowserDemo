//
//  KSPhotosController.h
//  KSPhotoBrowser
//
//  Created by lhj on 11/9/15.
//  Copyright © 2015 lhj. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KSPhoto.h"
@class KSPhotosController;
@protocol KSPhotosControllerDelegate <NSObject>

@required

//- (KSPhoto *)photosController:(KSPhotosController *)photosController photoAtIndex:(NSUInteger)index;

//- (NSInteger)numberOfPhotosInphotosController:(KSPhotosController *)photosController;
//- (NSArray *)photosController:(KSPhotosController *)photosController ;

@optional


@end


@interface KSPhotosController : UIViewController

@property (nonatomic, strong) NSMutableArray *photos;
@property (nonatomic, weak) UIView *KSToolBar;
@property (nonatomic, weak) UIView *KSToolBar2;
@property (nonatomic, weak) UICollectionView *collectionView;

@property (nonatomic, assign) NSInteger numberOfRows;
//@property (nonatomic, strong) UIViewController *sourceController;
@property (nonatomic, assign) UIColor *backgroundColorForDetail;
@property (nonatomic, weak) id <KSPhotosControllerDelegate> delegate;

@end
