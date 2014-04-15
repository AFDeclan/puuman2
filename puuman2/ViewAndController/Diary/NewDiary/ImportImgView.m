//
//  ImportImgView.m
//  puuman2
//
//  Created by Ra.（祁文龙） on 14-4-15.
//  Copyright (c) 2014年 AFITC. All rights reserved.
//

#import "ImportImgView.h"
#import "UIImage+CroppedImage.h"

@implementation ImportImgView

@synthesize asset = _asset;
@synthesize delegate = _delegate;
@synthesize flagNum = _flagNum;
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
         [self initialization];
    }
    return self;
}

- (void)initialization
{
    imageView  = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    [imageView setBackgroundColor:[UIColor clearColor]];
//    flag = [[UIImageView alloc] initWithFrame:CGRectMake((self.frame.size.width - 32)/2, (self.frame.size.height - 32)/2, 32, 32)];
//    [flag setImage:[UIImage imageNamed:@"check_diary.png"]];
    selectBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    [selectBtn addTarget:self action:@selector(clicked) forControlEvents:UIControlEventTouchUpInside];
    [selectBtn setBackgroundColor:[UIColor clearColor]];
    [self addSubview:imageView];
  //  [self addSubview:flag];
    [self addSubview:selectBtn];
  
}

- (void)setImg:(UIImage *)img
{
    img = [UIImage croppedImage:img WithHeight:self.frame.size.height*2 andWidth:self.frame.size.width*2];
    [imageView setImage:img];
}

- (void)clicked
{
    
   [_delegate clickedWithAsset:_asset];
    
}
@end
