//
//  PopUpViewController.m
//  puuman2
//
//  Created by Declan on 14-3-1.
//  Copyright (c) 2014年 AFITC. All rights reserved.
//

#import "PopUpViewController.h"
#import "UniverseConstant.h"

static NSMutableArray * instances = nil;

@interface PopUpViewController ()

@end

@implementation PopUpViewController

+ (void)showOnView:(UIView *)view animationType:(AFAnimationDirection)type
{
    PopUpViewController *popViewCon = [[PopUpViewController alloc] init];
    popViewCon.view.frame = CGRectMake(0, 0, ViewWidth(view), ViewHeight(view));
    popViewCon.animationType = type;
    [view addSubview:popViewCon.view];
}

- (void)viewDidLoad
{
      [super viewDidLoad];
    self.view.backgroundColor = [UIColor clearColor];
    [UIView animateWithDuration:0.3 animations:^{
        self.view.backgroundColor = [UIColor colorWithWhite:0 alpha:0.2];
    }];
    _subview = [self subview];
    [self.view addSubview:_subview];
    [self retainSelf];

}

- (void)viewDidAppear:(BOOL)animated
{
}

- (void)viewDidDisappear:(BOOL)animated
{
   [self exit];
}

- (void)exit
{
    [self.view removeFromSuperview];
    [self releaseSelf];
}

- (UIView *)subview
{
    [ErrorLog errorLog:@"subview method need to be override" fromFile:@"PopUpViewController.m" error:nil];
    return nil;
}

- (void)retainSelf
{
    if (!instances) {
        instances = [[NSMutableArray alloc] init];
    }
    [instances addObject:self];
}

- (void)releaseSelf
{
    [instances removeObject:self];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
    }
    return self;
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}




@end
