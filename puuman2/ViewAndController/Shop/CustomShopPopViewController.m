//
//  CustomShopPopViewController.m
//  puuman2
//
//  Created by Ra.（祁文龙） on 14-7-17.
//  Copyright (c) 2014年 AFITC. All rights reserved.
//

#import "CustomShopPopViewController.h"
#import "UniverseConstant.h"
#import "MainTabBarController.h"

@interface CustomShopPopViewController ()

@end

@implementation CustomShopPopViewController
@synthesize delegate = _delegate;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        titleBg = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 760, 64)];
        [_content addSubview:titleBg];
        [titleBg setBackgroundColor:PMColor4];
        
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 688, 64)];
        [_titleLabel setTextColor:PMColor6];
        [_titleLabel setBackgroundColor:[UIColor clearColor]];
        [_titleLabel setTextAlignment:NSTextAlignmentCenter];
        [_titleLabel setFont:PMFont1];
        [_content setBackgroundColor:PMColor5];
        [_content addSubview:_titleLabel];
        _content.layer.masksToBounds = YES;
        _content.layer.cornerRadius = 48;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hidden)];
        [bgView addGestureRecognizer:tap];
        if ([MainTabBarController sharedMainViewController].isVertical) {
            [self setVerticalFrame];
        }else{
            [self setHorizontalFrame];
        }
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)show
{
    
    [bgView setAlpha:0];
    [UIView animateWithDuration:0.4 animations:^{
        [bgView setAlpha:0.3];
    }];
    [_content showInFrom:kAFAnimationRight inView:self.view withFade:YES duration:0.5 delegate:self startSelector:nil stopSelector:nil];
    
}

- (void)hidden
{
    if ([_delegate respondsToSelector:@selector(popStartHidden)]) {
        [_delegate popStartHidden];
    }
    [UIView animateWithDuration:0.4 animations:^{
        [bgView setAlpha:0];
    }];
    [_content hiddenOutTo:kAFAnimationRight inView:self.view withFade:YES duration:0.5 delegate:self startSelector:nil stopSelector:@selector(finishOut)];
}

- (void)finishOut
{
    [super dismiss];
    if ([_delegate respondsToSelector:@selector(popViewfinished)]) {
        [_delegate popViewfinished];
    }
    [self.view removeFromSuperview];
}


- (void)setVerticalFrame
{
    [super setVerticalFrame];
    [_content setFrame:CGRectMake(80, 16, 760, 1008)];
    
    
}

- (void)setHorizontalFrame
{
    [super setHorizontalFrame];
    [_content setFrame:CGRectMake(336, 16, 760, 752)];
    
}
@end
