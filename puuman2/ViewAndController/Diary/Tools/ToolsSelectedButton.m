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
static NSString *titles[3] = {@"最新动态",@"扑满金库",@"宝宝日历"};

@implementation ToolsSelectedButton
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

- (id)init
{
    return [self initWithFrame:CGRectMake(0, 0, 240, 64)];
}

- (void)initialization
{
    iconFlag = [[UIImageView alloc] initWithFrame:CGRectMake(16, 22, 20, 20)];
    [self addSubview:iconFlag];
    
    triFlag = [[UIImageView alloc] initWithFrame:CGRectMake(204, 20, 16, 10)];
    [triFlag setImage:[UIImage imageNamed:@"tri_gray_up.png"]];
    [self addSubview:triFlag];
    [triFlag setAlpha:1];
  
    titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(40, 0, 160, 48)];
    [titleLabel setBackgroundColor:[UIColor clearColor]];
    [titleLabel setTextColor:PMColor2];
    [self addSubview:titleLabel];
    [titleLabel setFont:PMFont2];
    [self setBackgroundColor:[UIColor clearColor]];
}



- (void)setFlagNum:(NSInteger)flagNum
{
    _flagNum = flagNum;
    [titleLabel setText:titles[flagNum]];
}

- (void)foldTool
{
    
    [UIView animateWithDuration:0.5 animations:^{
        [triFlag setTransform:CGAffineTransformMakeRotation(0)];
    }];
    
    switch (_flagNum) {
        case 0:
        {
            [UIView animateWithDuration:0.5 animations:^{
                [self setAlpha:1];
            }];
        }
            break;
        case 1:
        {
        }
            break;
        case 2:
        {
            [UIView animateWithDuration:0.5 animations:^{
                [titleLabel setAlpha:1];
            }];
        }
            break;
        default:
            break;
    }
  
}

- (void)unFoldTool
{
    [UIView animateWithDuration:0.5 animations:^{
        [triFlag setTransform:CGAffineTransformMakeRotation(M_PI)];
    }];

    switch (_flagNum) {
        case 0:
        {
            [UIView animateWithDuration:0.5 animations:^{
                [self setAlpha:0];
            }];
        }
            break;
        case 1:
        {
           
        }
            break;
        case 2:
        {
            [UIView animateWithDuration:0.5 animations:^{
                [titleLabel setAlpha:0];
            }];
        }
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
