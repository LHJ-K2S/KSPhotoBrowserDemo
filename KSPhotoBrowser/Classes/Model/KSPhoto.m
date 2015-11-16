//
//  KSPhoto.m
//  KSPhotoBrowser
//
//  Created by lhj on 11/9/15.
//  Copyright © 2015 lhj. All rights reserved.
//

#import "KSPhoto.h"

@implementation KSPhoto

- (instancetype)initWithName:(NSString *)name{
    if (self = [super init]) {
        self.name = name;
        [self getFullNameWithName:self.name];
    }
    return self;
}

+ (instancetype)photoWithName:(NSString *)name{
    return [[self alloc] initWithName:name];
}

- (instancetype)initWithDict:(NSDictionary *)dict{
    if (self = [super init]) {
        self.name = dict[@"name"];
        [self getFullNameWithName:self.name];
    }
    return self;
}
+ (instancetype)photoWithDict:(NSDictionary *)dict{
    return [[self alloc] initWithDict:dict];
}

- (instancetype)initWithImage:(UIImage *)image{
    if (self = [super init]) {
        self.image = image;
    }
    return self;
}
- (instancetype)initWithUrl :(NSString *)url{
    if (self = [super init]) {
        self.imageUrl = url;
    }
    return self;
}

+ (instancetype)photoWithImage:(UIImage *)image{
    return [[self alloc] initWithImage:image];
}
+ (instancetype)photoWithUrl:(NSString *)url{
    return [[self alloc] initWithUrl:url];
}



- (void)getFullNameWithName:(NSString *)name{
    NSString *cachesPath =  NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)[0];
    NSString *imgFullName = [cachesPath stringByAppendingPathComponent:name];
    self.fullName = imgFullName;
}

@end
