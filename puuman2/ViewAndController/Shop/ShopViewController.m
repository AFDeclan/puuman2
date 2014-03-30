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
#import "ShopCartViewController.h"

@interface ShopViewController ()

@end

@implementation ShopViewController



- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        [MyNotiCenter addObserver:self selector:@selector(allWareBtnPressed) name:Noti_ToAllSHop object:nil];
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
    [searchBtn addTarget:self action:@selector(search) forControlEvents:UIControlEventTouchUpInside];
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
    
    
    contentShop = [[ShopContentView alloc] initWithFrame:CGRectMake(80, 80, 0, 0)];
    [self.view addSubview:contentShop];
    [self rectWareBtnPressed];
    cartBtn  = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 56, 72)];
    [cartBtn setImage:[UIImage imageNamed:@"btn_cart_shop.png"] forState:UIControlStateNormal];
    [cartBtn addTarget:self action:@selector(showCart) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:cartBtn];
    
}


- (void)showCart
{
    ShopCartViewController *cartVC =[[ShopCartViewController alloc] initWithNibName:nil bundle:nil];
    [[MainTabBarController sharedMainViewController].view addSubview:cartVC.view];
    [cartVC setControlBtnType:kOnlyCloseButton];
    [cartVC setTitle:@"购物车" withIcon:[UIImage imageNamed:@"icon_cart_shop.png"]];
    [cartVC show];
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
    SetViewLeftUp(rectWareBtn, 688, 80);
    SetViewLeftUp(allWareBtn, 688, 176);
    SetViewLeftUp(searchBtn, 640, 28);
    SetViewLeftUp(searchView, 456, 28);
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
    SetViewLeftUp(rectWareBtn, 944, 80);
    SetViewLeftUp(allWareBtn, 944, 176);
    SetViewLeftUp(searchBtn, 896, 28);
    SetViewLeftUp(searchView, 712, 28);
    SetViewLeftUp(cartBtn, 936, 678);
}

- (void)rectWareBtnPressed
{
   [contentShop goToRectShop];
    [rectWareBtn selected];
    [allWareBtn unSelected];
   
}

- (void)allWareBtnPressed
{
    [contentShop goToAllShop];
    [allWareBtn selected];
    [rectWareBtn unSelected];
}

- (void)search
{
    [searchTextField resignFirstResponder];
    if (![searchTextField.text isEqualToString:@""]) {
        [ShopModel sharedInstance].searchKey = searchTextField.text;
        [searchTextField setPlaceholder:searchTextField.text];
        [searchTextField setText:@""];
    }else{
        if (![searchTextField.placeholder isEqualToString:@"搜索商品"]) {
             [ShopModel sharedInstance].searchKey = searchTextField.placeholder;
        }else{
            return;
        }
    }
    PostNotification(Noti_ToAllSHop, nil);
    PostNotification(Noti_ReloadShopMall, nil);
    
}

-(void)refresh
{
    [self rectWareBtnPressed];
    
}

@end
