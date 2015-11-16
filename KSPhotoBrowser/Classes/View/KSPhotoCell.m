//
//  KSPhotoCell.m
//  ihome
//
//  Created by lhj on 10/30/15.
//  Copyright © 2015 Boer. All rights reserved.
//

#import "KSPhotoCell.h"
#import "KSPhoto.h"
#import "UIImage+Image.h"

@interface KSPhotoCell ()


@end

@implementation KSPhotoCell
- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        UIImageView *photoView = [[UIImageView alloc] init];
        [self.contentView addSubview:photoView];
        self.photoView = photoView;
        photoView.contentMode = UIViewContentModeScaleAspectFill;
        photoView.clipsToBounds = YES;
        photoView.userInteractionEnabled = YES;
        
        // 遮盖1
        UIView *coverView1 = [[UIView alloc] init];
        coverView1.backgroundColor = [UIColor colorWithWhite:0.5 alpha:0.2];
        coverView1.hidden = YES;
        [self addSubview:coverView1];
        self.coverView1 = coverView1;
        UIImageView *selectedView1 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"圆"]];
        self.selectedView1 = selectedView1;
        [coverView1 addSubview:selectedView1];
        
        // 遮盖2
        UIView *coverView2 = [[UIView alloc] init];
        coverView2.backgroundColor = [UIColor colorWithWhite:0.5 alpha:0.5];
        coverView2.hidden = YES;
        [self addSubview:coverView2];
        self.coverView2 = coverView2;
        UIImageView *selectedView2 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"勾勾"]];
        self.selectedView2 = selectedView2;
        [coverView2 addSubview:selectedView2];

    }
    return self;
}

- (void)layoutSubviews{
    self.photoView.frame = self.bounds;
    self.coverView1.frame = self.bounds;
    self.coverView2.frame = self.bounds;

    self.selectedView1.frame = CGRectMake(self.coverView1.bounds.size.width - 30, self.coverView1.bounds.size.height - 30, 20, 20);
    self.selectedView2.frame = CGRectMake(self.coverView2.bounds.size.width - 30, self.coverView2.bounds.size.height - 30, 20, 20);
    
}

//- (void)setSelectState:(BOOL)selectState{
//    _selectState = selectState;
//    
//    self.coverView1.hidden = !selectState;
//    self.coverView2.hidden = YES;
//}
//
//- (void)setSelectStateYES:(BOOL)selectStateYES{
//    _selectStateYES = selectStateYES;
//    
//    self.coverView1.hidden = selectStateYES;
//    self.coverView2.hidden = !selectStateYES;
//    if (self.selectStateYES) {
//        self.coverView1.hidden = YES;
//        self.coverView2.hidden = NO;
//    }else{
//        self.coverView1.hidden = NO;
//        self.coverView2.hidden = YES;
//    }
    
//}


- (void)setPhoto:(KSPhoto *)photo{
    _photo = photo;
    
    self.coverView1.hidden = !photo.selectState || photo.selectStateYES;
    self.coverView2.hidden = !photo.selectState || !photo.selectStateYES;
//    NSString *filePath = [[NSBundle mainBundle] pathForResource:photo.name ofType:@"jpg"];
//    UIImage *image = [UIImage imageWithContentsOfFile:filePath];
    
    self.photoView.image = photo.image;
}




@end
