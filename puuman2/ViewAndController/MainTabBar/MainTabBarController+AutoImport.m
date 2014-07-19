//
//  MainTabBarController+AutoImport.m
//  puuman2
//
//  Created by Ra.（祁文龙） on 14-7-18.
//  Copyright (c) 2014年 AFITC. All rights reserved.
//

#import "MainTabBarController+AutoImport.h"

@implementation MainTabBarController (AutoImport)
- (void)initautoImportView
{
    
    if (improtAutoVC) {
        [improtAutoVC.view removeFromSuperview];
        improtAutoVC = nil;
    }
    improtAutoVC = [[AutoImportViewController alloc] initWithNibName:nil bundle:nil];
    [improtAutoVC setControlBtnType:kCloseAndFinishButton];
    [improtAutoVC setTitle:@"您好像拍了新的照片，是否导入？" withIcon:nil];
    
}

- (void)showAutoImportView
{
    
    if (improtAutoVC && !self.videoShowed) {
        [self.view addSubview:improtAutoVC.view];
        [improtAutoVC show];
    }
    
}

- (void)removeAutoImportView
{
    if (improtAutoVC) {
        [improtAutoVC.view removeFromSuperview];
        improtAutoVC = nil;
    }
    
}

@end
