//
//  BabyCustomTableViewCell.m
//  puuman2
//
//  Created by Ra.（祁文龙） on 14-7-5.
//  Copyright (c) 2014年 AFITC. All rights reserved.
//

#import "BabyCustomTableViewCell.h"

@implementation BabyCustomTableViewCell

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
    self.contentView.layer.masksToBounds = YES;
    rightView = [[UIView alloc] init];
    [rightView setBackgroundColor:[UIColor clearColor]];
    [self addSubview:rightView];
    leftView = [[UIView alloc] init];
    [leftView setBackgroundColor:[UIColor clearColor]];
    [self addSubview:leftView];
    [self setBackgroundColor:[UIColor clearColor]];
    showAndHiddenBtn = [[BabyInfoPageControlButton alloc] init];
    [showAndHiddenBtn addTarget:self action:@selector(showOrHidden) forControlEvents:UIControlEventTouchUpInside];
    [leftView addSubview:showAndHiddenBtn];

}

- (void)showOrHidden
{
    if (showAndHiddenBtn.isFold) {
        [self unfold];
    }else{
        [self fold];
    }
}

- (void)fold
{
    [showAndHiddenBtn foldWithDuration:0.5];
}

- (void)unfold
{
    [showAndHiddenBtn unfoldWithDuration:0.5];
}


- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


-(void)setVerticalFrame
{
}

-(void)setHorizontalFrame
{
}

@end
