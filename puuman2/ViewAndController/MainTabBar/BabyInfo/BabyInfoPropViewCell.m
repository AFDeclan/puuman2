//
//  BabyInfoPropViewCell.m
//  puuman2
//
//  Created by AF_Bigwaves on 14-7-2.
//  Copyright (c) 2014年 AFITC. All rights reserved.
//

#import "BabyInfoPropViewCell.h"
#import "MainTabBarController.h"
#import "UniverseConstant.h"
#import "BabyInfoPropEstiCell.h"

@implementation BabyInfoPropViewCell

@synthesize delegate = _delegate;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [showAndHiddenBtn setAlpha:0];
        [self initialization];
        [self initWithLeftView];
        [self initWithRightView];
        if ([[MainTabBarController sharedMainViewController] isVertical]) {
        
            [self setVerticalFrame];
        }else {
        
            [self setHorizontalFrame];
        }
    }
    return self;
}


- (void)initialization
{
    
    showAndHiddenBtn = [[BabyInfoPageControlButton alloc] init];
    lineView =[[UIView alloc] init];
    [lineView setBackgroundColor:PMColor6];
    [self.contentView addSubview:lineView];
    leftView = [[UIView alloc] init];
    [leftView setBackgroundColor:[UIColor whiteColor]];
    [self.contentView addSubview:leftView];
    rightView = [[UIView alloc] init];
    [rightView setBackgroundColor:[UIColor clearColor]];
    [self.contentView addSubview:rightView];
    
}
- (void)initWithLeftView
{
    
    babyPropView = [[PropView alloc] init];
    [leftView addSubview:babyPropView];
     leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [leftBtn setBackgroundColor:PMColor6];
    [leftBtn setImage:[UIImage imageNamed:@"back_left_babyInfo.png"] forState:UIControlStateNormal];
    [leftBtn addTarget:self action:@selector(leftBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [leftView addSubview:leftBtn];
    
    
}

- (void)initWithRightView
{
    estiTextField = [[UITextField alloc] init];
    [estiTextField setBackgroundColor:[UIColor whiteColor]];
    [estiTextField setPlaceholder:@"在此点击输入您的评价"];
    [estiTextField setFont:PMFont2];
    [estiTextField setTextAlignment:NSTextAlignmentLeft];
    [rightView addSubview:estiTextField];
    
     estiView = [[UIView alloc] init];
    [estiView setBackgroundColor:PMColor4];
    [rightView addSubview:estiView];
    
    estiBtn = [[ColorButton alloc] initWithFrame:CGRectMake(0, 15, 112, 40)];
    [estiBtn initWithTitle:@"评价" andIcon:[UIImage imageNamed:@"esti_image_babyInfo.png"] andButtonType:kBlueRight];
    [estiView addSubview:estiBtn];
    
    
    estiTableView = [[UITableView alloc] init];
    [estiTableView setBackgroundColor:PMColor4];
    [estiTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [estiTableView setShowsHorizontalScrollIndicator:NO];
    [estiTableView setShowsVerticalScrollIndicator:NO];
    [estiTableView setDelegate:self];
    [estiTableView setDataSource:self];
    [rightView addSubview:estiTableView];
    
    estiArrayData = [[NSMutableArray alloc] init];
    
   
    
    
    
    
}

- (void)leftBtnClick
{

    [_delegate gotoPreCell];

    
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
        
    return 10;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
  NSString *cellIdentifier = @"estiCell";
   BabyInfoPropEstiCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
    
        cell = [[BabyInfoPropEstiCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    
    }
    [cell setBackgroundColor:[UIColor clearColor]];
    
     [cell.estiLabel setTitle:@"使用感觉狠不错使用感觉狠不错使用感觉狠不错使用感觉狠不错使用感觉狠不错" withMaxWidth:180];
    
      UIView  *adjustLineView = [[UIView alloc] initWithFrame:CGRectMake(15,ViewHeight(cell.estiLabel)+20 ,180,1)];
      [adjustLineView setBackgroundColor:PMColor5];
      [cell.contentView addSubview:adjustLineView];

    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{

    return  200;
   
}

- (void)refresh
{
    
}
-(void)setVerticalFrame
{
    //[super setVerticalFrame];
    [lineView setFrame:CGRectMake(0, 96, 768, 2)];
   [leftView setFrame:CGRectMake(0, 98, 768, 926)];
    [leftBtn setFrame:CGRectMake(0, 0, 48, 926)];
    [babyPropView setFrame:CGRectMake(130, 280, 544, 448)];
    [showAndHiddenBtn setAlpha:1];
    [showAndHiddenBtn setFrame:CGRectMake(728, 360, 50, 100)];
}

-(void)setHorizontalFrame
{
   // [super setHorizontalFrame];
    [lineView setFrame:CGRectMake(0, 96, 1024, 2)];
    [leftView setFrame:CGRectMake(0, 98, 808, 670)];
    [rightView setFrame:CGRectMake(808,98,216, 670)];
    [babyPropView setFrame:CGRectMake(130, 140, 544, 448)];
    [leftBtn setFrame:CGRectMake(0, 0, 48, 670)];
    [estiTextField setFrame:CGRectMake(ViewWidth(rightView)-216, 0, 216, 50)];
    [estiView setFrame:CGRectMake(ViewWidth(rightView)-216, 50, 216,70)];
    [estiTableView setFrame:CGRectMake(ViewWidth(rightView)-216, 120, 216, ViewHeight(rightView)-120)];
    [showAndHiddenBtn setAlpha:0];
   
    
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
