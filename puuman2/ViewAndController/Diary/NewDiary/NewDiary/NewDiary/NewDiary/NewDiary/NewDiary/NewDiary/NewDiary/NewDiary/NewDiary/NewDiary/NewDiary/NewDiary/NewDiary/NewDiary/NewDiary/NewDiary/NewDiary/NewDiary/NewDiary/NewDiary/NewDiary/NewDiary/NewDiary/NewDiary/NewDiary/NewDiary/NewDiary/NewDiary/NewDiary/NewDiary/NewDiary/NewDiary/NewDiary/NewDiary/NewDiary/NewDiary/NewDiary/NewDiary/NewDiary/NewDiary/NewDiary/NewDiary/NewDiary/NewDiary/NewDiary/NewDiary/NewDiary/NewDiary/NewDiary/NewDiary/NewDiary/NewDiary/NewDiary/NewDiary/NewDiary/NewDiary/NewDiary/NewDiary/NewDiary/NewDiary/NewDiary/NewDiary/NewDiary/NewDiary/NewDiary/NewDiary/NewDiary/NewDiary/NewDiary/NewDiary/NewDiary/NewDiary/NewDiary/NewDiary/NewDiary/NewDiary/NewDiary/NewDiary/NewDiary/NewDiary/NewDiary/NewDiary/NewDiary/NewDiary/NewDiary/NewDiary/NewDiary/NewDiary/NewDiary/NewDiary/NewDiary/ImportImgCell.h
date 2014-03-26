//
//  ImportImgCell.h
//  PuumanForPhone
//
//  Created by 祁文龙 on 14-1-11.
//  Copyright (c) 2014年 Declan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AssetsLibrary/AssetsLibrary.h>
@protocol ImporImgDelegate;
@interface ImportImgCell : UIView
{
    UIImageView *imageView;
    UIImageView *flag;
    UIButton *selectBtn;
    
}
@property(assign,nonatomic) id<ImporImgDelegate> delegate;
@property(retain,nonatomic) ALAsset *asset;
@property(assign,nonatomic) BOOL selected;
@property(assign,nonatomic) NSInteger flagNum;
- (void)setImg:(UIImage *)img;
@end

@protocol ImporImgDelegate <NSObject>

- (void)clickedWithAdd:(BOOL)add andFlag:(NSInteger)num;

@end