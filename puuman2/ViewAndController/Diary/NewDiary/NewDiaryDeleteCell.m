//
// NewDiaryDeleteCell.m
//  puuman2
//
//  Created by Ra.（祁文龙） on 14-3-5.
//  Copyright (c) 2014年 AFITC. All rights reserved.
//

#import "NewDiaryDeleteCell.h"
#import "UIImage+CroppedImage.h"

@implementation NewDiaryDeleteCell
@synthesize index = _index;
@synthesize img = _img;
@synthesize delegate =_delegate;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initialization];
    }
    return self;
}


- (void)initialization
{
    [self setBackgroundColor:[UIColor clearColor]];
    
    _index = 0;
    imgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 16, 112, 112)];
    [self addSubview:imgView];
    delBtn = [[UIButton alloc] initWithFrame:CGRectMake(88, 8, 32, 32)];
    [delBtn setImage:[UIImage imageNamed:@"btn_delete3_diary.png"] forState:UIControlStateNormal];
    [delBtn addTarget:self action:@selector(deleteBtnPressed) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:delBtn];
}

- (void)setImg:(UIImage *)img
{
    _img = img;
    [imgView setImage:img];
}



- (void)deleteBtnPressed
{
    [_delegate deleteWithIndex:_index];
}

@end
