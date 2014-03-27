//
//  ShopViewController.m
//  puuman2
//
//  Created by Ra.（祁文龙） on 14-3-1.
//  Copyright (c) 2014年 AFITC. All rights reserved.
//

#import "ShopViewController.h"
#import "MainTabBarController.h"
#import "UniverseConstant.h"
#import "ColorsAndFonts.h"

@interface ShopViewController ()

@end

@implementation ShopViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated
{
    if([MainTabBarController sharedMainViewController].isVertical)
    {
        [self setVerticalFrame];
    }else
    {
        [self setHorizontalFrame];
    }
    [self refresh];
    [[NSNotificationCenter defaultCenter]
     addObserver:self selector:@selector(setHorizontalFrame) name:NOTIFICATION_Horizontal object:nil];
    [[NSNotificationCenter defaultCenter]
     addObserver:self selector:@selector(setVerticalFrame) name:NOTIFICATION_Vertical object:nil];
    
}

- (void)viewDidDisappear:(BOOL)animated
{
   
    [[NSNotificationCenter defaultCenter] removeObserver:self  name:NOTIFICATION_Horizontal object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:NOTIFICATION_Vertical object:nil];
    
    
}


- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
      [self.view setBackgroundColor:[UIColor clearColor]];
     [self initialization];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)initialization
{
    bg_topImageView = [[UIImageView alloc] init];
    [bg_topImageView setBackgroundColor:[UIColor clearColor]];
    [self.view addSubview:bg_topImageView];
    bg_rightImageView = [[UIImageView alloc] init];
    [bg_rightImageView setBackgroundColor:[UIColor clearColor]];
    [self.view addSubview:bg_rightImageView];
    rectWareBtn = [[AFSelecedTextImgButton alloc] initWithFrame:CGRectMake(0, 0, 64, 96)];
    [rectWareBtn setSelectedImg:[UIImage imageNamed:@"btn_rec1_shop"] andUnselectedImg:[UIImage imageNamed:@"btn_rec2_shop"]];
    [rectWareBtn addTarget:self action:@selector(rectWareBtnPressed) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:rectWareBtn];
    
    allWareBtn = [[AFSelecedTextImgButton alloc] initWithFrame:CGRectMake(0, 0, 64, 96)];
    [allWareBtn setSelectedImg:[UIImage imageNamed:@"btn_all1_shop.png"] andUnselectedImg:[UIImage imageNamed:@"btn_all2_shop.png"]];
    [allWareBtn addTarget:self action:@selector(allWareBtnPressed) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:allWareBtn];
    
    searchBtn = [[ColorButton alloc] init];
    [searchBtn initWithTitle:@"搜索" andIcon:[UIImage imageNamed:@"icon_search_shop.png"] andButtonType:kBlueLeft];
    [self.view addSubview:searchBtn];
    
    searchView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 184, 40)];
    [searchView setBackgroundColor:[UIColor clearColor]];
    [self.view addSubview:searchView];
    
    UIImageView *bg_searchView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 184, 40)];
    [bg_searchView setImage:[UIImage imageNamed:@"frame_search_shop.png"]];
    [searchView addSubview:bg_searchView];
    
    searchTextField = [[SearchTextField alloc] initWithFrame:CGRectMake(0, 0, 184, 40)];
    [searchTextField setBackgroundColor:[UIColor clearColor]];
    searchTextField.placeholder = @"搜索商品";
    [searchView addSubview:searchTextField];
    
}

//竖屏
-(void)setVerticalFrame
{
    if (rectView) {
        [rectView setFrame:CGRectMake(80, 80, 608, 944)];
        [rectView setVerticalFrame];
    }
    
    if (allView) {
        [allView setFrame:CGRectMake(80, 80, 608, 944)];
        [allView setVerticalFrame];
    }
    [bg_topImageView setFrame:CGRectMake(80, 16, 672, 64)];
    [bg_topImageView setImage:[UIImage imageNamed:@"paper_top_shop.png"]];
    [bg_rightImageView setFrame:CGRectMake(688, 80, 64, 944)];
    [bg_rightImageView setImage:[UIImage imageNamed:@"paper_right_shop.png"]];
    SetViewLeftUp(rectWareBtn, 688, 80);
    SetViewLeftUp(allWareBtn, 688, 176);
    SetViewLeftUp(searchBtn, 640, 28);
    SetViewLeftUp(searchView, 456, 28);

}

//横屏
-(void)setHorizontalFrame
{
    if (rectView) {
        [rectView setFrame:CGRectMake(80, 80, 864, 688)];
        [rectView setHorizontalFrame];
    }
    
    if (allView) {
        [allView setFrame:CGRectMake(80, 80, 864, 688)];
        [allView setHorizontalFrame];
    }
    [bg_topImageView setFrame:CGRectMake(80, 16, 928, 64)];
    [bg_topImageView setImage:[UIImage imageNamed:@"paper_top_h_shop.png"]];
    [bg_rightImageView setFrame:CGRectMake(944, 80, 64, 688)];
    [bg_rightImageView setImage:[UIImage imageNamed:@"paper_right_h_shop.png"]];
    SetViewLeftUp(rectWareBtn, 944, 80);
    SetViewLeftUp(allWareBtn, 944, 176);
    SetViewLeftUp(searchBtn, 896, 28);
    SetViewLeftUp(searchView, 712, 28);
}

- (void)rectWareBtnPressed
{
    [rectWareBtn selected];
    [allWareBtn unSelected];
    if (!rectView) {
        rectView = [[RectWareView alloc] initWithFrame:CGRectMake(80, 80, 0, 0)];
        
        [self.view addSubview:rectView];
        if ([MainTabBarController sharedMainViewController].isVertical) {
            [self setVerticalFrame];
        }else{
            [self setHorizontalFrame];
        }
    }
    
    [rectView setAlpha:0];
    [UIView animateWithDuration:0.5 animations:^{
        [rectView setAlpha:1];
        if (allView) {
            [allView setAlpha:0];
           
        }

    }];

}

- (void)allWareBtnPressed
{
    [allWareBtn selected];
    [rectWareBtn unSelected];
    if (!allView) {
        allView = [[AllWareView alloc] initWithFrame:CGRectMake(80, 80, 0, 0)];
        
        [self.view addSubview:allView];
        if ([MainTabBarController sharedMainViewController].isVertical) {
            [self setVerticalFrame];
        }else{
            [self setHorizontalFrame];
        }
    }
    
    [allView setAlpha:0];
    [UIView animateWithDuration:0.5 animations:^{
        [allView setAlpha:1];
        if (rectView) {
            [rectView setAlpha:0];
            
        }
        
    }];
}

-(void)refresh
{
    [self rectWareBtnPressed];
    
}

@end
