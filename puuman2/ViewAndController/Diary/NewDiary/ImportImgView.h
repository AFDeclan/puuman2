//
//  ImportImgView.h
//  puuman2
//
//  Created by Ra.（祁文龙） on 14-4-15.
//  Copyright (c) 2014年 AFITC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AssetsLibrary/AssetsLibrary.h>
@protocol ImportImgDelegate;
@interface ImportImgView : UIView
{
    UIImageView *imageView;
   // UIImageView *flag;
    UIButton *selectBtn;
    
}
@property(assign,nonatomic) id<ImportImgDelegate> delegate;
@property(retain,nonatomic) ALAsset *asset;
@property(assign,nonatomic) NSInteger flagNum;
- (void)setImg:(UIImage *)img;
@end

@protocol ImportImgDelegate <NSObject>

- (void)clickedWithAsset:(ALAsset *)asset;

@end
