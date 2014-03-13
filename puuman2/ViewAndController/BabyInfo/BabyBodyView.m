//
//  BabyBodyView.m
//  puuman2
//
//  Created by Ra.（祁文龙） on 14-3-13.
//  Copyright (c) 2014年 AFITC. All rights reserved.
//

#import "BabyBodyView.h"
#import "UniverseConstant.h"
#import "BodyInfoTableViewCell.h"
#import "BabyData.h"
#import "LineChartCell.h"
#import "AddBodyDataViewController.h"
#import "MainTabBarController.h"

@implementation BabyBodyView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        SetViewLeftUp(showAndHiddenBtn, 216, 376);
        [self initWithLeftView];
        [self initWithRightView];
        
        
        
    }
    return self;
}

- (void)initWithLeftView
{
    dataTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 216, 0)];
    [dataTable setBackgroundColor:PMColor6];
    [dataTable setDataSource:self];
    [dataTable setDelegate:self];
    [leftView addSubview:dataTable];
    //[dataTable setBackgroundColor:[UIColor clearColor]];
    [dataTable setSeparatorColor:[UIColor clearColor]];
    [dataTable setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [dataTable setShowsHorizontalScrollIndicator:NO];
    [dataTable setShowsVerticalScrollIndicator:NO];
    emptyView = [[UIView alloc] init];
    [emptyView setBackgroundColor:[UIColor clearColor]];
    [leftView addSubview:emptyView];
    
    UIImageView *iconBg = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 88, 80)];
    [iconBg setImage:[UIImage imageNamed:@"pic_body_blank.png"]];
    [emptyView addSubview:iconBg];
    UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(0, 88, 88, 24)];
    [title setFont:PMFont4];
    [title setTextColor:PMColor7];
    [title setText:@"还没有记录哦~"];
    [title setTextAlignment:NSTextAlignmentCenter];
    [title setBackgroundColor:[UIColor clearColor]];
    [emptyView addSubview:title];
    if ([[BabyData sharedBabyData] recordCount] > 0) {
        [emptyView setAlpha:0];
    }else{
        [emptyView setAlpha:1];
    }

}

- (void)initWithRightView
{
    _lineChartView  = [[UITableView alloc] initWithFrame:CGRectMake(56, 184, 544, 408)];
   
    [_lineChartView setDataSource:self];
    [_lineChartView setDelegate:self];
    [rightView addSubview:_lineChartView];
    [_lineChartView setBackgroundColor:[UIColor clearColor]];
    [_lineChartView setSeparatorColor:[UIColor clearColor]];
    [_lineChartView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [_lineChartView setShowsHorizontalScrollIndicator:NO];
    [_lineChartView setShowsVerticalScrollIndicator:NO];
    [_lineChartView setScrollEnabled:NO];
  
    addDataBtn = [[ColorButton alloc] init];
    [addDataBtn initWithTitle:@"+ 添加"  andButtonType:kBlueLeftDown];
    [addDataBtn addTarget:self action:@selector(addData) forControlEvents:UIControlEventTouchUpInside];
    [rightView addSubview:addDataBtn];
    noti_label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 544, 10)];
    [noti_label setFont:PMFont4];
    [noti_label setTextColor:PMColor3];
    [noti_label setText:@"左右滑动切换身高&体重"];
    [noti_label setTextAlignment:NSTextAlignmentCenter];
    [rightView addSubview:noti_label];
}

- (void)addData
{
    AddBodyDataViewController *addVC = [[AddBodyDataViewController alloc] initWithNibName:nil bundle:nil];
    [addVC setControlBtnType:kCloseAndFinishButton];
    [addVC setTitle:@"添加记录" withIcon:nil];
    [[MainTabBarController sharedMainViewController].view addSubview:addVC.view];
    [addVC show];
}

- (void)refresh
{
    [dataTable reloadData];
    [_lineChartView reloadData];
 
}

-(void)setVerticalFrame
{
    [super setVerticalFrame];
    [leftView setFrame:CGRectMake(-216, 0, 256, 832)];
    [showAndHiddenBtn setAlpha:1];
    [dataTable setFrame:CGRectMake(0, 0, 216, 832)];
    [_lineChartView setFrame:CGRectMake(56, 184, 544, 408)];
    [emptyView setFrame:CGRectMake(64, 320, 88, 112)];
    SetViewLeftUp(noti_label, 56, 560);
    SetViewLeftUp(addDataBtn, 496, 768);
    
}

-(void)setHorizontalFrame
{
    [super setHorizontalFrame];
    [leftView setFrame:CGRectMake(0, 0, 216, 576)];
    [showAndHiddenBtn setAlpha:0];
    [dataTable setFrame:CGRectMake(0, 0, 216, 576)];
    [_lineChartView setFrame:CGRectMake(312, 54, 544, 408)];
    [emptyView setFrame:CGRectMake(64, 192, 88, 112)];
    SetViewLeftUp(noti_label, 312, 430);
    SetViewLeftUp(addDataBtn, 752, 512);
  
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == dataTable) {
        // Return the number of rows in the section.
        return [[BabyData sharedBabyData] recordCount];
    }else{
         return 1;
    }

    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == dataTable) {
        static NSString *identity = @"bodyInfoCell";
        BodyInfoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identity];
        if (!cell)
        {
            cell = [[BodyInfoTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identity];
        }
        [cell setBackgroundColor:[UIColor clearColor]];
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        [cell setInfoIndex:indexPath.row];
        return cell;
    }else{
        NSString *babyInfoCellIdentifier = @"LineChartCell";
        LineChartCell *cell = [tableView dequeueReusableCellWithIdentifier:babyInfoCellIdentifier];
        if (cell == nil)
        {
            cell = [[LineChartCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:babyInfoCellIdentifier];
            
        }
        [cell setViewIsHeight:YES];
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        [cell.contentView setBackgroundColor:[UIColor whiteColor]];
        return cell;

    }
  
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == dataTable) {
         return 136;
    }else{
        return 408;
    }
   
}

- (void)fold
{
    [showAndHiddenBtn foldWithDuration:0.3];
    [UIView animateWithDuration:0.3 animations:^{
        SetViewLeftUp(leftView, -216, 0);
    }];
    
}

- (void)unfold
{
    [showAndHiddenBtn unfoldWithDuration:0.3];
    [UIView animateWithDuration:0.3 animations:^{
        SetViewLeftUp(leftView, 0, 0);
    }];
}

@end
