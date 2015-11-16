//
//  KSDetailCell.m
//  ihome
//
//  Created by lhj on 11/7/15.
//  Copyright © 2015 Boer. All rights reserved.
//

#import "KSDetailCell.h"
#import "KSPhoto.h"

@interface KSDetailCell () <UIScrollViewDelegate>





@end

@implementation KSDetailCell

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        UIScrollView *scrollView = [[UIScrollView alloc] init];
//        scrollView.alwaysBounceHorizontal = YES;
//        scrollView.alwaysBounceVertical = NO;
        scrollView.showsVerticalScrollIndicator = NO;
        scrollView.showsHorizontalScrollIndicator = NO;
        scrollView.maximumZoomScale = 4.0;
        scrollView.minimumZoomScale = 0.5;
        scrollView.delegate = self;
        scrollView.contentSize = self.bounds.size;
        scrollView.decelerationRate = UIScrollViewDecelerationRateNormal;
        
//       scrollView.decelerationRate = UIScrollViewDecelerationRateFast;
//        self.scrollView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;

        self.scrollView = scrollView;
        [self.contentView addSubview:scrollView];
        
        UIImageView *photoView = [[UIImageView alloc] init];
        [scrollView addSubview:photoView];
        photoView.contentMode = UIViewContentModeScaleAspectFit;
        photoView.clipsToBounds = YES;
        photoView.userInteractionEnabled = YES;

        
        self.photoView = photoView;
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    self.scrollView.frame = self.bounds;
    self.photoView.frame = self.bounds;

    
}

- (void)setPhoto:(KSPhoto *)photo{
    _photo = photo;
    

    
    self.photoView.image = photo.image;
}


#pragma mark <UIScrollViewDelegate>

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView{
    return self.photoView;
}

//- (void)scrollViewDidEndZooming:(UIScrollView *)scrollView withView:(UIView *)view atScale:(CGFloat)scale{
//    
//}
- (void)scrollViewDidZoom:(UIScrollView *)scrollView{
//    CGFloat x = (1 - [[self scrollView] zoomScale]) * self.bounds.size.width / 2;
//    CGFloat y = (1 - [[self scrollView] zoomScale]) * self.bounds.size.height / 2;
//    CGFloat width = [[self scrollView] zoomScale] * self.bounds.size.width;
//    CGFloat height = [[self scrollView] zoomScale] * self.bounds.size.height;
//    self.photoView.frame = CGRectMake(x,y, width, height);
//    self.scrollView.contentSize = self.scrollView.bounds.size;
}

//- (void)scrollViewDidEndZooming:(UIScrollView *)scrollView withView:(UIView *)view atScale:(CGFloat)scale{
//    
//    CGFloat width = view.bounds.size.width * scale;
//    CGFloat height = view.bounds.size.height * scale;
//    scrollView.contentSize = CGSizeMake(width, height);
//}



@end
