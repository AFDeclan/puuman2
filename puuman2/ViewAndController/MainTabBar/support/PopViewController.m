//
//  PopViewController.m
//  puuman2
//
//  Created by Ra.（祁文龙） on 14-3-3.
//  Copyright (c) 2014年 AFITC. All rights reserved.
//

#import "PopViewController.h"
#import "UniverseConstant.h"

@interface PopViewController ()

@end

@implementation PopViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        [[NSNotificationCenter defaultCenter]
         addObserver:self selector:@selector(setHorizontalFrame) name:NOTIFICATION_Horizontal object:nil];
        [[NSNotificationCenter defaultCenter]
         addObserver:self selector:@selector(setVerticalFrame) name:NOTIFICATION_Vertical object:nil];
         [self initialization];
    }
    return self;
}

- (void)initialization
{
    bgView = [[UIView alloc] init];
    [bgView setBackgroundColor:[UIColor blackColor]];
    [bgView setAlpha:0.3];
    [self.view addSubview:bgView];
    _content = [[UIView alloc] init];
    [_content setBackgroundColor:[UIColor clearColor]];
    [self.view addSubview:_content];
    
}

- (void)setVerticalFrame
{
    [bgView setFrame:CGRectMake(0, 0, 768, 1024)];
    self.view.frame = CGRectMake(0, 0, 768, 1024);
    
}

- (void)setHorizontalFrame
{
    [bgView setFrame:CGRectMake(0, 0, 1024, 768)];
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

- (void)dismiss
{
    [[NSNotificationCenter defaultCenter] removeObserver:self  name:NOTIFICATION_Horizontal object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self  name:NOTIFICATION_Vertical object:nil];
}
@end
