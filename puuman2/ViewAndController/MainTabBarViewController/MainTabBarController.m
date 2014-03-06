//
//  MainTabBarController.m
//  puuman2
//
//  Created by Ra.（祁文龙） on 14-2-26.
//  Copyright (c) 2014年 AFITC. All rights reserved.
//

#import "MainTabBarController.h"

@interface MainTabBarController ()

@end

@implementation MainTabBarController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.delegate = self;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    //[self.tabBar removeFromSuperview];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController*)viewController

{
    
    CATransition *animation =[CATransition animation];
    
    [animation setDuration:0.75f];
    
    [animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionDefault]];
    
    [animation setType:kCATransitionFade];
    
    [animation setSubtype:kCATransitionFromRight];
    
    [tabBarController.view.layer addAnimation:animation forKey:@"reveal"];
    
    return YES;
    
}
@end
