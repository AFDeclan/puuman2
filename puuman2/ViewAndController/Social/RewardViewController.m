//
//  RewardViewController.m
//  puuman2
//
//  Created by Ra.（祁文龙） on 14-3-20.
//  Copyright (c) 2014年 AFITC. All rights reserved.
//

#import "RewardViewController.h"
#import "RecommentPartnerTableViewCell.h"
#import "RankTableViewCell.h"
#import "RewardTableViewCell.h"

@interface RewardViewController ()

@end

@implementation RewardViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        [self initContent];
    }
    return self;
}

-(void)initContent
{
    noti_label  = [[UILabel alloc] initWithFrame:CGRectMake(492, 388, 168, 32)];
    [noti_label setTextColor:PMColor3];
    [noti_label setFont:PMFont3];
    [noti_label setNumberOfLines:2];
    [noti_label setText:@"点赞和被点赞、留言和被留言数相加计入统计"];
    [noti_label setBackgroundColor:[UIColor clearColor]];
    [_content addSubview:noti_label];
    
    rewardTable = [[UITableView alloc] initWithFrame:CGRectMake(48, 112, 384, 436)];
    [rewardTable setDelegate:self];
    [rewardTable setDataSource:self];
    [rewardTable setSeparatorColor:[UIColor clearColor]];
    [rewardTable setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [rewardTable setShowsHorizontalScrollIndicator:NO];
    [rewardTable setShowsVerticalScrollIndicator:NO];
    [_content addSubview:rewardTable];
    
    
    rankTable = [[UITableView alloc] initWithFrame:CGRectMake(480, 112, 192, 240)];
    [rankTable setDelegate:self];
    [rankTable setDataSource:self];
    [rankTable setSeparatorColor:[UIColor clearColor]];
    [rankTable setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [rankTable setShowsHorizontalScrollIndicator:NO];
    [rankTable setShowsVerticalScrollIndicator:NO];
    [_content addSubview:rankTable];
    
    
    instructionBtn = [[ColorButton alloc] init];
    [instructionBtn  initWithTitle:@"说明" andIcon:[UIImage imageNamed:@"icon_info_diary.png"] andButtonType:kGrayLeft];
    [instructionBtn addTarget:self action:@selector(instruction) forControlEvents:UIControlEventTouchUpInside];
    [_content  addSubview:instructionBtn];
    createBtn = [[ColorButton alloc] init];
    [createBtn  initWithTitle:@"发起" andIcon:[UIImage imageNamed:@"icon_start_topic.png"] andButtonType:kBlueLeft];
    [createBtn addTarget:self action:@selector(createTopic) forControlEvents:UIControlEventTouchUpInside];
    [_content  addSubview:createBtn];
    SetViewLeftUp(instructionBtn, 592, 480);
    SetViewLeftUp(createBtn, 592, 520);
    
}

- (void)instruction
{
    
}

- (void)createTopic
{
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (rankTable == tableView) {
        return 3;
    }else{
        return 4;
    }
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (tableView == rankTable) {
        NSString  *identity = @"rankCell";
        RankTableViewCell  *cell = [tableView dequeueReusableCellWithIdentifier:identity];
        if (!cell){
            cell = [[RankTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identity];
            
        }
        
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        [cell setBackgroundColor:[UIColor clearColor]];
        return cell;
    }else{
        NSString  *identity = @"rewardCell";
        RewardTableViewCell  *cell = [tableView dequeueReusableCellWithIdentifier:identity];
        if (!cell){
            cell = [[RewardTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identity];
            
        }
        [cell setRow:[indexPath row]];
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        [cell setBackgroundColor:[UIColor clearColor]];
        return cell;
    }
    

 
 
    
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (tableView == rankTable) {
        return 80;
    }else{
        if ([indexPath row] == 0) {
            return 160;
        }else{
            return 96;
        }
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (tableView == rankTable) {
           return 24;
    }else{
        return 0;
    }
 
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 192, 24)];
    [view setBackgroundColor:[UIColor clearColor]];
    UILabel *rank_title = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 192, 12)];
    [rank_title setTextColor:PMColor6];
    [rank_title setFont:PMFont3];
    [rank_title setText:@"实时排名"];
    [rank_title setBackgroundColor:[UIColor clearColor]];
    [rank_title setTextAlignment:NSTextAlignmentCenter];
    [view addSubview:rank_title];
    UIImageView *partLine  = [[UIImageView alloc] initWithFrame:CGRectMake(0, 22, 192, 2)];
    [partLine setImage:[UIImage imageNamed:@"line_topic.png"]];
    [partLine setAlpha:0.5];
    [view addSubview:partLine];
    return view;
}

@end
