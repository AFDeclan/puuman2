//
//  SocialViewController.m
//  puuman2
//
//  Created by Ra.（祁文龙） on 14-3-1.
//  Copyright (c) 2014年 AFITC. All rights reserved.
//

#import "SocialViewController.h"
#import "MainTabBarController.h"
#import "UniverseConstant.h"
#import "ColorsAndFonts.h"

@interface SocialViewController ()

@end

@implementation SocialViewController

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
    [MyNotiCenter addObserver:self selector:@selector(inOrOutGroup:) name:Noti_InOrOutGroup object:nil];
}

- (void)viewDidDisappear:(BOOL)animated
{
    PostNotification(Noti_BottomInputViewHidden, nil);
    [[NSNotificationCenter defaultCenter] removeObserver:self  name:NOTIFICATION_Horizontal object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:NOTIFICATION_Vertical object:nil];
  
    
}


- (void)inOrOutGroup:(NSNotification *)notification
{
    if ([[notification object] boolValue]) {
        [leftBtn setAlpha:1];
        [rightBtn setAlpha:1];
    }else{
        [leftBtn setAlpha:0];
        [rightBtn setAlpha:0];
    }
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    selectedTopic = YES;
    [self.view setBackgroundColor:[UIColor clearColor]];
	// Do any additional setup after loading the view.
    [self initialization];
   
}

- (void)initialization
{
    bg_topImageView = [[UIImageView alloc] init];
    [bg_topImageView setBackgroundColor:[UIColor clearColor]];
    [self.view addSubview:bg_topImageView];
    bg_rightImageView = [[UIImageView alloc] init];
    [bg_rightImageView setBackgroundColor:[UIColor clearColor]];
    [self.view addSubview:bg_rightImageView];
    contnetView = [[SocialContentView alloc] init];
    [self.view addSubview:contnetView];
    leftBtn = [[ColorButton alloc] init];
    [leftBtn addTarget:self action:@selector(leftBtnPressed) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:leftBtn];
    
    rightBtn = [[ColorButton alloc] init];
    [rightBtn addTarget:self action:@selector(rightBtnPressed) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:rightBtn];
    topicBtn = [[AFSelecedTextImgButton alloc] initWithFrame:CGRectMake(0, 0, 64, 96)];
    [topicBtn setSelectedImg:[UIImage imageNamed:@"btn_topic1_topic.png"] andUnselectedImg:[UIImage imageNamed:@"btn_topic2_topic.png"]];
    [topicBtn addTarget:self action:@selector(topicBtnPressed) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:topicBtn];
    
    partnerBtn = [[AFSelecedTextImgButton alloc] initWithFrame:CGRectMake(0, 0, 64, 96)];
    [partnerBtn setSelectedImg:[UIImage imageNamed:@"btn_partner1_topic.png"] andUnselectedImg:[UIImage imageNamed:@"btn_partner2_topic.png"]];
    [partnerBtn addTarget:self action:@selector(partnerBtnPressed) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:partnerBtn];
    [self topicBtnPressed];
    


    
    
}


- (void)topicBtnPressed
{
    [leftBtn setAlpha:1];
    [rightBtn setAlpha:1];
    selectedTopic = YES;
    [topicBtn selected];
    [partnerBtn unSelected];
    [leftBtn initWithTitle:@"所有" andButtonType:kBlueLeft];
    [rightBtn initWithTitle:@"我参与的" andButtonType:kBlueRight];
    [self leftBtnPressed];

    
   
    
}

- (void)partnerBtnPressed
{
    
    selectedTopic = NO;
    [topicBtn unSelected];
    [partnerBtn selected];
    [leftBtn initWithTitle:@"数据" andButtonType:kBlueLeft];
    [rightBtn initWithTitle:@"闲聊" andButtonType:kBlueRight];
    [self leftBtnPressed];

}

- (void)leftBtnPressed
{
    [leftBtn selected];
    [leftBtn setEnabled:NO];
    [rightBtn unSelected];
    [rightBtn setEnabled:YES];
    if (selectedTopic) {
        [contnetView selectWithType:kAllTopicView];
    }else{
        [contnetView selectWithType:kPartnerDataView];
    }
}

- (void)rightBtnPressed
{
    [rightBtn selected];
    [rightBtn setEnabled:NO];
    [leftBtn unSelected];
    [leftBtn setEnabled:YES];
    if (selectedTopic) {
        [contnetView selectWithType:kMyTopicView];
    }else{
        [contnetView selectWithType:kPartnerChatView];
    }
}
//竖屏
-(void)setVerticalFrame
{
   
    [contnetView setFrame:CGRectMake(80, 80, 608, 944)];
    [contnetView setVerticalFrame];
    [bg_topImageView setFrame:CGRectMake(80, 16, 672, 64)];
    [bg_topImageView setImage:[UIImage imageNamed:@"paper_top_shop.png"]];
    [bg_rightImageView setFrame:CGRectMake(688, 80, 64, 944)];
    [bg_rightImageView setImage:[UIImage imageNamed:@"paper_right_shop.png"]];
    SetViewLeftUp(topicBtn, 688, 80);
    SetViewLeftUp(partnerBtn, 688, 176);
    SetViewLeftUp(leftBtn, 272, 28);
    SetViewLeftUp(rightBtn, 384, 28);
 
}

//横屏
-(void)setHorizontalFrame
{
   
    [contnetView setFrame:CGRectMake(80, 80, 864, 688)];
    [contnetView setHorizontalFrame];
    [bg_topImageView setFrame:CGRectMake(80, 16, 928, 64)];
    [bg_topImageView setImage:[UIImage imageNamed:@"paper_top_h_shop.png"]];
    [bg_rightImageView setFrame:CGRectMake(944, 80, 64, 688)];
    [bg_rightImageView setImage:[UIImage imageNamed:@"paper_right_h_shop.png"]];
    SetViewLeftUp(topicBtn, 944, 80);
    SetViewLeftUp(partnerBtn, 944, 176);
    SetViewLeftUp(leftBtn, 400, 28);
    SetViewLeftUp(rightBtn, 512, 28);

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)refresh
{
    [self topicBtnPressed];
    
}


@end
