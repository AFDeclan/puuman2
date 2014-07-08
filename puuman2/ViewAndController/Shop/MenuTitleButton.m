//
//  MenuTitleButton.m
//  puuman2
//
//  Created by Ra.（祁文龙） on 14-7-1.
//  Copyright (c) 2014年 AFITC. All rights reserved.
//

#import "MenuTitleButton.h"
#import "ShopModel.h"
#import "UniverseConstant.h"

@implementation MenuTitleButton
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
    return  [self initWithFrame:CGRectMake(0, 0, 216, 64)];
}
- (void)initialization
{
    iconView = [[UIImageView alloc] initWithFrame:CGRectMake(24, 20, 24, 24)];
    [self addSubview:iconView];
    titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 160, 64)];
    [titleLabel setFont:PMFont3];
    [titleLabel setTextColor:PMColor7];
    [titleLabel setBackgroundColor:[UIColor clearColor]];
    [self addSubview:titleLabel];
}

- (void)setFlagNum:(NSInteger)flagNum
{
    _flagNum = flagNum;
    if (flagNum == -1) {
        [iconView setImage:nil];
        [titleLabel setText:@"为您推荐"];
        SetViewLeftUp(titleLabel, 56, 0);
        self.backgroundColor = PMColor6;
        
    }else{
        [iconView setImage:[ShopModel iconForSectionAtIndex:flagNum]];
        [titleLabel setText:[ShopModel titleForSectionAtIndex:flagNum]];
        SetViewLeftUp(titleLabel, 52, 0);
        if (flagNum == [ShopModel sharedInstance].sectionIndex) {
            self.backgroundColor = PMColor5;
            self.enabled = NO;
        }else{
            self.backgroundColor = PMColor6;
            self.enabled = YES;
            
        }
    }
    
    
    
}

- (void)showSubView
{
    self.enabled = NO;
    if (_flagNum != 0) {
        [UIView animateWithDuration:0.5 animations:^{
            
            self.backgroundColor = PMColor5;
            
        }];
    }
    
}

- (void)hiddenSubView
{
    self.enabled = YES;
    if (_flagNum != 0)
    {
        [UIView animateWithDuration:0.5 animations:^{
            self.backgroundColor = PMColor6;
            
        }];
    }
    
}


@end
