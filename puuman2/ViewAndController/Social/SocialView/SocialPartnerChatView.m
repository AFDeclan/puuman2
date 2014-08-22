//
//  SocialPartnerChatView.m
//  puuman2
//
//  Created by Ra.（祁文龙） on 14-7-28.
//  Copyright (c) 2014年 AFITC. All rights reserved.
//

#import "SocialPartnerChatView.h"
#import "ColorsAndFonts.h"
#import "ChatTableCell.h"
#import "UniverseConstant.h"
#import "MainTabBarController.h"
#import "Action.h"

@implementation SocialPartnerChatView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initialization];
    }
    return self;
}

- (void)showView {
    
    [super showView];
    [MyNotiCenter addObserver:self selector:@selector(refreshChatTable) name:Noti_RefreshChatTable object:nil];
    [MyNotiCenter addObserver:self selector:@selector(hiddenBottomInputView) name:Noti_BottomInputViewHidden object:nil];
    [[Friend sharedInstance] addDelegateObject:self];
    [[[Friend sharedInstance] myGroup] startUpdateAction];
    [self refreshChatTable];
    [[MainTabBarController sharedMainViewController].view addSubview:inputVC.view];
    [inputVC show];


}

- (void)hiddenView
{
    [inputVC hidden];
    [MyNotiCenter removeObserver:self];
    [[[Friend sharedInstance] myGroup] stopUpdateAction];
    [[Friend sharedInstance] removeDelegateObject:self];
    [super hiddenView];
}

- (void)hiddenBottomInputView
{
    [self hiddenView];
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
    
    bgHeadView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 864, 44)];
    [bgHeadView setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"pic_talk_fri.png"]]];
    [self addSubview:bgHeadView];
    
    icon_headDown = [[UIView alloc]initWithFrame:CGRectMake(0, 14, 864, 30)];
    [icon_headDown setBackgroundColor:PMColor6];
    [self addSubview:icon_headDown];
    
    icon_headUp = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 864, 44)];
    [icon_headUp setBackgroundColor:PMColor6];
    [icon_headUp.layer setMasksToBounds:YES];
    [icon_headUp.layer setCornerRadius:16.0f];
    [self addSubview:icon_headUp];
    
    
    nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(0,0,320,44)];
    [nameLabel setBackgroundColor:[UIColor clearColor]];
    [nameLabel setTextColor:[UIColor whiteColor]];
    [nameLabel setText:@""];
    [nameLabel setFont:PMFont1];
    [nameLabel setTextAlignment:NSTextAlignmentCenter];
    [icon_headUp addSubview:nameLabel];

    inputVC = [[ChatInputViewController alloc] initWithNibName:nil bundle:nil];


}

- (void)refreshChatTable
{
    myGroup = [[Friend sharedInstance] myGroup];
    [nameLabel setText:myGroup.GName];
    [self reloadChatTable];
}



- (void)actionUpdated:(Group *)group
{
    myGroup = group;
    [self reloadChatTable];
}

- (void)reloadChatTable
{
    float height = [chatTable contentSize].height;
    CGPoint pos = chatTable.contentOffset;
    [chatTable reloadData];
    [chatTable setContentOffset:pos];
    if ([chatTable contentSize].height > height) {
        [chatTable scrollRectToVisible:CGRectMake(0, [chatTable contentSize].height - self.frame.size.height, self.frame.size.width, self.frame.size.height) animated:YES];
    }
}



- (void)setVerticalFrame
{
    
    [bgHeadView setFrame:CGRectMake(0, 0, 608, 44)];
    [icon_headDown setFrame:CGRectMake(0, 14, 608, 30)];
    [icon_headUp setFrame:CGRectMake(0, 0, 608, 44)];
    [chatTable setFrame:CGRectMake(0, 0, 608, 880)];
    SetViewLeftUp(nameLabel, 136, 0);
    [self reloadChatTable];
}

- (void)setHorizontalFrame
{
    
    [bgHeadView setFrame:CGRectMake(0, 0, 864, 44)];
    [icon_headDown setFrame:CGRectMake(0, 14, 864, 30)];
    [icon_headUp setFrame:CGRectMake(0, 0, 864, 44)];
    [chatTable setFrame:CGRectMake(0, 0, 864, 624)];
    SetViewLeftUp(nameLabel, 272, 0);
    [self reloadChatTable];
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (myGroup) {
        return [[myGroup GAction] count]+1;
        
    }else{
        return 0;
    }
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
        if ([indexPath row] == 1) {
            [cell buildWidthDetailChat:[[myGroup GAction] objectAtIndex:[indexPath row]-1] andPreChat:nil];
        }else{
            [cell buildWidthDetailChat:[[myGroup GAction] objectAtIndex:[indexPath row]-1] andPreChat:[[myGroup GAction] objectAtIndex:[indexPath row]-2]];
        }
        
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        [cell setBackgroundColor:[UIColor clearColor]];
        return cell;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}



@end