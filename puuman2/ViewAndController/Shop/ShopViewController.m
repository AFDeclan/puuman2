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
static ShopViewController * instance;

@implementation ShopViewController


+ (ShopViewController *)sharedShopViewController
{
    if (!instance)
        instance = [[ShopViewController alloc] initWithNibName:nil bundle:nil];
    return instance;
}


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
    UITapGestureRecognizer *gestureRecognizer= [[UITapGestureRecognizer alloc] initWithTarget:self action:nil];
    [gestureRecognizer setDelegate:self];
    [self.view addGestureRecognizer:gestureRecognizer];
   
}



- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch{
    [contentShop hiddenMenuWithTapPoint:[touch locationInView:contentShop]];
    return YES;
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
    
    sectionView = [[ShopSectionView alloc] initWithFrame:CGRectMake(0, 0, 64, 96*3)];
    [self.view addSubview:sectionView];
    
       
    searchView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 184, 40)];
    [searchView setBackgroundColor:[UIColor clearColor]];
    [self.view addSubview:searchView];
    
    UIImageView *bg_searchView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 184, 40)];
    [bg_searchView setImage:[UIImage imageNamed:@"frame_search_shop.png"]];
    [searchView addSubview:bg_searchView];
    
    searchTextField = [[SearchTextField alloc] initWithFrame:CGRectMake(0, 0, 184, 40)];
    [searchTextField setBackgroundColor:[UIColor clearColor]];
    searchTextField.placeholder = @"搜索商品";
    searchTextField.returnKeyType = UIReturnKeySearch;
    [searchTextField setDelegate:self];
    [searchView addSubview:searchTextField];
    
    searchBtn = [[AFColorButton alloc] init];
    [searchBtn.title setText:@"搜索"];
    [searchBtn setIconImg:[UIImage imageNamed:@"icon_search_shop.png"] ];
    [searchBtn setColorType:kColorButtonBlueColor];
    [searchBtn setDirectionType:kColorButtonLeft];
    [searchBtn resetColorButton];
    [searchBtn addTarget:self action:@selector(search) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:searchBtn];
    
    contentShop = [[ShopContentView alloc] initWithFrame:CGRectMake(80, 80, 0, 0)];
    [self.view addSubview:contentShop];
    cartBtn  = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 56, 78)];
    [cartBtn setImage:[UIImage imageNamed:@"btn_cart_shop.png"] forState:UIControlStateNormal];
    [cartBtn addTarget:self action:@selector(showCart) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:cartBtn];

}


- (void)showCart
{
    ShopCartViewController *cartVC =[[ShopCartViewController alloc] initWithNibName:nil bundle:nil];
    [[MainTabBarController sharedMainViewController].view addSubview:cartVC.view];
    [cartVC setControlBtnType:kOnlyCloseButton];
    [cartVC show];
    [cartVC setDelegate:self];
    [cartVC.view addSubview:cartBtn];
}

- (void)popViewfinished
{
    [self.view addSubview:cartBtn];

}


//竖屏
-(void)setVerticalFrame
{
    [contentShop setFrame:CGRectMake(80, 80, 608, 944)];
    [contentShop setVerticalFrame];

    [bg_topImageView setFrame:CGRectMake(80, 16, 672, 64)];
    [bg_topImageView setImage:[UIImage imageNamed:@"paper_top_shop.png"]];
    [bg_rightImageView setFrame:CGRectMake(688, 80, 64, 944)];
    [bg_rightImageView setImage:[UIImage imageNamed:@"paper_right_shop.png"]];
    SetViewLeftUp(sectionView, 688, 100);
    SetViewLeftUp(searchBtn, 464, 28);
    SetViewLeftUp(searchView, 288, 28);
    SetViewLeftUp(cartBtn, 680, 678);
}

//横屏
-(void)setHorizontalFrame
{
    [contentShop setFrame:CGRectMake(80, 80, 864, 688)];
    [contentShop setHorizontalFrame];
    
    [bg_topImageView setFrame:CGRectMake(80, 16, 928, 64)];
    [bg_topImageView setImage:[UIImage imageNamed:@"paper_top_h_shop.png"]];
    [bg_rightImageView setFrame:CGRectMake(944, 80, 64, 688)];
    [bg_rightImageView setImage:[UIImage imageNamed:@"paper_right_h_shop.png"]];
  
    SetViewLeftUp(sectionView, 944, 100);

    SetViewLeftUp(searchBtn, 592, 28);
    SetViewLeftUp(searchView, 416, 28);
    SetViewLeftUp(cartBtn, 936, 678);
}



- (void)search
{
    [searchTextField resignFirstResponder];
}

-(void)refresh
{
    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self search];
    return YES;
}


@end
