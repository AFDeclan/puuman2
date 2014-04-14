//
//  InsuranceInfoViewController.m
//  puuman2
//
//  Created by Ra.（祁文龙） on 14-4-14.
//  Copyright (c) 2014年 AFITC. All rights reserved.
//

#import "InsuranceInfoViewController.h"
#import "AFDataStore.h"
#import "MainTabBarController.h"
#import "CustomAlertViewController.h"

@interface InsuranceInfoViewController ()

@end

@implementation InsuranceInfoViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        UITapGestureRecognizer *gestureRecognizer= [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(remove)];
        [_content addGestureRecognizer:gestureRecognizer];
        _scrollView = [[UIScrollView alloc] init];
        _scrollView.backgroundColor = [UIColor clearColor];
        _scrollView.frame = CGRectMake(0, 0, 768, 1024);
        [_content addSubview:_scrollView];
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

- (void)setInfoUrl:(NSString *)url
{
    _url = url;
    NSData *introImgData = [[AFDataStore sharedStore] getDataFromUrl:url delegate:self];
    if (introImgData)
        _infoImg = [UIImage imageWithData:introImgData];
    else
    {
       // [MainViewController showHudCanCancel:@"数据加载中..."];
        [MyNotiCenter addObserver:self selector:@selector(remove) name:Noti_HudCanceled object:nil];
    }
    [self showImg];
}

- (void)dataDownloadEnded:(NSData *)data forUrl:(NSString *)url
{
   // [MainViewController hideHud];
    if (data)
    {
        _infoImg = [UIImage imageWithData:data];
        [self showImg];
    }
    else
    {
        
        [CustomAlertViewController showAlertWithTitle:@"网络不给力哦~" confirmRightHandler:^{
                 [self remove];
        }];


    }
}

- (void)remove
{
    [[AFDataStore sharedStore] removeDelegate:self forURL:_url];
    [MyNotiCenter removeObserver:self];
    [self hidden];
   
}

//竖屏
-(void)setVerticalFrame
{
    [super setVerticalFrame];
    [_content setFrame:CGRectMake(0, 0, 768, 1024)];
    [_scrollView setFrame:CGRectMake(0, 0, 768, 1024)];
}
//横屏
-(void)setHorizontalFrame
{
    [super setHorizontalFrame];
    [_content setFrame:CGRectMake(0, 0, 1024, 768)];
    [_scrollView setFrame:CGRectMake(128, 0, 768, 768)];
}


- (void)showImg
{
    [_scrollView setContentSize:CGSizeMake(_infoImg.size.width/2, _infoImg.size.height/2)];
    UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, _infoImg.size.width/2, _infoImg.size.height/2)];
    imgView.image = _infoImg;
    [_scrollView addSubview:imgView];
}

- (void)show
{
    [bgView setAlpha:0];
    [UIView animateWithDuration:0.4 animations:^{
        [bgView setAlpha:0.3];
    }];
    [_content showInFrom:kAFAnimationLeft inView:self.view withFade:YES duration:0.5 delegate:self startSelector:nil stopSelector:nil];
}

- (void)hidden
{
    [UIView animateWithDuration:0.4 animations:^{
        [bgView setAlpha:0];
    }];
    [_content hiddenOutTo:kAFAnimationLeft inView:self.view withFade:YES duration:0.5 delegate:self startSelector:nil stopSelector:@selector(finishOut)];
    
}

- (void)finishOut
{
    [super dismiss];
    [self.delegate popViewfinished];
    [self.view removeFromSuperview];
}

@end
