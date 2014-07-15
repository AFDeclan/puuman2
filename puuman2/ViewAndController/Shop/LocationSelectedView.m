//
//  LocationSelectedView.m
//  puuman2
//
//  Created by Ra.（祁文龙） on 14-7-15.
//  Copyright (c) 2014年 AFITC. All rights reserved.
//

#import "LocationSelectedView.h"
#import "UniverseConstant.h"
#import "LocationCell.h"

@implementation LocationSelectedView

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
    selectedNum = -1;
    UIImageView *bgImgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0,ViewWidth(self),ViewHeight(self))];
    [self addSubview:bgImgView];
    [self initTableView];
    UIImageView *upImgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0,ViewWidth(self),0)];
    [self addSubview:upImgView];
    UIImageView *downImgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0,ViewWidth(self),0)];
    [self addSubview:downImgView];
 
}

- (void)initTableView
{
    locationTable = [[UITableView alloc] initWithFrame:CGRectMake(ViewWidth(self)-156,0, 156, 300)];
    [locationTable setDelegate:self];
    [locationTable setDataSource:self];
    [locationTable setSeparatorColor:[UIColor clearColor]];
    [locationTable setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [locationTable setShowsHorizontalScrollIndicator:NO];
    [locationTable setShowsVerticalScrollIndicator:NO];
    [locationTable setBackgroundColor:[UIColor clearColor]];
    [self addSubview:locationTable];
                     
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 32;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *identifier = @"LocationCell";
    LocationCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[LocationCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    [cell setFlagIndex:[indexPath row]];
    if ([indexPath row] == selectedNum) {
        [cell setChoose:YES];
    }else{
        [cell setChoose:NO];
    }
    [cell setBackgroundColor:[UIColor clearColor]];
    [cell.contentView setBackgroundColor:[UIColor clearColor]];
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 32;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    selectedNum = [indexPath row];
    PostNotification(Noti_SelectedLocation, [NSNumber numberWithInteger:[indexPath row]]);
}



@end
