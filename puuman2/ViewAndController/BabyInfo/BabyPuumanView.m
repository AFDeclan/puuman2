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

@implementation BabyPuumanView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
         SetViewLeftUp(showAndHiddenBtn, 432, 376);
        [self initWithLeftView];
        if ([MainTabBarController sharedMainViewController].isVertical) {
            [self setVerticalFrame];
        }else{
            [self setHorizontalFrame];
        }
        
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
    [inBookTitle setTintColor:PMColor6];
    [leftView addSubview:inBookTitle];
    outBookTitle = [[AFTextImgButton alloc] initWithFrame:CGRectMake(216, 0, 216, 64)];
    [outBookTitle setBackgroundColor:[UIColor clearColor]];
    [outBookTitle setTitle:[NSString stringWithFormat:@"兑现 %0.1f",[PumanBookModel bookModel].outTotal] andImg:[UIImage imageNamed:@"icon_out_baby.png"] andButtonType:kButtonTypeSeven];
    [outBookTitle setTintColor:PMColor1];
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

    
}

-(void)setHorizontalFrame
{
    [super setHorizontalFrame];
    [leftView setFrame:CGRectMake(0, 0, 432, 576)];
    [showAndHiddenBtn setAlpha:0];
    [inBookTable setFrame:CGRectMake(0, 64, 216, 512)];
    [outBookTable setFrame:CGRectMake(216, 64, 216, 512)];
   
    
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

@end
