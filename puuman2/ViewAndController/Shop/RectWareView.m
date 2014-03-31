//
//  RectWareView.m
//  puuman2
//
//  Created by Ra.（祁文龙） on 14-3-27.
//  Copyright (c) 2014年 AFITC. All rights reserved.
//

#import "RectWareView.h"
#import "ColorsAndFonts.h"
#import "RectHeadShowCell.h"
#import "RectRankCell.h"

@implementation RectWareView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self setBackgroundColor:[UIColor clearColor]];
        // _model = [[RecomModel alloc] init];
        rectTable = [[UITableView alloc] initWithFrame:CGRectMake(8, 0, 592, 904)];
        [rectTable setDataSource:self];
        [rectTable setDelegate:self];
        [self addSubview:rectTable];
        [rectTable setBackgroundColor:[UIColor clearColor]];
        [rectTable setSeparatorColor:[UIColor clearColor]];
        [rectTable setSeparatorStyle:UITableViewCellSeparatorStyleNone];
        [rectTable setShowsHorizontalScrollIndicator:NO];
        [rectTable setShowsVerticalScrollIndicator:NO];
        [rectTable setContentSize:CGSizeMake(592, 904)];
      
    }
    return self;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 4;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([indexPath row] == 0) {
        NSString *identifier = @"RectHeadCell";
        RectHeadShowCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (cell == nil)
        {
            cell = [[RectHeadShowCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
            
        }
        [cell reloadDataWithData:_model.topWares];
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        [cell.contentView setBackgroundColor:[UIColor whiteColor]];
        return cell;

    }else{
        NSString *identifier = @"RectRankCell";
        RectRankCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (cell == nil)
        {
            cell = [[RectRankCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
            
        }
        if ([indexPath row] == 1) {
            [cell setDataViewRectRanks:_model.hotWares andRectTypeIndex:[indexPath row] ];
        }else if ([indexPath row] == 2)
        {
            [cell setDataViewRectRanks:_model.discountWares andRectTypeIndex:[indexPath row]];
        }else if ([indexPath row]==3)
        {
            [cell setDataViewRectRanks:_model.inUseWares andRectTypeIndex:[indexPath row]];
        }
        
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        [cell.contentView setBackgroundColor:[UIColor whiteColor]];
        return cell;
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([indexPath row] == 0) {
        return 480;
    }else{
        return 136;
    }
    
}


- (void)setVerticalFrame
{
    [rectTable setScrollEnabled:NO];
    [rectTable setFrame:CGRectMake(8, 0, 592, 904)];
}

- (void)setHorizontalFrame
{
    [rectTable setScrollEnabled:YES];
    [rectTable setFrame:CGRectMake(24, 0, 592, 688)];
}

@end
