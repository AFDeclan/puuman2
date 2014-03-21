//
//  ShopViewController.m
//  puuman2
//
//  Created by Ra.（祁文龙） on 14-2-26.
//  Copyright (c) 2014年 AFITC. All rights reserved.
//

#import "ShopViewController.h"

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

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    [self.view setBackgroundColor:[UIColor blueColor]];
    [self.tabBarController.tabBarItem setTitle:@"Shop"];
    // Dispose of any resources that can be recreated.
}

@end
