//
//  RecommendPartnerViewController.m
//  puuman2
//
//  Created by Ra.（祁文龙） on 14-3-20.
//  Copyright (c) 2014年 AFITC. All rights reserved.
//

#import "RecommendPartnerViewController.h"
#import "RecommentPartnerTableViewCell.h"

@interface RecommendPartnerViewController ()

@end

@implementation RecommendPartnerViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)initWithContent
{
    recommentTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 112, 576, 414)];
    [recommentTable setBackgroundColor:PMColor5];
    [recommentTable setDelegate:self];
    [recommentTable setDataSource:self];
    [recommentTable setSeparatorColor:[UIColor clearColor]];
    [recommentTable setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [recommentTable setShowsHorizontalScrollIndicator:NO];
    [recommentTable setShowsVerticalScrollIndicator:NO];
    [_content addSubview:recommentTable];
    
    changeBtn = [[ColorButton alloc] init];
    [changeBtn  initWithTitle:@"换一个"  andButtonType:kGrayLeft];
    [changeBtn addTarget:self action:@selector(changed) forControlEvents:UIControlEventTouchUpInside];
    [_content  addSubview:changeBtn];
    
    inviteBtn = [[ColorButton alloc] init];
    [inviteBtn  initWithTitle:@"发起" andButtonType:kBlueLeft];
    [inviteBtn addTarget:self action:@selector(invite) forControlEvents:UIControlEventTouchUpInside];
    [_content  addSubview:inviteBtn];
}

- (void)changed
{

}

- (void)invite
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


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    
    NSString  *identity = @"talkPopCell";
    RecommentPartnerTableViewCell  *cell = [tableView dequeueReusableCellWithIdentifier:identity];
    if (!cell){
        cell = [[RecommentPartnerTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identity];
        
    }
    
    
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    [cell setBackgroundColor:[UIColor clearColor]];
    return cell;
    
    
    
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
