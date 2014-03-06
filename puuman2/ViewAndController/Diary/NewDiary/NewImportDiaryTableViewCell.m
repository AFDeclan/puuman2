//
//  NewImportDiaryTableViewCell.m
//  puuman2
//
//  Created by Ra.（祁文龙） on 14-3-5.
//  Copyright (c) 2014年 AFITC. All rights reserved.
//

#import "NewImportDiaryTableViewCell.h"

@implementation NewImportDiaryTableViewCell
@synthesize index = _index;
@synthesize image = _image;
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

- (void)setImage:(UIImage *)image
{
    _image = image;
    [imgView setImage:image];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)deleteBtnPressed
{
    [_delegate deleteWithIndex:_index];
}

@end
