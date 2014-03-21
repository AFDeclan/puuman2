//
//  PartnerChatView.m
//  puuman2
//
//  Created by Ra.（祁文龙） on 14-3-19.
//  Copyright (c) 2014年 AFITC. All rights reserved.
//

#import "PartnerChatView.h"
#import "ColorsAndFonts.h"
#import "ChatTableCell.h"
#import "UniverseConstant.h"
#import "MainTabBarController.h"

@implementation PartnerChatView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self initialization];
    }
    return self;
}

- (void)initialization
{
    
    chatTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
    [chatTable setDelegate:self];
    [chatTable setDataSource:self];
    [chatTable setSeparatorColor:[UIColor clearColor]];
    [chatTable setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [chatTable setShowsHorizontalScrollIndicator:NO];
    [chatTable setShowsVerticalScrollIndicator:NO];
    [self addSubview:chatTable];
    [chatTable setBackgroundColor:[UIColor clearColor]];
    
    bgHeadView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 48)];
    [bgHeadView setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"pic_talk_fri.png"]]];
    [self addSubview:bgHeadView];
    
    
    icon_head = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 48)];
    [icon_head setImage:[UIImage imageNamed:@"block_name_fri.png"]];
    [self addSubview:icon_head];
    
    
    info_title = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 320, 48)];
    [info_title setBackgroundColor:[UIColor clearColor]];
    [info_title setTextColor:[UIColor whiteColor]];
    [info_title setFont:PMFont2];
    [info_title setTextAlignment:NSTextAlignmentCenter];
    [info_title setText:@"三月宝宝妈妈团"];
    [icon_head addSubview:info_title];
    
    noti_label = [[UILabel alloc] initWithFrame:CGRectMake(320, 0, 276, 48)];
    [noti_label setText:@"三天前，天天邀请了w 入团"];
    [noti_label setFont:PMFont2];
    [noti_label setTextColor:PMColor3];
    [noti_label setBackgroundColor:[UIColor clearColor]];
    [self addSubview:noti_label];
 
    

}

- (void)setVerticalFrame
{
    
    [bgHeadView setFrame:CGRectMake(0, 0, 608, 48)];
    [chatTable setFrame:CGRectMake(0, 0, 608, 832)];
    [chatTable reloadData];
}

- (void)setHorizontalFrame
{

    [bgHeadView setFrame:CGRectMake(0, 0, 864, 48)];
    [chatTable setFrame:CGRectMake(0, 0, 864, 576)];
    [chatTable reloadData];
}

#pragma mark - Table view data source



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 15;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    if ([indexPath row] == 0) {
        NSString  *identity = @"HeadCell";
        UITableViewCell  *cell = [tableView dequeueReusableCellWithIdentifier:identity];
        if (!cell){
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identity];
            
        }
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        [cell setBackgroundColor:[UIColor clearColor]];
        return cell;

    }else{
        NSString  *identity = @"ChatCell";
        ChatTableCell  *cell = [tableView dequeueReusableCellWithIdentifier:identity];
        if (!cell){
            cell = [[ChatTableCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identity];
            
        }
        
        [cell buildWidthDetailChat:nil];
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        [cell setBackgroundColor:[UIColor clearColor]];
        return cell;

    }
    
    
    
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([indexPath row] == 0) {
        return 48;
    }else{
        return [ChatTableCell heightForChat:nil];
    }
    
 
}

- (void)showInputView
{
    inputVC = [[ChatInputViewController alloc] initWithNibName:nil bundle:nil];
    [[MainTabBarController sharedMainViewController].view addSubview:inputVC.view];
    [inputVC show];
}

- (void)hiddenInputView
{
    if (inputVC) {
        [inputVC hidden];
    }
    
}
@end
