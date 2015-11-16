//
//  KSDetailController.h
//  KSPhotoBrowser
//
//  Created by lhj on 11/10/15.
//  Copyright © 2015 lhj. All rights reserved.
//

#import <UIKit/UIKit.h>

@class KSDetailController,KSPhotosController,KSPhoto;

@protocol KSDetailControllerDelegate <NSObject>

@optional

- (void)KSDetailController:(KSDetailController *)KSDetailController photos:(NSMutableArray *)photos vacancyIndex:(NSInteger)index;
@required



@end



@interface KSDetailController : UIViewController

@property (nonatomic, strong) NSMutableArray *photos;
@property (nonatomic, assign) NSInteger currentIndex;
@property (nonatomic, assign) CGFloat rowWidth;
@property (nonatomic, assign) NSInteger numberOfRows;
@property (nonatomic, weak) UICollectionView *collectionView;
@property (nonatomic, assign) CGFloat LastOffsetY;
@property (nonatomic, assign) CGFloat LastOriginY;
@property (nonatomic, weak) UIView *bottomBar;
@property (nonatomic, strong) UIButton *leftBarButton;

@property (nonatomic, weak) id <KSDetailControllerDelegate> delegate;
//@property (nonatomic, strong) KSPhotosController *sourceControl;


@end
