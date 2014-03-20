//
//  RewardViewController.m
//  puuman2
//
//  Created by Ra.（祁文龙） on 14-3-20.
//  Copyright (c) 2014年 AFITC. All rights reserved.
//

#import "RewardViewController.h"
#import "RecommentPartnerTableViewCell.h"

@interface RewardViewController ()

@end

@implementation RewardViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)initContent
{
    
    rewardTable = [[UITableView alloc] initWithFrame:CGRectMake(48, 168, 384, 436)];
    [rewardTable setBackgroundColor:PMColor5];
    [rewardTable setDelegate:self];
    [rewardTable setDataSource:self];
    [rewardTable setSeparatorColor:[UIColor clearColor]];
    [rewardTable setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [rewardTable setShowsHorizontalScrollIndicator:NO];
    [rewardTable setShowsVerticalScrollIndicator:NO];
    [_content addSubview:rewardTable];
    rankTable = [[UITableView alloc] initWithFrame:CGRectMake(48, 168, 192, 436)];
    [rankTable setBackgroundColor:PMColor5];
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
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    
//    NSString  *identity = @"talkPopCell";
//    RecommentPartnerTableViewCell  *cell = [tableView dequeueReusableCellWithIdentifier:identity];
//    if (!cell){
//        cell = [[RecommentPartnerTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identity];
//        
//    }
//    
//    
//    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
//    [cell setBackgroundColor:[UIColor clearColor]];
//    return cell;
    return nil;
    
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0;
}


@end
