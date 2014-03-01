//
//  AFCustonPopViewController.m
//  puuman2
//
//  Created by Ra.（祁文龙） on 14-3-1.
//  Copyright (c) 2014年 AFITC. All rights reserved.
//

#import "AFCustonPopViewController.h"
#import "UniverseConstant.h"


@interface AFCustonPopViewController ()

@end

@implementation AFCustonPopViewController
@synthesize bg_page = _bg_page;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
        [[NSNotificationCenter defaultCenter]
         addObserver:self selector:@selector(setHorizontalFrame) name:NOTIFICATION_Horizontal object:nil];
        [[NSNotificationCenter defaultCenter]
         addObserver:self selector:@selector(setVerticalFrame) name:NOTIFICATION_Vertical object:nil];
        
        _bg_page = [[UIView alloc] init];
        [_bg_page setAlpha:0.5];
        [self.view addSubview:_bg_page];
    }
    return self;
}

- (void)setVerticalFrame
{
    [_bg_page setFrame:CGRectMake(0, 0, 768, 1024)];
    self.view.frame = CGRectMake(0, 0, 768, 1024);
}

- (void)setHorizontalFrame
{
    [_bg_page setFrame:CGRectMake(0, 0, 1024, 768)];
    self.view.frame = CGRectMake(0, 0, 1024, 768);
    
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

@end
