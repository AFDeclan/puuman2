//
//  BabyInfoViewController.m
//  puuman2
//
//  Created by Ra.（祁文龙） on 14-3-1.
//  Copyright (c) 2014年 AFITC. All rights reserved.
//

#import "BabyInfoViewController.h"
#import "MainTabBarController.h"
#import "LoginViewController.h"
#import "BabyData.h"


 NSString *bornselectedBtnImgs[4] = {@"btn_body1_baby.png",@"btn_vac1_baby.png",@"btn_equip1_baby.png",@"btn_bank1_baby.png"};
 NSString *bornunselectedBtnImgs[4] = {@"btn_body2_baby.png",@"btn_vac2_baby.png",@"btn_equip2_baby.png",@"btn_bank2_baby.png"};
 NSString *unbornselectedBtnImgs[4] = {@"btn_pre1_baby.png",@"btn_Bpre1_baby.png",@"btn_equip1_baby.png",@"btn_bank1_baby.png"};
 NSString *unbornunselectedBtnImgs[4] = {@"btn_pre2_baby.png",@"btn_Bpre2_baby.png",@"btn_equip2_baby.png",@"btn_bank2_baby.png"};
const BabyInfoButtonType bornBtnType[4] = {kBodyButton,kVaccineButton,kPropButton,kPuumanButton};
const BabyInfoButtonType unbornBtnType[4] = {kPreButton,kBpreButton,kPropButton,kPuumanButton};

@interface BabyInfoViewController ()

@end

@implementation BabyInfoViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        [MyNotiCenter addObserver:self selector:@selector(updateBabyDate) name:Noti_BabyDataUpdated object:nil];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
   	// Do any additional setup after loading the view.
   
}


- (void)viewWillAppear:(BOOL)animated
{
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

- (void)initialization
{
    bgImageView = [[UIImageView alloc] init];
    [bgImageView setBackgroundColor:[UIColor clearColor]];
    [self.view addSubview:bgImageView];
    babyInfoView = [[BabyInfoView alloc] initWithFrame:CGRectMake(80, 0, 540, 160)];
    [babyInfoView resetBabyInfo];
    [self.view addSubview:babyInfoView];
    
    modifyBtn = [[ColorButton alloc] init];
    [modifyBtn initWithTitle:@"修改" andIcon:[UIImage imageNamed:@"icon_fix_baby.png"] andButtonType:kGrayLeft];
    [modifyBtn addTarget:self action:@selector(moadifyBabyInfo) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:modifyBtn];
    [self initWithButtonsView];
    
}


- (void)initWithButtonsView
{
    controlBtnsView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 64, 384)];
    [controlBtnsView setBackgroundColor:[UIColor clearColor]];
    [self.view addSubview:controlBtnsView];
    for (int i = 0; i <4; i++) {
            BabyInfoButton *babyBtn = [[BabyInfoButton alloc] init];
            [babyBtn setBackgroundColor:[UIColor clearColor]];
            [controlBtnsView addSubview:babyBtn];
            [babyBtn addTarget:self action:@selector(pressedControlBtn:) forControlEvents:UIControlEventTouchUpInside];
            SetViewLeftUp(babyBtn, 0, 96*i);
        
        if ([[BabyData sharedBabyData] babyHasBorned]) {
             [babyBtn setSelectedImg:[UIImage imageNamed:bornselectedBtnImgs[i]] andUnselectedImg:[UIImage imageNamed:bornunselectedBtnImgs[i]]];
             [babyBtn setType:bornBtnType[i]];
        }else{
            [babyBtn setSelectedImg:[UIImage imageNamed:unbornselectedBtnImgs[i]] andUnselectedImg:[UIImage imageNamed:unbornunselectedBtnImgs[i]]];
            [babyBtn setType:unbornBtnType[i]];
        }
        if (i == 0) {
            acticeBtn = babyBtn;
            [babyBtn selected];
            [self pressedControlBtn:babyBtn];
        }else{
            [babyBtn unSelected];
        }

    }
}

- (void)pressedControlBtn:(BabyInfoButton *)sender
{
    [acticeBtn unSelected];
    [sender selected];
    acticeBtn = sender;
    switch (sender.type) {
        case kBodyButton:
        {
            if (!bodyView) {
                bodyView = [[BabyBodyView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
                [bodyView setBackgroundColor:[UIColor clearColor]];
               
            }
             [self.view addSubview:bodyView];
            [bodyView setAlpha:1];
            if (vaccineView) {
                [vaccineView setAlpha:0];
            }
            if (puumanView) {
                [puumanView setAlpha:0];
            }
            if (propView) {
                [propView setAlpha:0];
            }
            
        }
            break;
        case kVaccineButton:
        {
            if (!vaccineView) {
                vaccineView = [[BabyVaccineView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
                [vaccineView setBackgroundColor:[UIColor clearColor]];
               
            }
            [vaccineView setAlpha:1];
             [self.view addSubview:vaccineView];
            if (bodyView) {
                [bodyView setAlpha:0];
            }
            if (puumanView) {
                [puumanView setAlpha:0];
            }
            if (propView) {
                [propView setAlpha:0];
            }
            
        }
            break;
        case kPropButton:
        {
            if (!propView) {
                propView  = [[BabyPropView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
                [propView setBackgroundColor:[UIColor clearColor]];
              
            }
              [self.view addSubview:propView];
            [propView setAlpha:1];
            if (bodyView) {
                [bodyView setAlpha:0];
            }
            if (vaccineView) {
                [vaccineView setAlpha:0];
            }
            if (puumanView) {
                [puumanView setAlpha:0];
            }
            if (preView) {
                [preView setAlpha:0];
            }
       
            
        }
            break;
        case kPuumanButton:
        {
            if (!puumanView) {
                puumanView  = [[BabyPuumanView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
                [puumanView setBackgroundColor:[UIColor clearColor]];
                
            }
            [self.view addSubview:puumanView];
            [puumanView setAlpha:1];
            [puumanView setNums];
            if (bodyView) {
                [bodyView setAlpha:0];
            }
            if (vaccineView) {
                [vaccineView setAlpha:0];
            }
            if (propView) {
                [propView setAlpha:0];
            }
            if (preView) {
                [preView setAlpha:0];
            }
         
        }
            break;
        case kBpreButton:
        {
            if (!preView) {
                preView  = [[BabyPreView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
                [preView setBackgroundColor:[UIColor clearColor]];
                
                [preView setColumnImgBMode:YES];
                [preView scrollToToday];
           
            }else{
                [preView setColumnImgBMode:YES];
                if (selectType != kPreButton) {
                    [preView scrollToToday];
                }
                
            }
            [self.view addSubview:preView];
            [preView setAlpha:1];
            
            if (puumanView) {
                [puumanView setAlpha:0];
            }
            if (propView) {
                [propView setAlpha:0];
            }
          
        }
            break;
        case kPreButton:
        {
            if (!preView) {
                preView  = [[BabyPreView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
                [preView setBackgroundColor:[UIColor clearColor]];
                
                [preView setColumnImgBMode:NO];
                [preView scrollToToday];
            }else{
                [preView setColumnImgBMode:NO];
                if (selectType != kBpreButton ) {
                    [preView scrollToToday];
                }
            }
            [self.view addSubview:preView];
            [preView setAlpha:1];
            
            if (puumanView) {
                [puumanView setAlpha:0];
            }
            if (propView) {
                [propView setAlpha:0];
            }
         
        }
            break;
        default:
            break;
    }
    
    selectType = sender.type;
}



//竖屏
-(void)setVerticalFrame
{
    if (bodyView) {
        [bodyView setVerticalFrame];
    }
    if (vaccineView) {
        [vaccineView setVerticalFrame];
    }
    
    if (puumanView) {
        [puumanView setVerticalFrame];
    }
    if (propView) {
        [propView setVerticalFrame];
    }
    if (preView) {
        [preView setVerticalFrame];
    }
   
    SetViewLeftUp(controlBtnsView, 688, 176);
    SetViewLeftUp(modifyBtn, 640, 40);
    SetViewLeftUp(babyInfoView, 114, 16);
    [bgImageView setFrame:CGRectMake(80, 16, 672, 992)];
    [bgImageView setImage:[UIImage imageNamed:@"paper_baby.png"]];
}

//横屏
-(void)setHorizontalFrame
{
    if (bodyView) {
         [bodyView setHorizontalFrame];
    }
   
    if (vaccineView) {
        [vaccineView setHorizontalFrame];
    }
    if (puumanView) {
        [puumanView setHorizontalFrame];
    }
    if (propView) {
        [propView setHorizontalFrame];
    }
    if (preView) {
        [preView setHorizontalFrame];
    }
  
    SetViewLeftUp(controlBtnsView, 944, 176);
    SetViewLeftUp(modifyBtn, 896, 40);
    SetViewLeftUp(babyInfoView, 242, 16);
    [bgImageView setFrame:CGRectMake(80, 16, 928, 736)];
    [bgImageView setImage:[UIImage imageNamed:@"paper_h_baby.png"]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)moadifyBabyInfo
{
    LoginViewController *modifyInfoVC = [[LoginViewController alloc] initWithNibName:nil bundle:nil];
    [self.view addSubview:modifyInfoVC.view];
    [modifyInfoVC setControlBtnType:kCloseAndFinishButton];
    [modifyInfoVC setTitle:@"欢迎使用扑满日记！" withIcon:nil];
    [modifyInfoVC loginSetting];
    [modifyInfoVC show];

}

- (void)updateBabyDate
{
    [self refresh];
}

- (void)refresh
{
    selectType = kPreButton;
    for (UIView *view in self.view.subviews) {
        [view removeFromSuperview];
    }
    [self initialization];
    [self.view setBackgroundColor:[UIColor clearColor]];
    if([MainTabBarController sharedMainViewController].isVertical)
    {
        [self setVerticalFrame];
    }else
    {
        [self setHorizontalFrame];
    }
    if (bodyView) {
        [bodyView refresh];
    }
    if (vaccineView) {
        [vaccineView refresh];
    }
    if (puumanView) {
        [puumanView refresh];
    }
   
}

@end
