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

+ (void)showOnView:(UIView *)view animationType:(PopUpAnimationType)type
{
    PopUpViewController *popViewCon = [[PopUpViewController alloc] init];
    popViewCon.view.frame = CGRectMake(0, 0, ViewWidth(view), ViewHeight(view));
    popViewCon.toPos = CGPointMake(ViewWidth(view)/2, ViewHeight(view)/2);
    popViewCon.animationType = type;
    [view addSubview:popViewCon.view];
}

+ (void)showOnView:(UIView *)view toPos:(CGPoint)pos animationType:(PopUpAnimationType)type
{
    PopUpViewController *popViewCon = [[PopUpViewController alloc] init];
    popViewCon.toPos = pos;
    popViewCon.animationType = type;
    popViewCon.view.frame = CGRectMake(0, 0, ViewWidth(view), ViewHeight(view));
    [view addSubview:popViewCon.view];
}

- (void)viewDidAppear:(BOOL)animated
{
    self.view.backgroundColor = [UIColor clearColor];
    [UIView animateWithDuration:0.3 animations:^{
        self.view.backgroundColor = [UIColor colorWithWhite:0 alpha:0.2];
    }];
    _subview = [self subview];
    [self.view addSubview:_subview];
    switch (_animationType) {
        case PopUpAnimationType_fade:
        {
            break;
        }
        case PopUpAnimationType_slide:
        {
            _subview.center = CGPointMake(ViewWidth(self.view)/2, -ViewHeight(_subview)/2);
            [UIView animateWithDuration:0.3 animations:^{
                _subview.center = _toPos;
            }];
            break;
        }
        default:
            break;
    }
}

- (void)exit
{
    [UIView animateWithDuration:0.3 animations:^{
        self.view.backgroundColor = [UIColor clearColor];
    } completion:^(BOOL finished) {
        [self.view removeFromSuperview];
        [self releaseSelf];
    }];
    switch (_animationType) {
        case PopUpAnimationType_fade:
        {
            break;
        }
        case PopUpAnimationType_slide:
        {
            [UIView animateWithDuration:0.3 animations:^{
                _subview.center = CGPointMake(ViewWidth(self.view)/2, -ViewHeight(_subview)/2);
            }];
            break;
        }
        default:
            break;
    }

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

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}




@end
