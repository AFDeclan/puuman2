//
//  ImportImgCell.m
//  PuumanForPhone
//
//  Created by 祁文龙 on 14-1-11.
//  Copyright (c) 2014年 Declan. All rights reserved.
//

#import "ImportImgCell.h"

@implementation ImportImgCell
@synthesize selected =_selected;
@synthesize asset = _asset;
@synthesize delegate = _delegate;
@synthesize flagNum = _flagNum;
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self initialization];
        _selected = YES;
    }
    return self;
}
- (void)initialization
{
    imageView  = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    [imageView setBackgroundColor:[UIColor clearColor]];
    flag = [[UIImageView alloc] initWithFrame:CGRectMake(self.frame.size.width - 20, self.frame.size.height - 20, 16, 16)];
    [flag setImage:[UIImage imageNamed:@"icon_check_diary.png"]];
     selectBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    [selectBtn addTarget:self action:@selector(clicked) forControlEvents:UIControlEventTouchUpInside];
    [selectBtn setBackgroundColor:[UIColor clearColor]];
    [self addSubview:imageView];
    [self addSubview:flag];
    [self addSubview:selectBtn];
    self.selected = YES;
}
- (void)setImg:(UIImage *)img
{
    [imageView setImage:img];
}
- (void)clicked
{
    
    if (_selected) {
        [_delegate clickedWithAdd:NO andFlag:_flagNum];
        self.selected = NO;
    }else{
        [_delegate clickedWithAdd:YES andFlag:_flagNum];
        self.selected = YES;
    }
    
}
- (void )setSelected:(BOOL)selected
{
    _selected  = selected;
    if (selected) {
        [flag setAlpha:1];
        [imageView setAlpha:0.5];
    }else{
        [flag setAlpha:0];
        [imageView setAlpha:1];
    }
}


@end
