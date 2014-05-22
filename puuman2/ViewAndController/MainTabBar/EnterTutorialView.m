//
//  EnterTutorialView.m
//  puman
//
//  Created by 陈晔 on 13-9-6.
//  Copyright (c) 2013年 创始人团队. All rights reserved.
//

#import "EnterTutorialView.h"
#import "UniverseConstant.h"
#import "MainTabBarController.h"
#import "ColorsAndFonts.h"
@implementation EnterTutorialView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
           [self setBackgroundColor:PMColor1];
        self.userInteractionEnabled = YES;
        scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, 768, 1024)];
        scrollView.contentSize = CGSizeMake(768*3, 768);
        scrollView.backgroundColor = RGBColor(238, 226, 195);
        scrollView.showsHorizontalScrollIndicator = NO;
        scrollView.showsVerticalScrollIndicator = NO;
        scrollView.pagingEnabled = YES;
        scrollView.userInteractionEnabled = YES;
      
        for (int i=0; i<3; i++)
        {
            courseView[i] = [[UIImageView alloc] init];
            NSString *imageName = [NSString stringWithFormat:@"course_p%d.png", i+1];
            [courseView[i] setImage:[UIImage imageNamed:imageName]];
            courseView[i].userInteractionEnabled = YES;
            [scrollView addSubview:courseView[i]];
            
        }
        [self addSubview:scrollView];

    
        startBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [startBtn addTarget:self action:@selector(startApp) forControlEvents:UIControlEventTouchUpInside];
        [courseView[2] addSubview:startBtn];
        if([MainTabBarController sharedMainViewController].isVertical)
        {
            isVertical = YES;
            [self setVerticalFrame];
        }else
        {
            isVertical =NO;
            [self setHorizontalFrame];
        }
        
        [[NSNotificationCenter defaultCenter]
         addObserver:self selector:@selector(setHorizontalFrame) name:NOTIFICATION_Horizontal object:nil];
        [[NSNotificationCenter defaultCenter]
         addObserver:self selector:@selector(setVerticalFrame) name:NOTIFICATION_Vertical object:nil];

        
    }
    return self;
}
- (void)setVerticalFrame
{
   
    self.frame =CGRectMake(0, 0, 768, 1024);
    for (int i=0; i<3; i++)
    {
        [courseView[i] setFrame:CGRectMake(i*768, 0, 768, 1024)];
        NSString *imageName = [NSString stringWithFormat:@"course_p%d.png", i+1];
        [courseView[i] setImage:[UIImage imageNamed:imageName]];
        

    }
    if (isVertical == NO) {
        [scrollView setContentOffset:CGPointMake(scrollView.contentOffset.x*768/1024, 0)];
    }
    startBtn.frame = CGRectMake(288, 768, 192, 96);
    [scrollView setFrame:CGRectMake(0, 0, 768, 1024)];
    scrollView.contentSize = CGSizeMake(768*3, 1024);
    
    isVertical = YES;
}
- (void)setHorizontalFrame
{
    self.frame =CGRectMake(0, 0, 1024, 768);
    for (int i=0; i<3; i++)
    {
        [courseView[i] setFrame:CGRectMake(i*1024, 0, 1024, 768)];
         NSString *imageName = [NSString stringWithFormat:@"course_p%d_h.png", i+1];
        [courseView[i] setImage:[UIImage imageNamed:imageName]];
        
    }
    scrollView.contentSize = CGSizeMake(1024*3, 768);
    if (isVertical == YES) {
        [scrollView setContentOffset:CGPointMake(scrollView.contentOffset.x*1024/768, 0)];
    }
    startBtn.frame = CGRectMake(424, 566, 192, 96);
    [scrollView setFrame:CGRectMake(0, 0, 1024, 768)];
  
    isVertical =NO;
}
- (id)init
{
    return [self initWithFrame:CGRectMake(0, 0, 768*3, 1024)];
}


- (void)startApp
{
    [MobClick event:umeng_event_click label:@"StartApp_EnterTutorialView"];
    [UIView animateWithDuration:0.3 animations:^{
        self.alpha = 0;
    } completion:^(BOOL finshed){
        [self removeFromSuperview];
        [[NSNotificationCenter defaultCenter]postNotificationName:Noti_TutorialFinshed object:nil];
        [[NSNotificationCenter defaultCenter] removeObserver:self  name:NOTIFICATION_Horizontal object:nil];
        [[NSNotificationCenter defaultCenter] removeObserver:self  name:NOTIFICATION_Vertical object:nil];
    }];
}


@end
