//
//  MainTabBar.m
//  puuman2
//
//  Created by Ra.（祁文龙） on 14-3-1.
//  Copyright (c) 2014年 AFITC. All rights reserved.
//

#import "MainTabBar.h"
#import "UniverseConstant.h"

@implementation MainTabBar
@synthesize delegate = _delegate;
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self initWithSelectBoard];
    }
    return self;
}

- (void)initWithSelectBoard
{
    selectedBoard = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 64, 768)];
    [self addSubview:selectedBoard];
    
    diaryBtn = [[UIButton alloc] initWithFrame:CGRectMake(0,140, 64, 80)];
    diaryBtn.tag = 1;
    [diaryBtn addTarget:self action:@selector(clickedBtn:) forControlEvents:UIControlEventTouchUpInside];
    [diaryBtn setImage:[UIImage imageNamed:@"btn_diary1_diary.png"] forState:UIControlStateNormal];
    [selectedBoard addSubview:diaryBtn];
    
    
    babyInfoBtn = [[UIButton alloc] initWithFrame:CGRectMake(0,220, 64, 80)];
    babyInfoBtn.tag = 2;
    [babyInfoBtn addTarget:self action:@selector(clickedBtn:) forControlEvents:UIControlEventTouchUpInside];
    [babyInfoBtn setImage:[UIImage imageNamed:@"btn_baby1_diary.png"] forState:UIControlStateNormal];
    [selectedBoard addSubview:babyInfoBtn];
    
    socialBtn = [[UIButton alloc] initWithFrame:CGRectMake(0,300, 64, 80)];
    socialBtn.tag = 4;
    [socialBtn addTarget:self action:@selector(clickedBtn:) forControlEvents:UIControlEventTouchUpInside];
    [socialBtn setImage:[UIImage imageNamed:@"btn_happen1_diary.png"] forState:UIControlStateNormal];
    [selectedBoard addSubview:socialBtn];
    
    shopBtn = [[UIButton alloc] initWithFrame:CGRectMake(0,380, 64, 80)];
    shopBtn.tag = 3;
    [shopBtn addTarget:self action:@selector(clickedBtn:) forControlEvents:UIControlEventTouchUpInside];
    [shopBtn setImage:[UIImage imageNamed:@"btn_shop1_diary.png"] forState:UIControlStateNormal];
    [selectedBoard addSubview:shopBtn];
    
    settingBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 688, 64, 80)];
     settingBtn.tag = 5;
    [settingBtn setImage:[UIImage imageNamed:@"btn_set1_diary.png"] forState:UIControlStateNormal];
    [settingBtn addTarget:self action:@selector(clickedBtn:) forControlEvents:UIControlEventTouchUpInside];
    [selectedBoard addSubview:settingBtn];
}

- (void)clickedBtn:(UIButton *)sender
{
    NSInteger tag = sender.tag;
    NSLog(@"%d",tag);
    if (tag== 4) {
        return;
    }else if (tag == 5) {
        return;
    }else{
        
     [_delegate selectedWithTag:tag];
    }
   
}

-(void)setVerticalFrame
{

    self.frame = CGRectMake(0, 0, 80, 1024);
    

    
}

-(void)setHorizontalFrame
{
    self.frame = CGRectMake(0,0, 80, 768);
}
@end
