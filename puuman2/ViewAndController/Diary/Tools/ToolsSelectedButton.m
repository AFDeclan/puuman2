//
//  ToolsSelectedButton.m
//  PuumanForPhone
//
//  Created by Ra.（祁文龙） on 14-6-7.
//  Copyright (c) 2014年 Declan. All rights reserved.
//

#import "ToolsSelectedButton.h"
#import "UniverseConstant.h"
#import "UserInfo.h"
#import "UILabel+AdjustSize.h"

@implementation ToolsSelectedButton
@synthesize flagNum = _flagNum;
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self initialization];
        [MyNotiCenter addObserver:self selector:@selector(showTools:) name:Noti_ShowTools object:nil];
        [MyNotiCenter addObserver:self selector:@selector(hiddenTools:) name:Noti_HiddenTools object:nil];

    }
    return self;
}

- (id)init
{
    return [self initWithFrame:CGRectMake(0, 0, 240, 48)];
}

- (void)initialization
{
    iconFlag = [[UIImageView alloc] initWithFrame:CGRectMake(16, 14, 20, 20)];
    [self addSubview:iconFlag];
    
    triFlag = [[UIImageView alloc] initWithFrame:CGRectMake(204, 20, 16, 10)];
    [triFlag setImage:[UIImage imageNamed:@"tri_white_up.png"]];
    [self addSubview:triFlag];
    [triFlag setAlpha:1];
    triFlag2 = [[UIImageView alloc] initWithFrame:CGRectMake(204, 20, 16, 10)];
    [triFlag2 setImage:[UIImage imageNamed:@"tri_gray_up.png"]];
    [self addSubview:triFlag2];
    [triFlag2 setAlpha:0];

    titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(40, 0, 160, 48)];
    [titleLabel setBackgroundColor:[UIColor clearColor]];
    [titleLabel setTextColor:[UIColor whiteColor]];
    [self addSubview:titleLabel];
    [titleLabel setFont:PMFont2];
    [self setBackgroundColor:PMColor4];
}

- (void)hiddenTools:(NSNotification *)notification
{
     if (_flagNum < 3) {
        [UIView animateWithDuration:0.5 animations:^{
            [self setBackgroundColor:PMColor4];
            [titleLabel setTextColor:[UIColor whiteColor]];
            [triFlag setTransform:CGAffineTransformMakeRotation(0)];
            [triFlag2 setTransform:CGAffineTransformMakeRotation(0)];
            [triFlag setAlpha:1];
            [triFlag2 setAlpha:0];

        }completion:^(BOOL finished) {
            [self setEnabled:YES];
            
        }];
     }
 

}

- (void)showTools:(NSNotification *)notification
{

    if (_flagNum < 3) {
        if ([[notification object] integerValue] == _flagNum) {
            [UIView animateWithDuration:0.5 animations:^{
                [self setBackgroundColor:PMColor4];
                [titleLabel setTextColor:PMColor2];
                [triFlag setTransform:CGAffineTransformMakeRotation(M_PI)];
                [triFlag2 setTransform:CGAffineTransformMakeRotation(M_PI)];
                [triFlag setAlpha:0];
                [triFlag2 setAlpha:1];
            }completion:^(BOOL finished) {
                [self setEnabled:YES];
                
            }];
        }else{
            [UIView animateWithDuration:0.5 animations:^{
                [self setBackgroundColor:PMColor4];
                [titleLabel setTextColor:[UIColor whiteColor]];
                [triFlag setTransform:CGAffineTransformMakeRotation(0)];
                [triFlag2 setTransform:CGAffineTransformMakeRotation(0)];
                [triFlag setAlpha:1];
                [triFlag2 setAlpha:0];

            }completion:^(BOOL finished) {
                [self setEnabled:YES];
                
            }];
            
        }

    }

}

- (void)setFlagNum:(NSInteger)flagNum
{
    _flagNum = flagNum;
    switch (flagNum) {
        case 0:
        {
            NSString *parent = [UserInfo sharedUserInfo].identity == Father ? @"妈" : @"爸";
            NSString *nick;
            if ([[[UserInfo sharedUserInfo] babyInfo].Nickname isEqualToString:@""]) nick = @"宝宝"; else nick = [[UserInfo sharedUserInfo] babyInfo].Nickname;
            NSString *call = [NSString stringWithFormat:@"%@%@", nick, parent];
            [iconFlag setImage:[UIImage imageNamed:@"icon_dynamic.png"]];
            [titleLabel setText:[NSString stringWithFormat:@"%@的最新动态",call]];
            [titleLabel setAdjustsFontSizeToFitWidth:YES];
        }
           
            break;
        case 1:
            [iconFlag setImage:[UIImage imageNamed:@"icon_dynamic.png"]];
            [titleLabel setText:@"扑满金库"];
            break;
        case 2:
            [iconFlag setImage:[UIImage imageNamed:@"icon_dynamic.png"]];
            [titleLabel setText:@"宝宝日历"];
            break;
        case 3:
            [iconFlag setImage:[UIImage imageNamed:@"icon_dynamic.png"]];
            [titleLabel setTextColor:PMColor7];
            [triFlag setImage:[UIImage imageNamed:@"tri_blue_right.png"]];
            [titleLabel setText:@"设置"];
            break;
        default:
            break;
    }
}

- (void)dealloc
{
    [MyNotiCenter removeObserver:self];
}

@end
