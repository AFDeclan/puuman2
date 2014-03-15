//
//  BabyPuumanView.m
//  puuman2
//
//  Created by Ra.（祁文龙） on 14-3-14.
//  Copyright (c) 2014年 AFITC. All rights reserved.
//

#import "BabyPuumanView.h"
#import "ColorsAndFonts.h"
#import "PumanBookModel.h"
#import "PuumanInBookCell.h"
#import "PuumanOutBookCell.h"
#import "MainTabBarController.h"
#import "UIView+AFAnimation.h"
#import "PuumanRulesViewController.h"


@implementation BabyPuumanView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
         SetViewLeftUp(showAndHiddenBtn, 432, 350);
        [self initWithLeftView];
        [self initWithRightView];
    
        
    }
    return self;
}

- (void)refresh
{
    
}

- (void)initWithLeftView
{
    inBookTitle = [[AFTextImgButton alloc] initWithFrame:CGRectMake(0, 0, 216, 64)];
    [inBookTitle setBackgroundColor:[UIColor clearColor]];
    [inBookTitle setTitle:[NSString stringWithFormat:@"入库 %0.1f",[PumanBookModel bookModel].inTotal] andImg:[UIImage imageNamed:@"icon_in_baby.png"] andButtonType:kButtonTypeSeven];
    [inBookTitle setTitleLabelColor:PMColor6];
    [leftView addSubview:inBookTitle];
    outBookTitle = [[AFTextImgButton alloc] initWithFrame:CGRectMake(216, 0, 216, 64)];
    [outBookTitle setBackgroundColor:[UIColor clearColor]];
    [outBookTitle setTitle:[NSString stringWithFormat:@"兑现 %0.1f",[PumanBookModel bookModel].outTotal] andImg:[UIImage imageNamed:@"icon_out_baby.png"] andButtonType:kButtonTypeSeven];
    [outBookTitle setTitleLabelColor:PMColor1];
    [leftView addSubview:outBookTitle];
    
    
    inBookTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 216, 0)];
    [inBookTable setBackgroundColor:PMColor6];
    [inBookTable setDataSource:self];
    [inBookTable setDelegate:self];
    [leftView addSubview:inBookTable];
    [inBookTable setSeparatorColor:[UIColor clearColor]];
    [inBookTable setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [inBookTable setShowsHorizontalScrollIndicator:NO];
    [inBookTable setShowsVerticalScrollIndicator:NO];
    
    
    outBookTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 216, 0)];
    [outBookTable setBackgroundColor:PMColor4];
    [outBookTable setDataSource:self];
    [outBookTable setDelegate:self];
    [leftView addSubview:outBookTable];
    [outBookTable setSeparatorColor:[UIColor clearColor]];
    [outBookTable setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [outBookTable setShowsHorizontalScrollIndicator:NO];
    [outBookTable setShowsVerticalScrollIndicator:NO];
    
    
}

- (void)initWithRightView
{
    icon_coin = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 96, 96)];
    [icon_coin setImage:[UIImage imageNamed:@"pic_coin_baby.png"]];
    [rightView addSubview:icon_coin];
    
    _numLabel_puuman = [[ADTickerLabel alloc] initWithFrame:CGRectMake(0, 0, 224, 80)];
    _numLabel_puuman.characterWidth = 40;
    _numLabel_puuman.notNumCharacterWidth = 24;
    _numLabel_puuman.font = PMFont(80);
    _numLabel_puuman.textColor = PMColor6;
    [rightView addSubview:_numLabel_puuman];
    [_numLabel_puuman setBackgroundColor:[UIColor clearColor]];
    _numLabel_record = [[ADTickerLabel alloc] initWithFrame:CGRectMake(0, 0, 224, 64)];
    _numLabel_record.font = PMFont(64);
    _numLabel_record.textColor = PMColor6;
    _numLabel_record.characterWidth = 32;
    _numLabel_record.notNumCharacterWidth = 20;
    _numLabel_record.backgroundColor = [UIColor clearColor];
    [rightView addSubview:_numLabel_record];
    
    
    
    label_puuman = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 216, 16)];
    [label_puuman setBackgroundColor:[UIColor clearColor]];
    [label_puuman setFont:PMFont2];
    [label_puuman setTextColor:PMColor3];
    [label_puuman setText:@"您现在拥有扑满金币"];
    [label_puuman setTextAlignment:NSTextAlignmentCenter];
    [rightView addSubview:label_puuman];
    
    label_record = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 216, 16)];
    [label_record setBackgroundColor:[UIColor clearColor]];
    [label_record setFont:PMFont2];
    [label_record setTextColor:PMColor3];
    [label_record setTextAlignment:NSTextAlignmentCenter];
    [label_record setText:@"已经兑现的数额为"];
    [rightView addSubview:label_record];
    ruleBtn = [[ColorButton alloc] init];
    [ruleBtn initWithTitle:@"积累规则" andButtonType:kGrayLeft];
    [ruleBtn setBackgroundColor:[UIColor clearColor]];
    [rightView addSubview:ruleBtn];
    [ruleBtn addTarget:self action:@selector(showRules) forControlEvents:UIControlEventTouchUpInside];
    
    _newAddView = [[UIImageView alloc] initWithFrame:CGRectMake(256, 48, 112, 112)];
    _newAddView.image = [UIImage imageNamed:@"block_new_puuman.png"];
    
    _newAddLabel = [[UILabel alloc] initWithFrame:CGRectMake(28, 40, 72, 24)];
    _newAddLabel.backgroundColor = [UIColor clearColor];
    _newAddLabel.textColor = [UIColor whiteColor];
    _newAddLabel.font = PMFont1;
    _newAddLabel.textAlignment = NSTextAlignmentCenter;
    [_newAddView addSubview:_newAddLabel];
    [rightView addSubview:_newAddView];
    [_newAddView setAlpha:1];
    
    pumanIcon = [[UIImageView alloc] init];
    [pumanIcon setBackgroundColor:[UIColor clearColor]];
    [rightView addSubview:pumanIcon];
}

- (void)showRules
{
    PuumanRulesViewController *infoVC  = [[PuumanRulesViewController alloc] initWithNibName:nil bundle:nil];
    [[MainTabBarController sharedMainViewController].view addSubview:infoVC.view];
    [infoVC setTitle:@"积累规则" withIcon:nil];
    [infoVC setControlBtnType:kOnlyCloseButton];
    [infoVC show];

}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == inBookTable) {
        // Return the number of rows in the section.
        return [[PumanBookModel bookModel].inBooks count];
    }else{
        return [[PumanBookModel bookModel].outBooks count];
    }
    
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == inBookTable) {
        static NSString *identity = @"inBookCell";
        PuumanInBookCell *cell = [tableView dequeueReusableCellWithIdentifier:identity];
        if (!cell)
        {
            cell = [[PuumanInBookCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identity];
        }
        [cell setBackgroundColor:[UIColor clearColor]];
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        [cell setBookInfo:[[PumanBookModel bookModel].inBooks objectAtIndex:[indexPath row]]];
        return cell;
    }else{
        NSString *babyInfoCellIdentifier = @"outBookCell";
        PuumanOutBookCell *cell = [tableView dequeueReusableCellWithIdentifier:babyInfoCellIdentifier];
        if (cell == nil)
        {
            cell = [[PuumanOutBookCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:babyInfoCellIdentifier];
            
        }
        [cell setBackgroundColor:[UIColor clearColor]];
        [cell setBookInfo:[[PumanBookModel bookModel].outBooks objectAtIndex:[indexPath row]]];
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        return cell;
        
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 88;
    
}

-(void)setVerticalFrame
{
    [super setVerticalFrame];
    [leftView setFrame:CGRectMake(-432, 0, 472, 832)];
   [showAndHiddenBtn setAlpha:1];
    [inBookTable setFrame:CGRectMake(0, 64, 216, 768)];
    [outBookTable setFrame:CGRectMake(216, 64, 216, 768)];
    SetViewLeftUp(label_puuman, 196, 176);
    SetViewLeftUp(label_record, 196, 395);
    SetViewLeftUp(icon_coin, 156, 208);
    SetViewLeftUp(_numLabel_record, (608-ViewWidth(_numLabel_record))/2, 423);
    SetViewLeftUp(_numLabel_puuman, (608-ViewWidth(_numLabel_puuman))/2, 234);
    SetViewLeftUp(ruleBtn, 496, 16);
    SetViewLeftUp(_newAddView, 392, 168);
    [pumanIcon setImage:[UIImage imageNamed:@"pic_puuman1_baby.png"]];
    [pumanIcon setFrame:CGRectMake(112, 646, 384, 213)];
}

-(void)setHorizontalFrame
{
    [super setHorizontalFrame];
    [leftView setFrame:CGRectMake(0, 0, 432, 576)];
    [showAndHiddenBtn setAlpha:0];
    [inBookTable setFrame:CGRectMake(0, 64, 216, 512)];
    [outBookTable setFrame:CGRectMake(216, 64, 216, 512)];
    SetViewLeftUp(label_puuman, 544, 96);
    SetViewLeftUp(label_record, 544, 320);
    SetViewLeftUp(icon_coin, 496, 128);
    SetViewLeftUp(_newAddView, 736, 88);
    SetViewLeftUp(_numLabel_record,432+ (432-ViewWidth(_numLabel_record))/2, 346);
    SetViewLeftUp(_numLabel_puuman,432+ (432-ViewWidth(_numLabel_puuman))/2, 146);
    SetViewLeftUp(ruleBtn, 752, 16);
    [pumanIcon setImage:[UIImage imageNamed:@"pic_puuman2_baby.png"]];
    [pumanIcon setFrame:CGRectMake(544, 478, 216, 132)];

}

- (void)fold
{
    [showAndHiddenBtn foldWithDuration:0.3];
    [UIView animateWithDuration:0.3 animations:^{
        SetViewLeftUp(leftView, -432, 0);
    }];
    
}

- (void)unfold
{
    [showAndHiddenBtn unfoldWithDuration:0.3];
    [UIView animateWithDuration:0.3 animations:^{
        SetViewLeftUp(leftView, 0, 0);
    }];
}

- (void)setNums
{

    _numLabel_puuman.text = @"";
    _numLabel_record.text = @"";
    UserInfo *uInfo = [UserInfo sharedUserInfo];
    NSString *key = [NSString stringWithFormat:@"%@_%d", kUserDefaultKey_PumanCntShowed, uInfo.BID];
    CGFloat newAdd = [uInfo pumanQuan] - [[NSUserDefaults standardUserDefaults] doubleForKey:key];
    _newAddLabel.text = [NSString stringWithFormat:@"%.1f", newAdd];
    [[NSUserDefaults standardUserDefaults] setDouble:[uInfo pumanQuan] forKey:key];
   // if (newAdd > 0) _newAddView.alpha = 1; else _newAddView.alpha = 0;

    
     NSString *bookOut = [NSString stringWithFormat:@"%.1f", [PumanBookModel bookModel].outTotal];
    _numLabel_record.text = bookOut;
    [[NSUserDefaults standardUserDefaults] setDouble:[uInfo pumanQuan] forKey:key];

    NSString *puuman = [NSString stringWithFormat:@"%.1f", uInfo.pumanQuan];
    [_numLabel_puuman setText:puuman];
    if ([MainTabBarController sharedMainViewController].isVertical) {
        [self setVerticalFrame];
    }else{
        [self setHorizontalFrame];
    }
    
    [pumanIcon showInFrom:kAFAnimationBottom inView:rightView withFade:YES duration:0.5 delegate:self startSelector:nil stopSelector:nil];

    
}


@end
