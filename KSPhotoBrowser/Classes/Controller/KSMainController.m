//
//  KSMainController.m
//  KSPhotoBrowser
//
//  Created by lhj on 11/9/15.
//  Copyright © 2015 lhj. All rights reserved.
//

#import "KSMainController.h"
#import "KSPhotosController.h"

@interface KSMainController () <KSPhotosControllerDelegate>

@property (nonatomic, strong) NSArray *photos;

@end

@implementation KSMainController

static NSString * const ID = @"cell";

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:ID];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID forIndexPath:indexPath];
    
    cell.textLabel.text = @"照片库";
    
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    KSPhotosController *photosVc = [[KSPhotosController alloc] init];
    photosVc.photos = (NSMutableArray *)self.photos;
//    photosVc.delegate = self;
//    [self.navigationController pushViewController:photosVc animated:YES];
    [self presentViewController:photosVc animated:YES completion:nil];
}

//- (KSPhoto *)photosController:(KSPhotosController *)photosController photoAtIndex:(NSUInteger)index{
//    return [self.photos objectAtIndex:index];
//}

//- (NSInteger)numberOfPhotosInphotosController:(KSPhotosController *)photosController{
//    return self.photos.count;
//}

- (NSArray *)photos{
    if (!_photos) {
        NSString *path = [[NSBundle mainBundle] pathForResource:@"photos" ofType:@"plist"];
        NSArray *array = [NSArray arrayWithContentsOfFile:path];
        NSMutableArray *photos = [NSMutableArray arrayWithCapacity:array.count];
        for (NSDictionary *dict in array) {
            NSString *filePath = [[NSBundle mainBundle] pathForResource:dict[@"name"] ofType:@"jpg"];
            KSPhoto *photo = [KSPhoto photoWithImage:[UIImage imageWithContentsOfFile:filePath]];
            [photos addObject:photo];
        }
        _photos = [photos copy];
        
        
    }
    return _photos;
}


@end
