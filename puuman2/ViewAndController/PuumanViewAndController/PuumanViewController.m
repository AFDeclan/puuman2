//
//  PuumanViewController.m
//  puuman2
//
//  Created by Ra.（祁文龙） on 14-2-26.
//  Copyright (c) 2014年 AFITC. All rights reserved.
//

#import "PuumanViewController.h"

@interface PuumanViewController ()

@end

@implementation PuumanViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor greenColor]];
    [self.tabBarController.tabBarItem setTitle:@"Puuman"];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
