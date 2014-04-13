//
//  CustomPopViewController.m
//  puuman2
//
//  Created by Ra.（祁文龙） on 14-3-3.
//  Copyright (c) 2014年 AFITC. All rights reserved.
//

#import "CustomPopViewController.h"
#import "MainTabBarController.h"


@interface CustomPopViewController ()

@end

@implementation CustomPopViewController
@synthesize delegate =_delegate;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
       
        bgImgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 704, 608)];
        [bgImgView setImage:[UIImage imageNamed:@"bg_subpage.png"]];
        [_content addSubview:bgImgView];
       
        
        icon = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 24, 24)];
        [_content addSubview:icon];
        _titleLabel = [[UILabel alloc] init];
        [_titleLabel setTextColor:PMColor6];
        [_titleLabel setTextAlignment:NSTextAlignmentCenter];
        [_titleLabel setFont:PMFont1];
        [_content addSubview:_titleLabel];
        
        if ([[UIDevice currentDevice] orientation] == ALAssetOrientationUp ||
            [[UIDevice currentDevice] orientation] == ALAssetOrientationDown ||
            [[UIDevice currentDevice] orientation] == ALAssetOrientationUpMirrored ||
            [[UIDevice currentDevice] orientation] == ALAssetOrientationDownMirrored) {
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

- (void)setVerticalFrame
{
    [super setVerticalFrame];
    [_content setFrame:CGRectMake(32, 64, 704, 608)];
    
    
}

- (void)setHorizontalFrame
{
    [super setHorizontalFrame];
    [_content setFrame:CGRectMake(160, 16, 704, 608)];
    
}

- (void)setTitle:(NSString *)title withIcon:(UIImage *)image
{
    
    CGSize size = [title sizeWithFont:PMFont1];
    [_titleLabel setText:title];
    if (!image) {
        [_titleLabel setFrame:CGRectMake((704- size.width)/2, 36, size.width, 24)];
    }else{
        [icon setImage:image];
        SetViewLeftUp(icon,(704- size.width-4-24)/2,36 );
        [_titleLabel setFrame:CGRectMake(icon.frame.origin.x +2+24, 36, size.width, 24)];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setControlBtnType:(ControlBtnType)controlBtnType
{
    _controlBtnType = controlBtnType;
    switch (controlBtnType) {
        case kCloseAndFinishButton:
        {
            [self initFinishBtn];
            [self initCloseBtn];
        }
            
            break;
        case kOnlyFinishButton:
            [self initFinishBtn];
            break;
        case kOnlyCloseButton:
            [self initCloseBtn];
            break;
        case kNoneButton:
            break;
        default:
            break;
    }
    
}

- (void)initCloseBtn
{
    _closeBtn = [[UIButton alloc] initWithFrame:CGRectMake(24, 24, 48, 48)];
    [_closeBtn setImage:[UIImage imageNamed:@"btn_close1.png"] forState:UIControlStateNormal];
    [_closeBtn addTarget:self action:@selector(closeBtnPressed) forControlEvents:UIControlEventTouchUpInside];
    [_content addSubview:_closeBtn];
}

- (void)initFinishBtn
{
    _finishBtn = [[UIButton alloc] initWithFrame:CGRectMake(632, 24, 48, 48)];
    [_finishBtn setImage:[UIImage imageNamed:@"btn_finish1.png"] forState:UIControlStateNormal];
    [_finishBtn addTarget:self action:@selector(finishBtnPressed) forControlEvents:UIControlEventTouchUpInside];
    [_content addSubview:_finishBtn];
}

- (void)closeBtnPressed
{
     [self hidden];
}

- (void)finishBtnPressed
{
    [self hidden];
}

- (void)show
{
    [bgView setAlpha:0];
    [UIView animateWithDuration:0.4 animations:^{
        [bgView setAlpha:0.3];
    }];
    [_content showInFrom:kAFAnimationTop inView:self.view withFade:YES duration:0.5 delegate:self startSelector:nil stopSelector:nil];
 
}

- (void)hidden
{
    [UIView animateWithDuration:0.4 animations:^{
        [bgView setAlpha:0];
    }];
    [_content hiddenOutTo:kAFAnimationTop inView:self.view withFade:YES duration:0.5 delegate:self startSelector:nil stopSelector:@selector(finishOut)];
 
}

- (void)finishOut
{
    [super dismiss];
    [_delegate popViewfinished];
    [self.view removeFromSuperview];
}

@end
