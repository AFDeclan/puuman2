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
#import "UILabel+AdjustSize.h"
#import "Award.h"


@interface RewardViewController ()

@end

@implementation RewardViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        [self initContent];
        [[Forum sharedInstance] addDelegateObject:self];
        [[Forum sharedInstance] getAwardAndRank];
        
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
    
    rewardTable = [[UITableView alloc] initWithFrame:CGRectMake(48, 112, 384, 352)];
    [rewardTable setDelegate:self];
    [rewardTable setDataSource:self];
    [rewardTable setSeparatorColor:[UIColor clearColor]];
    [rewardTable setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [rewardTable setShowsHorizontalScrollIndicator:NO];
    [rewardTable setShowsVerticalScrollIndicator:NO];
    [_content addSubview:rewardTable];
    [rewardTable setScrollEnabled:NO];
    
    timeLabel1 = [[UILabel alloc] init];
    timeLabel1.text = @"距离本期获奖名单公布还有";
    timeLabel1.textColor = PMColor2;
    timeLabel1.font = PMFont2;
    timeLabel1.backgroundColor = [UIColor clearColor];
    [timeLabel1 adjustSize];
    SetViewCenterUp(timeLabel1, ViewX(rewardTable)+ViewWidth(rewardTable)/2, ViewDownY(rewardTable)+32);
    [_content addSubview:timeLabel1];
    timeLabel1.alpha = 0;
    
    timeLabel2 = [[UILabel alloc] init];
    timeLabel2.text = @"n天n小时n分n秒";
    timeLabel2.alpha = 0;
    timeLabel2.textColor = PMColor6;
    timeLabel2.font = PMFont1;
    timeLabel2.backgroundColor= [UIColor clearColor];
    [timeLabel2 adjustSize];
    SetViewCenterUp(timeLabel2, ViewX(rewardTable)+ViewWidth(rewardTable)/2, ViewDownY(timeLabel1)+16);
    [_content addSubview:timeLabel2];
    timeLabel2.alpha = 0;
    
    rankTable = [[UITableView alloc] initWithFrame:CGRectMake(480, 112, 192, 260)];
    [rankTable setDelegate:self];
    [rankTable setDataSource:self];
    [rankTable setSeparatorColor:[UIColor clearColor]];
    [rankTable setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [rankTable setShowsHorizontalScrollIndicator:NO];
    [rankTable setShowsVerticalScrollIndicator:NO];
    [_content addSubview:rankTable];
    [rankTable setScrollEnabled:NO];
    
    empty_rank  = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 192, 240)];
    [empty_rank setTextColor:PMColor3];
    [empty_rank setFont:PMFont3];
    [empty_rank setNumberOfLines:2];
    [empty_rank setText:@"等你参与"];
    [empty_rank setBackgroundColor:[UIColor clearColor]];
    [rankTable addSubview:empty_rank];
    [empty_rank setAlpha:0];
    
    createBtn = [[AFColorButton alloc] init];
    [createBtn.title setText:@"参与"];
    [createBtn setIconImg:[UIImage imageNamed:@"icon_start_topic.png"]];
    [createBtn setIconSize:CGSizeMake(16, 16)];
    [createBtn adjustLayout];
    [createBtn setColorType:kColorButtonGrayColor];
    [createBtn setDirectionType:kColorButtonLeft];
    [createBtn resetColorButton];
    [createBtn addTarget:self action:@selector(participate) forControlEvents:UIControlEventTouchUpInside];
    [_content  addSubview:createBtn];

    
    SetViewLeftUp(instructionBtn, 592, 480);
    SetViewLeftUp(createBtn, 592, 520);
    
}

- (void)instruction
{
    
}

- (void)participate
{
    [createBtn setEnabled:NO];
    TopicType type =[[[Forum sharedInstance] onTopic] TType];
    
    switch (type) {
        case TopicType_Photo:
        {
            TopicCellSelectedPohosViewController *chooseView = [[TopicCellSelectedPohosViewController alloc] initWithNibName:nil bundle:nil];
            [self.view addSubview:chooseView.view];
            [chooseView setStyle:ConfirmError];
            [chooseView setSelecedDelegate:self];
            [chooseView show];
            
        }
            break;
        case TopicType_Text:
        {
            NewTextDiaryViewController *textVC = [[NewTextDiaryViewController alloc] initWithNibName:nil bundle:nil];
            [self.view addSubview:textVC.view];
            [textVC setControlBtnType:kCloseAndFinishButton];
            [textVC setTitle:@"文本" withIcon:nil];
            [textVC setIsTopic:YES];
            [textVC setDelegate:self];
            [textVC show];
        }
            break;
        default:
            break;
    }

}

- (void)popViewfinished
{
    [createBtn setEnabled:YES];
}

- (void)selectedViewhidden
{
    [createBtn setEnabled:YES];
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
        if ([[[Forum sharedInstance] ranks] count] == 0) {
            [empty_rank setAlpha:1];
        }else{
            [empty_rank setAlpha:0];
        }
        return [[[Forum sharedInstance] ranks] count];
    }else{
        return [[[Forum sharedInstance] awards] count];
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
        [cell setRow:[indexPath row]];
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

- (void)refreshTime
{
    if ([[Forum sharedInstance].awards count] == 0) {
        timeLabel1.alpha = 0;
        timeLabel2.alpha = 0;
        return;
    }
    Award * award = [[Forum sharedInstance].awards objectAtIndex:0];
    NSDate * due = award.ADueTime;
    NSTimeInterval time = [due timeIntervalSinceNow];
    if (time > 0) {
        timeLabel1.alpha = 1;
        timeLabel2.alpha = 1;
        NSInteger days = time / 60 / 60 / 24;
        time -= days * 60 * 60 * 24;
        NSInteger hours = time / 60 / 60;
        time -= hours * 60 * 60;
        NSInteger mins = time / 60;
        NSInteger secs = time - mins * 60;
        NSString * str = [NSString stringWithFormat:@"%ld天%ld小时%ld分%ld秒", (long)days, (long)hours, (long)mins, (long)secs];
        timeLabel2.text = str;
        [timeLabel2 adjustSizeFixCenter];
    }

}

//奖品与排行
- (void)rankAwardReceived
{
    [rewardTable reloadData];
    [rankTable reloadData];
    if (timer) [timer invalidate];
    [self refreshTime];
    timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(refreshTime) userInfo:nil repeats:YES];
}

- (void)rankAwardFailed
{

}

- (void)dealloc
{
    [timer invalidate];
}

@end
