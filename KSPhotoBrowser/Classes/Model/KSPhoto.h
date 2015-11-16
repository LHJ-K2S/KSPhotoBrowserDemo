//
//  KSPhoto.h
//  KSPhotoBrowser
//
//  Created by lhj on 11/9/15.
//  Copyright © 2015 lhj. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KSPhoto : NSObject

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *fullName;
@property (nonatomic, assign) BOOL selectState;
@property (nonatomic, assign) BOOL selectStateYES;

@property (nonatomic, strong) UIImage *image;
@property (nonatomic, strong) NSString *imageUrl;

- (instancetype)initWithName:(NSString *)name;
+ (instancetype)photoWithName:(NSString *)name;
- (instancetype)initWithDict:(NSDictionary *)dict;
+ (instancetype)photoWithDict:(NSDictionary *)dict;

- (instancetype)initWithImage:(UIImage *)image;
- (instancetype)initWithUrl :(NSString *)url;

+ (instancetype)photoWithImage:(UIImage *)image;
+ (instancetype)photoWithUrl:(NSString *)url;

@end
