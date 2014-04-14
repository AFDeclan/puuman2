//
//  InsuranCellSubview.m
//  puman
//
//  Created by 祁文龙 on 13-11-11.
//  Copyright (c) 2013年 创始人团队. All rights reserved.
//


#import "InsuranceCellSubview.h"
#import "ColorsAndFonts.h"
#import "MainTabBarController.h"

@implementation InsuranceCellSubview

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _insuranceImageView = [[UIImageView alloc] initWithFrame:CGRectMake(48, 0, 176, 176)];
        [self addSubview:_insuranceImageView];
        _maskView = [[UIImageView alloc] initWithFrame:CGRectMake(24, 0, 208, 256)];
        [self addSubview:_maskView];
        _maskView.userInteractionEnabled = YES;
        UITapGestureRecognizer *tapMask = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapped)];
        [_maskView addGestureRecognizer:tapMask];
        
        _nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(48, 192, 160, 48)];
        _nameLabel.backgroundColor = [UIColor clearColor];
        _nameLabel.numberOfLines = 0;
        _nameLabel.font = PMFont2;
        _nameLabel.textColor = PMColor1;
        _nameLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_nameLabel];
        
    }
    return self;
}
- (void)setNoInsurance
{
    [_insuranceImageView setImage:nil];
    [_maskView setImage:nil];
}
- (void)setInsurance:(NSDictionary *)insurance
{
    _insurance = insurance;
    if (!insurance)
    {
        [self setNoInsurance];
        return;
    }
    [_insuranceImageView setImage:[UIImage imageNamed:[insurance valueForKey:@"image"]]];
    [_maskView setImage:[UIImage imageNamed:@"bg_insure_shop.png"]];
    [_nameLabel setText:[_insurance valueForKey:@"name"]];
    
}
-(void)tapped
{
    NSString *url = [_insurance valueForKey:@"introduce"];
    if (!url) return;
    InsuranceInfoViewController *infoViewCon = [[InsuranceInfoViewController alloc] initWithNibName:nil bundle:nil];
    [[MainTabBarController sharedMainViewController].view addSubview:infoViewCon.view];
    [infoViewCon setInfoUrl:url];
    [infoViewCon setDelegate:self];
    [infoViewCon show];
}

- (void)popViewfinished
{
    
}

@end
