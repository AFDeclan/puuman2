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
       // [showAndHiddenBtn setAlpha:0];
        [self initialization];
        [self initWithLeftView];
        [self initWithRightView];
    }
    return self;
}


- (void)initialization
{
    
    leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 96, 807, 672)];
    [leftView setBackgroundColor:[UIColor whiteColor]];
    [self.contentView addSubview:leftView];
    rightView = [[UIView alloc] initWithFrame:CGRectMake(807,96,217, 672)];
    [rightView setBackgroundColor:[UIColor clearColor]];
    [self.contentView addSubview:rightView];
    
}
- (void)initWithLeftView
{
    
    babyPropView = [[PropView alloc] initWithFrame:CGRectMake(130, 140, 544, 448)];
    [leftView addSubview:babyPropView];
    UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [leftBtn setFrame:CGRectMake(0, 0, 47, 672)];
    [leftBtn setBackgroundColor:PMColor6];
    [leftBtn setImage:[UIImage imageNamed:@"back_left_babyInfo.png"] forState:UIControlStateNormal];
    [leftBtn addTarget:self action:@selector(leftBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [leftView addSubview:leftBtn];
    
    
}

- (void)initWithRightView
{
    estiTextField = [[UITextField alloc] initWithFrame:CGRectMake(ViewWidth(rightView)-216+10, 10, 216, 40)];
    [estiTextField setBackgroundColor:[UIColor whiteColor]];
    [estiTextField setPlaceholder:@"在此点击输入您的评价"];
    [estiTextField setFont:PMFont2];
    [estiTextField setTextAlignment:NSTextAlignmentLeft];
    [rightView addSubview:estiTextField];
    
    UIView *estiView = [[UIView alloc] initWithFrame:CGRectMake(ViewWidth(rightView)-216, 50, 216,70)];
    [estiView setBackgroundColor:PMColor4];
    [rightView addSubview:estiView];
    
    estiBtn = [[ColorButton alloc] initWithFrame:CGRectMake(0, 15, 112, 40)];
    [estiBtn initWithTitle:@"评价" andIcon:[UIImage imageNamed:@"esti_image_babyInfo.png"] andButtonType:kBlueRight];
    [estiView addSubview:estiBtn];
    
    
    estiTableView = [[UITableView alloc] initWithFrame:CGRectMake(ViewWidth(rightView)-216, 120, 216, ViewHeight(rightView)-120)];
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
    if ([[[UserInfo sharedUserInfo] babyInfo]WhetherBirth]) {

    [_delegate backTheBornView];
    
    } else {
    
        [_delegate backThePregnancyView];
    
    }
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
    
      UIView  *lineView = [[UIView alloc] initWithFrame:CGRectMake(15,ViewHeight(cell.estiLabel)+20 ,180,1)];
      [lineView setBackgroundColor:PMColor5];
      [cell.contentView addSubview:lineView];

    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{

    return  200;
   
}

- (void)refresh
{
    
}
//-(void)setVerticalFrame
//{
//    //[super setVerticalFrame];
//   // [leftView setFrame:CGRectMake(-216, 0, 256, 832)];
//    // [showAndHiddenBtn setAlpha:1];
//    SetViewLeftUp(babyPropView, 32, 192);
//    
//}
//
//-(void)setHorizontalFrame
//{
//   // [super setHorizontalFrame];
//    ///[leftView setFrame:CGRectMake(0, 0, 216, 576)];
//    // [showAndHiddenBtn setAlpha:0];
//    SetViewLeftUp(babyPropView, 160, 64);
//    
//}
//

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
