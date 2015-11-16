//
//  UIView+K2SFrame.h
//  网易彩票test
//
//  Created by K2S on 15/7/21.
//  Copyright (c) 2015年 小码哥. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (K2SFrame)
// @property在分类里面只会自动生成get,set方法，并不会生成下划线的成员属性
//协议里面也可以类似的做法
@property (nonatomic, assign) CGFloat width;

@property (nonatomic, assign) CGFloat height;

@property (nonatomic, assign) CGFloat x;

@property (nonatomic, assign) CGFloat y;

@property (nonatomic, assign) CGFloat centerX;

@property (nonatomic, assign) CGFloat centerY;


@end
