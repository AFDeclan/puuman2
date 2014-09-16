//
//  ToolsView.m
//  puuman2
//
//  Created by Ra.（祁文龙） on 14-6-27.
//  Copyright (c) 2014年 AFITC. All rights reserved.
//

#import "ToolsView.h"
#import "UniverseConstant.h"
#import "ToolsCalendarView.h"
#import "ToolsCoinView.h"
#import "ToolsDynamicView.h"



@implementation ToolsView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self setBackgroundColor:[UIColor clearColor]];
        [self initialization];
        [self initUnitsView];
    }
    return self;
}

- (void)initialization
{
    selectedIndex = 0;
    contentView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    [self addSubview:contentView];
    UIImageView *bgImgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 240, 656)];
    [bgImgView setImage:[UIImage imageNamed:@"bg_calendar_diary.png"]];
    [contentView addSubview:bgImgView];
    toolsInfo = [[ToolsInfoView alloc] initWithFrame:CGRectMake(0, 0, 240, 144)];
    [contentView addSubview:toolsInfo];
    animated = YES;
    
}

- (void)initUnitsView
{
    for (int i = 0; i < 3; i ++) {
        switch (i) {
            case 0:
            {
                unitViews[i] = [[ToolsDynamicView alloc] initWithFrame:CGRectMake(0, i *64+144, 240, 64)];
                
            }
                break;
            case 1:
            {
                unitViews[i] = [[ToolsCoinView alloc] initWithFrame:CGRectMake(0, i *64+144, 240, 64)];
                
            }
                break;
            case 2:
            {
                unitViews[i] = [[ToolsCalendarView alloc] initWithFrame:CGRectMake(0, i *64+144, 240, 64)];
            }
                break;

            default:
            {
                unitViews[i] = [[ToolsUnitView alloc] initWithFrame:CGRectMake(0, i *64+144, 240, 64)];
                
            }
                break;
                break;
        }
        [unitViews[i] setFlagNum:i];
        [unitViews[i] setDelegate:self];
        [contentView addSubview:unitViews[i]];
    }

}

- (void)showAnimate
{
    SetViewLeftUp(contentView, 0, -30);
    [self performSelectorOnMainThread:@selector(animateWithActiveView) withObject:nil waitUntilDone:0];

}

- (void)animateWithActiveView
{
    [UIView animateWithDuration:1 animations:^{
        SetViewLeftUp(contentView, 0, 0);
    }completion:^(BOOL finished) {
        [self performSelector:@selector(foldCoin) withObject:nil afterDelay:0.5];
    }];
}

- (void)foldCoin
{
    animated = NO;
    [self foldOrUnFoldWithFlag:1];
    
}

- (void)reloadView
{
    animated = NO;

    [unitViews[selectedIndex] refreshInfo];
    if (selectedIndex == 1) {
        [self performSelector:@selector(addPie) withObject:nil afterDelay:1];
        
    }
    

}

- (void)foldOrUnFoldWithFlag:(NSInteger)flag
{

        if (!animated) {
            if (selectedIndex != flag) {
                animated = YES;
               // PostNotification(Noti_ShowTools, [NSNumber numberWithInt:flag]);
                [unitViews[flag] refreshInfo];
                [unitViews[flag] unFoldTool];
                [unitViews[selectedIndex] foldTool];
                [UIView animateWithDuration:0.5 animations:^{
                    
                    if (flag < selectedIndex) {
                        [unitViews[flag] setFrame:CGRectMake(0, 64*flag+144, 240, [ToolsUnitView heightWithTheIndex:flag])];
                        [self movedFollowFlag:flag+1 ToIndex:selectedIndex];
                        [unitViews[selectedIndex] setFrame:CGRectMake(0, unitViews[selectedIndex-1].frame.origin.y+ unitViews[selectedIndex-1].frame.size.height, 240, 64)];
                        [self movedFollowFlag:selectedIndex+1 ToIndex:3];
                        
                    }else{
                        if(selectedIndex >=0)
                        {
                            [unitViews[selectedIndex] setFrame:CGRectMake(0, unitViews[selectedIndex].frame.origin.y, 240, 64)];
                            [self movedFollowFlag:selectedIndex+1 ToIndex:flag];
                        }
                        [unitViews[flag] setFrame:CGRectMake(0, 64*flag+144, 240, [ToolsUnitView heightWithTheIndex:flag])];
                        [self movedFollowFlag:flag+1 ToIndex:3];
                        
                    }
                    
                }completion:^(BOOL finished) {
                    selectedIndex = flag;
                    animated =  NO;
                    if (flag == 1) {
                        [self performSelector:@selector(addPie) withObject:nil afterDelay:0];

                    }
                    
                }];

            }
        }
  
    
}

- (void)changedPie
{
    if (selectedIndex == 1) {
        [(ToolsCoinView *)unitViews[1] changedPie];
    }

}

- (void)addPie
{
    [(ToolsCoinView *)unitViews[1] addPie];
}

- (void)movedFollowFlag:(NSInteger)flag
{
    for (int i = flag ; i < 3; i ++) {
        SetViewLeftUp(unitViews[i], 0, unitViews[i-1].frame.origin.y+ unitViews[i-1].frame.size.height);
    }
}


- (void)movedFollowFlag:(NSInteger)flag ToIndex:(NSInteger)toFlag
{
    for (int i = flag; i < toFlag; i ++) {
        SetViewLeftUp(unitViews[i], 0, unitViews[i-1].frame.origin.y+ unitViews[i-1].frame.size.height);
    }
}

@end
