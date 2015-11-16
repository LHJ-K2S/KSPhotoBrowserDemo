//
//  KSDetailCell.h
//  ihome
//
//  Created by lhj on 11/7/15.
//  Copyright © 2015 Boer. All rights reserved.
//

#import <UIKit/UIKit.h>
@class KSPhoto;

@interface KSDetailCell : UICollectionViewCell

@property (nonatomic, strong) KSPhoto *photo;
@property (nonatomic, weak) UIImageView *photoView;
@property (nonatomic, weak) UIScrollView *scrollView;

@end
