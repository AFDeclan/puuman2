//
//  BabyInfoBodyViewCell.m
//  puuman2
//
//  Created by AF_Bigwaves on 14-7-2.
//  Copyright (c) 2014年 AFITC. All rights reserved.
//

#import "BabyInfoBodyViewCell.h"
#import "UniverseConstant.h"
#import "BodyInfoTableViewCell.h"
#import "BabyData.h"
#import "LineChartCell.h"
#import "AddBodyDataViewController.h"
#import "MainTabBarController.h"
#import "ColorsAndFonts.h"
#import "DiaryFileManager.h"

static BabyInfoBodyViewCell *instance;

@implementation BabyInfoBodyViewCell
@synthesize delegate = _delegate;
@synthesize filePath = _filePath;

+(BabyInfoBodyViewCell *)shareLineChartCell
{
    if (!instance)
    {
        instance = [[BabyInfoBodyViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"BodyCell"];
    }
    return instance;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
      // SetViewLeftUp(showAndHiddenBtn, 216, 350);
        
        [self initialization];
        [self initWithLeftView];
        [self initWithRightView];
        if ([MainTabBarController sharedMainViewController].isVertical) {
            [self setVerticalFrame];
            
        }else{
            [self setHorizontalFrame];
        }
        changedVH = NO;

        [MyNotiCenter addObserver:self selector:@selector(refresh) name:Noti_BabyDataUpdated object:nil];
       
    }
    return self;
}

- (void)dealloc
{
    [MyNotiCenter removeObserver:self];
}

- (void)initialization
{
    recordIndex = -1;
     lineView = [[UIView alloc] init];
    [lineView setBackgroundColor:PMColor6];
    [self.contentView addSubview:lineView];
    leftView = [[UIView alloc] init];
    [leftView setBackgroundColor:[UIColor whiteColor]];
    [self.contentView addSubview:leftView];
    rightView = [[UIView alloc] init];
    [rightView setBackgroundColor:[UIColor clearColor]];
    [self.contentView addSubview:rightView];
     backBtn= [UIButton buttonWithType:UIButtonTypeCustom];
    [backBtn setFrame:CGRectMake(0,0, 128, 32)];
    [backBtn setBackgroundColor:[UIColor clearColor]];
    [backBtn setImage:[UIImage imageNamed:@"btn_back_babyInfo.png"] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(backBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:backBtn];
                     
   
}


- (void)initWithRightView
{
    dataTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 224,672)];
    [dataTable setBackgroundColor:PMColor6];
    [dataTable setDataSource:self];
    [dataTable setDelegate:self];
    [rightView addSubview:dataTable];
    
    [dataTable setSeparatorColor:[UIColor clearColor]];
    [dataTable setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [dataTable setShowsHorizontalScrollIndicator:NO];
    [dataTable setShowsVerticalScrollIndicator:NO];
    emptyView = [[UIView alloc] init];
    [emptyView setBackgroundColor:[UIColor clearColor]];
    [rightView addSubview:emptyView];
    
    flagRightImage = [[UIImageView alloc] init];
    [flagRightImage setImage:[UIImage imageNamed:@"babyInfo_Body_flagRight.png"]];
    [rightView addSubview:flagRightImage];
    
    rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [rightBtn setBackgroundColor:PMColor7];
    [rightBtn setImage:[UIImage imageNamed:@"back_right_babyInfo.png"] forState:UIControlStateNormal];
    [rightBtn addTarget:self action:@selector(rightBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [rightView addSubview:rightBtn];
    UIImageView *iconBg = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 88, 80)];
    [iconBg setImage:[UIImage imageNamed:@"pic_body_blank.png"]];
    [iconBg setBackgroundColor:PMColor5];
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
    }
   
    
}

- (void)initWithLeftView
{
    
    lineChartView = [[BabyLineChartView alloc] initWithFrame:CGRectMake(90, 140, 544, 408)];
    [leftView addSubview:lineChartView];
    
    addDataBtn = [[AFColorButton alloc] init];
    [addDataBtn.title setText:@"+ 添加"];
    [addDataBtn setColorType:kColorButtonBlueColor];
    [addDataBtn setDirectionType:kColorButtonRightDown];
    [addDataBtn resetColorButton];
    [addDataBtn addTarget:self action:@selector(addData) forControlEvents:UIControlEventTouchUpInside];
    [leftView addSubview:addDataBtn];
    shareBtn = [[AFColorButton alloc] init];
    [shareBtn.title setText:@"分享"];
    [shareBtn setIconImg:[UIImage imageNamed:@"share_image_babyInfo.png"]];
    [shareBtn setIconSize:CGSizeMake(16, 16)];
    
    [shareBtn setColorType:kColorButtonGrayColor];
    [shareBtn setDirectionType:kColorButtonRightUp];
    [shareBtn resetColorButton];
    [shareBtn addTarget:self action:@selector(shareData) forControlEvents:UIControlEventTouchUpInside];
    [leftView addSubview:shareBtn];
    
     noti_label = [[UILabel alloc] initWithFrame:CGRectMake(280,520,544, 18)];
    [noti_label setFont:PMFont2];
    [noti_label setTextColor:PMColor3];
    [noti_label setBackgroundColor:[UIColor clearColor]];
    [noti_label setText:@"左右滑动切换身高&体重"];
    [noti_label setTextAlignment:NSTextAlignmentLeft];
    [leftView addSubview:noti_label];
    
    
    infoView = [[UIView alloc] initWithFrame:CGRectMake(32, 606, 640, 136)];
    [infoView setBackgroundColor:PMColor6];
    [leftView addSubview:infoView];
    flagImage =[[UIImageView alloc] init];
    [flagImage setImage:[UIImage imageNamed:@"babyInfo_Body_flagDown.png"]];
    [leftView addSubview:flagImage];
    
    
    infoTableView = [[UIColumnView alloc] initWithFrame:CGRectMake(0, 0, 640, 136)];
    [infoTableView setBackgroundColor:PMColor6];
    [infoTableView setColumnViewDelegate:self];
    [infoTableView setViewDataSource:self];
    [infoTableView setPagingEnabled:NO];
    [infoTableView setDelegate:self];
    [infoView addSubview:infoTableView];
    
    
    leftImgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 138, 136)];
    [leftImgView setImage:[UIImage imageNamed:@"left_body_img.png"]];
    [infoView addSubview:leftImgView];
    
    rightImgView = [[UIImageView alloc] initWithFrame:CGRectMake(640 - 138, 0, 138, 136)];
    [rightImgView setImage:[UIImage imageNamed:@"right_body_img.png"]];
    [infoView addSubview:rightImgView];
    
}

- (void)addData
{
    AddBodyDataViewController *addVC = [[AddBodyDataViewController alloc] initWithNibName:nil bundle:nil];
    [addVC setControlBtnType:kCloseAndFinishButton];
    [addVC setTitle:@"添加记录" withIcon:nil];
    [[MainTabBarController sharedMainViewController].view addSubview:addVC.view];
    [addVC show];
}

- (void)shareData
{

    ShareSelectedViewController *shareVC = [[ShareSelectedViewController alloc] initWithNibName:nil bundle:nil];
    [self addSubview:shareVC.view];
    [shareVC setShareText:[[UserInfo sharedUserInfo] babyInfo].PortraitUrl];
    [shareVC setShareTitle:@"我想要分享链接"];
    [shareVC setShareImg:[DiaryFileManager imageForVideo:_filePath]];
    [shareVC setStyle:ConfirmError];
    //shareVC.delegate = self;
     shareVC.shareDelegate = self;
    [shareVC show];

}

-(void)selectedShareType:(SocialType)type
{
    shareType = type;

}

- (void)refresh
{
    recordIndex = -1;

    if ([[BabyData sharedBabyData] recordCount] > 0) {
        [emptyView setAlpha:0];
    }
    if ([MainTabBarController sharedMainViewController].isVertical) {
        [self setVerticalFrame];
        changedVH = NO;

        [infoTableView setContentOffset:CGPointMake(0, 0)];

    }else{
        [self setHorizontalFrame];
        changedVH = NO;

        [dataTable setContentOffset:CGPointMake(0, 0)];
    }

    [[NSNotificationCenter defaultCenter]
     addObserver:self selector:@selector(setHorizontalFrame) name:NOTIFICATION_Horizontal object:nil];
    [[NSNotificationCenter defaultCenter]
     addObserver:self selector:@selector(setVerticalFrame) name:NOTIFICATION_Vertical object:nil];

}


-(void)setVerticalFrame
{
    changedVH = YES;
    //[super setVerticalFrame];
    [rightBtn setBackgroundColor:PMColor6];
    [lineView setFrame:CGRectMake(0, 96, 768, 2)];
    [rightView setFrame:CGRectMake(704, 98, 64, 926)];
    [leftView setFrame:CGRectMake(0, 98, 704, 926)];
    [flagImage setAlpha:1];
    [flagImage setFrame:CGRectMake(350, 606, 15, 10)];
    [showAndHiddenBtn setAlpha:1];
    [dataTable setFrame:CGRectMake(0, 0, 224, 926)];
    [emptyView setFrame:CGRectMake(64, 192, 88, 112)];
    [rightBtn setFrame:CGRectMake(0, 0, 64, 926)];
    SetViewLeftUp(shareBtn, 0, 800);
    SetViewLeftUp(addDataBtn, 0, 840);
    SetViewLeftUp(backBtn, 320, 992);
    [infoView setAlpha:1];
    [dataTable setAlpha:0];
    if (recordIndex != -1) {
        [infoTableView setContentOffset:CGPointMake(recordIndex*224 , 0)];

    }

}

-(void)setHorizontalFrame
{
    changedVH = YES;
    //[super setHorizontalFrame];
    [rightBtn setBackgroundColor:PMColor7];
    [lineView setFrame:CGRectMake(0, 96, 1024, 2)];
    [rightView setFrame:CGRectMake(736,98,288, 670)];
    [leftView setFrame:CGRectMake(0, 98, 735, 670)];
    [flagImage setAlpha:0];
    [flagRightImage setFrame:CGRectMake(0, 335, 10, 15)];
    [showAndHiddenBtn setAlpha:0];
    [dataTable setFrame:CGRectMake(0, 0, 224,670)];
    [emptyView setFrame:CGRectMake(64, 192, 88, 112)];
    [noti_label setFrame:CGRectMake(280,520,544,18)];
    [rightBtn setFrame:CGRectMake(224, 0, 64, 670)];
    SetViewLeftUp(shareBtn, 0, 550);
    SetViewLeftUp(addDataBtn, 0, 590);
    SetViewLeftUp(backBtn, 448, 736);
    [dataTable setAlpha:1];
    [infoView setAlpha:0];
    if (recordIndex != -1) {
        [dataTable setContentOffset:CGPointMake(0, recordIndex*136 )];

    }

}



- (void)backBtnClick
{
    [MyNotiCenter removeObserver:self];

    PostNotification(Noti_HiddenBabyView, nil);
    changedVH = NO;

}

- (void)rightBtnClick
{
    [MyNotiCenter removeObserver:self];

    [_delegate backToMianCell];
    changedVH = NO;

}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [[BabyData sharedBabyData] recordCount]+ 2;
 
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([indexPath row] == 0) {
        NSString * cellIdentifier = @"HeaderCell";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        if (cell == nil)
        {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
            
        }
        [cell setBackgroundColor:[UIColor clearColor]];
        
        return cell;
    }else if([indexPath row] == [[BabyData sharedBabyData] recordCount] + 1){
        NSString * cellIdentifier = @"FooterCell";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        if (cell == nil)
        {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
            
        }
        [cell setBackgroundColor:[UIColor clearColor]];
        
        return cell;
    }

    
    static NSString *identity = @"bodyInfoCell";
    BodyInfoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identity];
    if (!cell)
    {
        cell = [[BodyInfoTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identity];
    }
    [cell setBackgroundColor:[UIColor clearColor]];
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    [cell setInfoIndex:indexPath.row -1];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([indexPath row] == 0) {
        return 268;
    }else if([indexPath row] == [[BabyData sharedBabyData] recordCount] + 1){
        return 268;
    }
    return 136;
}

- (void)fold
{
    //[showAndHiddenBtn foldWithDuration:0.3];
    [UIView animateWithDuration:0.3 animations:^{
   // SetViewLeftUp(leftView, -216, 0);
    }];
}

- (void)unfold
{
    //[showAndHiddenBtn unfoldWithDuration:0.3];
    [UIView animateWithDuration:1 animations:^{
    //SetViewLeftUp(leftView, 0, 0);
    }];
    
    
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


#pragma mark - UIColumnViewDelegate and UIColumnViewDataSource
- (void)columnView:(UIColumnView *)columnView didSelectColumnAtIndex:(NSUInteger)index
{
    
}


- (CGFloat)columnView:(UIColumnView *)columnView widthForColumnAtIndex:(NSUInteger)index
{
    if (index == 0) {
        return 208;
    }else if(index == [[BabyData sharedBabyData] recordCount] + 1){
        return 208;
    }
    return 224;
    
}

- (NSUInteger)numberOfColumnsInColumnView:(UIColumnView *)columnView
{
    
    return [[BabyData sharedBabyData] recordCount] + 2;

}

- (UITableViewCell *)columnView:(UIColumnView *)columnView viewForColumnAtIndex:(NSUInteger)index
{
    
    if (index == 0) {
        NSString * cellIdentifier = @"LeftCell";
        UITableViewCell *cell = [columnView dequeueReusableCellWithIdentifier:cellIdentifier];
        if (cell == nil)
        {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
            
        }
        [cell setBackgroundColor:[UIColor clearColor]];

        return cell;
    }else if(index == [[BabyData sharedBabyData] recordCount] + 1){
        NSString * cellIdentifier = @"RightCell";
        UITableViewCell *cell = [columnView dequeueReusableCellWithIdentifier:cellIdentifier];
        if (cell == nil)
        {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
            
        }
        [cell setBackgroundColor:[UIColor clearColor]];

        return cell;
    }
    static NSString *identity = @"bodyInfoCell";
    BodyInfoTableViewCell *cell = (BodyInfoTableViewCell *)[columnView dequeueReusableCellWithIdentifier:identity];
    if (!cell)
    {
        cell = [[BodyInfoTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identity];
    }
    [cell setBackgroundColor:[UIColor clearColor]];
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    [cell setInfoIndex:index - 1];
    return cell;
    
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    if ([MainTabBarController sharedMainViewController].isVertical) {
        CGPoint pos = scrollView.contentOffset;
        NSInteger index = pos.x /224;
        pos.x = index*224;
        [scrollView setContentOffset:pos animated:YES];
    }else{
        CGPoint pos = scrollView.contentOffset;
        NSInteger index = pos.y /136;
        pos.y = index*136 ;
        [scrollView setContentOffset:pos animated:YES];
    }

}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    changedVH = NO;

}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (!changedVH) {
        CGPoint pos = scrollView.contentOffset;
        if ([MainTabBarController sharedMainViewController].isVertical) {
            NSInteger num = (pos.x + 208)/224;
            if (num != recordIndex) {
                if ( num < [[BabyData sharedBabyData] recordCount] && num >=0) {
                    PostNotification(Noti_ShowBodyRecord, [NSNumber numberWithInt:num ] );
                    recordIndex = num;
                }
            }
            
        }else{
            NSInteger num = pos.y/136 ;
            if (num != recordIndex) {
                if ( num < [[BabyData sharedBabyData] recordCount] && num >=0) {
                    PostNotification(Noti_ShowBodyRecord, [NSNumber numberWithInt:num ] );
                    recordIndex = num;
                }
            }
        }
        
    }

}


@end
