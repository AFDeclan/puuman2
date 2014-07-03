//
//  BabyInfoPropViewCell.m
//  puuman2
//
//  Created by AF_Bigwaves on 14-7-2.
//  Copyright (c) 2014年 AFITC. All rights reserved.
//

#import "BabyInfoPropViewCell.h"
#import "MainTabBarController.h"
#import "UniverseConstant.h"

@implementation BabyInfoPropViewCell

@synthesize delegate = _delegate;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
       // [showAndHiddenBtn setAlpha:0];
        [self initialization];
        [self initWithLeftView];
        [self initWithRightView];
    }
    return self;
}


- (void)initialization
{
    
    leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 96, 807, 672)];
    [leftView setBackgroundColor:[UIColor whiteColor]];
    [self.contentView addSubview:leftView];
    rightView = [[UIView alloc] initWithFrame:CGRectMake(807,96,217, 672)];
    [rightView setBackgroundColor:[UIColor clearColor]];
    [self.contentView addSubview:rightView];
    
}
- (void)initWithLeftView
{
    
    babyPropView = [[PropView alloc] initWithFrame:CGRectMake(220, 140, 544, 448)];
    [leftView addSubview:babyPropView];
    UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [leftBtn setFrame:CGRectMake(0, 0, 47, 672)];
    [leftBtn setBackgroundColor:PMColor6];
    [leftBtn setImage:[UIImage imageNamed:@"back_left_babyInfo.png"] forState:UIControlStateNormal];
    [leftBtn addTarget:self action:@selector(leftBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [leftView addSubview:leftBtn];
    
    
}

- (void)initWithRightView
{
   
}

- (void)leftBtnClick
{

    [_delegate backTheBornView];

}

- (void)refresh
{
    
}
//-(void)setVerticalFrame
//{
//    //[super setVerticalFrame];
//   // [leftView setFrame:CGRectMake(-216, 0, 256, 832)];
//    // [showAndHiddenBtn setAlpha:1];
//    SetViewLeftUp(babyPropView, 32, 192);
//    
//}
//
//-(void)setHorizontalFrame
//{
//   // [super setHorizontalFrame];
//    ///[leftView setFrame:CGRectMake(0, 0, 216, 576)];
//    // [showAndHiddenBtn setAlpha:0];
//    SetViewLeftUp(babyPropView, 160, 64);
//    
//}
//

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
