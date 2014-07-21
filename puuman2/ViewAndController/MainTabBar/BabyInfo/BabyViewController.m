//
//  BabyViewController.m
//  puuman2
//
//  Created by Ra.（祁文龙） on 14-7-19.
//  Copyright (c) 2014年 AFITC. All rights reserved.
//

#import "BabyViewController.h"
#import "UniverseConstant.h"
#import "MainTabBarController.h"

@interface BabyViewController ()

@end

@implementation BabyViewController
@synthesize babyView = _babyView;
@synthesize delegate = _delegate;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        [[NSNotificationCenter defaultCenter]
         addObserver:self selector:@selector(setHorizontalFrame) name:NOTIFICATION_Horizontal object:nil];
        [[NSNotificationCenter defaultCenter]
         addObserver:self selector:@selector(setVerticalFrame) name:NOTIFICATION_Vertical object:nil];
        [[NSNotificationCenter defaultCenter]
         addObserver:self selector:@selector(hidden) name:Noti_HiddenBabyView object:nil];
        [self initialization];
        
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

- (void)initialization
{
    _babyView = [[BabyView alloc] initWithFrame:CGRectMake(0, 0, 1024, 768)];
    [self.view addSubview:_babyView];
    [self.view setBackgroundColor:[UIColor clearColor]];
    [_babyView.layer setMasksToBounds:NO];
    if ([MainTabBarController sharedMainViewController].isVertical) {
        [self setVerticalFrame];
    }else{
        [self setHorizontalFrame];
    }
}



- (void)setVerticalFrame
{
    [_babyView setFrame:CGRectMake(0, 0, 768, 1024)];
    self.view.frame = CGRectMake(0, 0, 768, 1024);
    [_babyView setVerticalFrame];
}

- (void)setHorizontalFrame
{
    [_babyView setFrame:CGRectMake(0, 0, 1024, 768)];
    self.view.frame = CGRectMake(0, 0, 1024, 768);
    [_babyView setHorizontalFrame];
}



- (void)show
{
    
    [_babyView showInFrom:kAFAnimationFromTop inView:self.view withFade:NO duration:0.5 delegate:self startSelector:nil stopSelector:nil];
    
}

- (void)hidden
{

    [_babyView hiddenOutTo:kAFAnimationFromTop inView:self.view withFade:NO duration:0.5 delegate:self startSelector:nil stopSelector:@selector(finishOut)];
    
}

- (void)finishOut
{
    [_delegate babyViewfinished];
    [self viewDidDisappear:NO];
    [MyNotiCenter removeObserver:self];
}

@end
