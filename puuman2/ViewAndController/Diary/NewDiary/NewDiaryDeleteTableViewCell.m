//
//  NewDiaryDeleteTableViewCell.m
//  puuman2
//
//  Created by Ra.（祁文龙） on 14-3-7.
//  Copyright (c) 2014年 AFITC. All rights reserved.
//

#import "NewDiaryDeleteTableViewCell.h"
#import "UIImage+CroppedImage.h"

@implementation NewDiaryDeleteTableViewCell
@synthesize index = _index;
@synthesize img = _img;
@synthesize delegate =_delegate;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
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

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setImg:(UIImage *)img
{
    _img = img;
    img = [UIImage croppedImage:img WithHeight:224 andWidth:224];
    
    [imgView setImage:img];
    
}



- (void)deleteBtnPressed
{
    [_delegate deleteWithIndex:_index];
}

@end
