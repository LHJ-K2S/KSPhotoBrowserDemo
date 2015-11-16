//
//  KSPhotoCell.h
//  ihome
//
//  Created by lhj on 10/30/15.
//  Copyright © 2015 Boer. All rights reserved.
//

#import <UIKit/UIKit.h>

@class KSPhoto;

@interface KSPhotoCell : UICollectionViewCell

@property (nonatomic, strong) KSPhoto *photo;
@property (nonatomic, weak) UIImageView *photoView;
@property (nonatomic, weak) UIView *coverView1;
@property (nonatomic, weak) UIView *coverView2;
@property (nonatomic, strong) UIImageView *selectedView1;
@property (nonatomic, strong) UIImageView *selectedView2;
@property (nonatomic, assign) BOOL selectState;
@property (nonatomic, assign) BOOL selectStateYES;

@end
