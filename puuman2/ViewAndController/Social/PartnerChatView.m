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
#import "Action.h"


@implementation PartnerChatView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [MyNotiCenter addObserver:self selector:@selector(refreshChatTable) name:Noti_RefreshChatTable object:nil];
        [MyNotiCenter addObserver:self selector:@selector(hiddenBottomInputView) name:Noti_BottomInputViewHidden object:nil];
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
    
    bgHeadView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 864, 48)];
    [bgHeadView setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"pic_talk_fri.png"]]];
    [self addSubview:bgHeadView];
    
    icon_headDown = [[UIView alloc]initWithFrame:CGRectMake(0, 16, 864, 32)];
    [icon_headDown setBackgroundColor:PMColor6];
    [self addSubview:icon_headDown];
    
    icon_headUp = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 864, 48)];
    [icon_headUp setBackgroundColor:PMColor6];
    [icon_headUp.layer setMasksToBounds:YES];
    [icon_headUp.layer setCornerRadius:16.0f];
    [self addSubview:icon_headUp];
    
    
    info_title = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 320, 48)];
    [info_title setBackgroundColor:[UIColor clearColor]];
    [info_title setTextColor:[UIColor whiteColor]];
    [info_title setFont:PMFont2];
    [info_title setTextAlignment:NSTextAlignmentCenter];
    [icon_headUp addSubview:info_title];
    
//    noti_label = [[UILabel alloc] initWithFrame:CGRectMake(320, 0, 276, 48)];
//    [noti_label setText:@""];
//    [noti_label setFont:PMFont2];
//    [noti_label setTextColor:PMColor3];
//    [noti_label setBackgroundColor:[UIColor clearColor]];
//    [self addSubview:noti_label];
   // [self reloadChatData];
    [self refreshChatTable];
    inputVC = [[ChatInputViewController alloc] initWithNibName:nil bundle:nil];
}

- (void)reloadChatData
{
   
    [[Friend sharedInstance] removeDelegateObject:self];
    [[Friend sharedInstance] addDelegateObject:self];
    [[[Friend sharedInstance] myGroup] startUpdateAction];
    [[MainTabBarController sharedMainViewController].view addSubview:inputVC.view];
    [inputVC show];
    
}

- (void)hiddenBottomInputView
{
    [inputVC hidden];
}

- (void)goOut
{
    [[Friend sharedInstance] removeDelegateObject:self];
    [[[Friend sharedInstance] myGroup] stopUpdateAction];
}

//Group Action 更新成功
- (void)actionUpdated:(Group *)group
{
    myGroup = group;
    [self reloadChatTable];
  
}

- (void)refreshChatTable
{
    
    myGroup = [[Friend sharedInstance] myGroup];
    [self reloadChatTable];
}


- (void)setVerticalFrame
{
    
    [bgHeadView setFrame:CGRectMake(0, 0, 608, 48)];
    [icon_headDown setFrame:CGRectMake(0, 16, 608, 32)];
    [icon_headUp setFrame:CGRectMake(0, 0, 608, 48)];
    [chatTable setFrame:CGRectMake(0, 0, 608, 880)];
    [self reloadChatTable];
}

- (void)setHorizontalFrame
{

    [bgHeadView setFrame:CGRectMake(0, 0, 864, 48)];
    [icon_headDown setFrame:CGRectMake(0, 16, 864, 32)];
    [icon_headUp setFrame:CGRectMake(0, 0, 864, 48)];
    [chatTable setFrame:CGRectMake(0, 0, 864, 624)];
    [self reloadChatTable];
    
}

#pragma mark - Table view data source



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
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
    if ([indexPath row] == 0) {
        return 48;
    }else{
        return [ChatTableCell heightForChat:[(Action *)[[myGroup GAction] objectAtIndex:[indexPath row]-1 ] AMeta]];
    }
    
 
}

- (void)reloadChatTable
{
    [info_title setText:myGroup.GName];
    float height = [chatTable contentSize].height;
    CGPoint pos = chatTable.contentOffset;
    [chatTable reloadData];
    [chatTable setContentOffset:pos];
    if ([chatTable contentSize].height > height) {
        [chatTable scrollRectToVisible:CGRectMake(0, [chatTable contentSize].height - self.frame.size.height, self.frame.size.width, self.frame.size.height) animated:YES];
    }
}

-(void)dealloc
{
    [inputVC hidden];
    [MyNotiCenter removeObserver:self];
}
@end
