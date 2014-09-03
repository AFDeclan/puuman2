//
//  TestShopViewController.m
//  puuman2
//
//  Created by Ra.（祁文龙） on 14-8-23.
//  Copyright (c) 2014年 AFITC. All rights reserved.
//

#import "TestShopViewController.h"
#import "MainTabBarController.h"
#import "UniverseConstant.h"
@interface TestShopViewController ()

@end

@implementation TestShopViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initialization];
    // Do any additional setup after loading the view.

    
}

- (void)initialization
{
    bg_topImageView = [[UIImageView alloc] init];
    [bg_topImageView setBackgroundColor:[UIColor clearColor]];
    [self.view addSubview:bg_topImageView];
    bg_rightImageView = [[UIImageView alloc] init];
    [bg_rightImageView setBackgroundColor:[UIColor clearColor]];
    [self.view addSubview:bg_rightImageView];
    
    contentShop = [[UIView alloc] initWithFrame:CGRectMake(80, 80, 0, 0)];
    [contentShop setBackgroundColor:PMColor5];
    [self.view addSubview:contentShop];
    
    myWebView = [[UIWebView alloc] init];
    [myWebView setScalesPageToFit:NO];
    [myWebView setOpaque:NO];
//    [myWebView setUserInteractionEnabled:NO];
   [[[myWebView subviews] objectAtIndex:0] setBounces:NO];
    NSURL *url =[NSURL URLWithString:kUrl_ShopEmptyH];
    NSURLRequest *request =[NSURLRequest requestWithURL:url];
    [myWebView loadRequest:request];
    myWebView.delegate =self;
    [myWebView setBackgroundColor:[UIColor clearColor]];
    [contentShop addSubview:myWebView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)viewWillAppear:(BOOL)animated
{

    [self refresh];
    [[NSNotificationCenter defaultCenter]
     addObserver:self selector:@selector(setHorizontalFrame) name:NOTIFICATION_Horizontal object:nil];
    [[NSNotificationCenter defaultCenter]
     addObserver:self selector:@selector(setVerticalFrame) name:NOTIFICATION_Vertical object:nil];

}

-(void)refresh
{
    if([MainTabBarController sharedMainViewController].isVertical)
    {
        [self setVerticalFrame];
    }else
    {
        [self setHorizontalFrame];
    }
}


- (void)viewDidDisappear:(BOOL)animated
{
    
    [[NSNotificationCenter defaultCenter] removeObserver:self  name:NOTIFICATION_Horizontal object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:NOTIFICATION_Vertical object:nil];
    
    
}

//竖屏
-(void)setVerticalFrame
{
    [bg_topImageView setFrame:CGRectMake(80, 16, 672, 64)];
    [bg_topImageView setImage:[UIImage imageNamed:@"paper_top_shop.png"]];
    [bg_rightImageView setFrame:CGRectMake(688, 80, 64, 944)];
    [bg_rightImageView setImage:[UIImage imageNamed:@"paper_right_shop.png"]];
    [contentShop setFrame:CGRectMake(80, 80, 608, 944)];
    [myWebView setFrame:CGRectMake(0, 0, 608, 944)];
    NSURL *url =[NSURL URLWithString:kUrl_ShopEmptyV];
    NSURLRequest *request =[NSURLRequest requestWithURL:url];
    [myWebView loadRequest:request];

}

//横屏
-(void)setHorizontalFrame
{
    [bg_topImageView setFrame:CGRectMake(80, 16, 928, 64)];
    [bg_topImageView setImage:[UIImage imageNamed:@"paper_top_h_shop.png"]];
    [bg_rightImageView setFrame:CGRectMake(944, 80, 64, 688)];
    [bg_rightImageView setImage:[UIImage imageNamed:@"paper_right_h_shop.png"]];
    [contentShop setFrame:CGRectMake(80, 80, 864, 688)];
    [myWebView setFrame:CGRectMake(0,0, 864, 688)];
    NSURL *url =[NSURL URLWithString:kUrl_ShopEmptyH];
    NSURLRequest *request =[NSURLRequest requestWithURL:url];
    [myWebView loadRequest:request];

}





@end
