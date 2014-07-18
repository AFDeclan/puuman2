//
//  MainTabBarController+BabyInfoController.m
//  puuman2
//
//  Created by Ra.（祁文龙） on 14-7-18.
//  Copyright (c) 2014年 AFITC. All rights reserved.
//

#import "MainTabBarController+BabyInfoController.h"
#import "CAKeyframeAnimation+DragAnimation.h"

@implementation MainTabBarController (BabyInfoController)
- (void)refreshBabyInfoView
{
    if (infoView) {
        [infoView removeFromSuperview];
    }
    
    infoView = [[BabyView alloc] initWithFrame:CGRectMake(0, -768, 1024, 768)];
    [self.view addSubview:infoView];
    [infoView.layer setMasksToBounds:NO];
    
    
    if (!babyInfoBtn) {
        babyInfoBtn = [[UIButton alloc ]initWithFrame:CGRectMake(1024 -16 - 80, 0, 80, 80)];
        [babyInfoBtn addTarget:self action:@selector(showBabyView) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:babyInfoBtn];
    }
    
    if (self.isVertical) {
        if (infoView) {
            if (babyInfoShowed) {
                [infoView setFrame:CGRectMake(0, 0, 768, 1024)];
            }else{
                [infoView setFrame:CGRectMake(0, -1024, 768, 1024)];
                
            }
            [infoView setVerticalFrame];
        }
        
        if (babyInfoBtn) {
            if (babyInfoShowed) {
                SetViewLeftUp(babyInfoBtn,768 -16 - 56, 1024);
            }else{
                SetViewLeftUp(babyInfoBtn,768 -16 - 56, 0);
            }
        }

    }else{
        if (infoView) {
            if (babyInfoShowed) {
                [infoView setFrame:CGRectMake(0, 0, 1024,768 )];
            }else{
                [infoView setFrame:CGRectMake(0, -768, 1024, 768)];
                
            }
            [infoView setHorizontalFrame];
        }
        
        if (babyInfoBtn) {
            if (babyInfoShowed) {
                SetViewLeftUp(babyInfoBtn,1024 -16 - 56,768);
            }else{
                SetViewLeftUp(babyInfoBtn,1024 -16 - 56, 0);
            }
        }

    }
    
}

-(void)showBabyView
{
    [infoView loadDataInfo];
    float posX = 0;
    float posY = 0;
    
    if (self.isVertical) {
        posX = 768;
        posY = 1024;
    }else{
        posX = 1024;
        posY = 768;
    }
    SetViewLeftUp(babyInfoBtn, posX -16 - 56, posY);
    [CAKeyframeAnimation dragAnimationWithView:infoView andDargPoint:CGPointMake(0, posY) andDelegate:self];
    SetViewLeftUp(infoView, 0, 0);
    babyInfoShowed = YES;
}

- (void)hiddenBabyView
{
    float posX = 0;
    float posY = 0;
    
    if (self.isVertical) {
        posX = 768;
        posY = -1024;
    }else{
        posX = 1024;
        posY = -768;
    }
    
    [CAKeyframeAnimation dragAnimationWithView:infoView andDargPoint:CGPointMake(0, posY) andDelegate:self];
    SetViewLeftUp(infoView, 0, posY);
    SetViewLeftUp(babyInfoBtn, posX -16 - 56, 0);
    
    babyInfoShowed = NO;
    
}



- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    if (!flag) {
        return;
    }
    self.babyInfoShowed = babyInfoShowed;
    
}
@end
