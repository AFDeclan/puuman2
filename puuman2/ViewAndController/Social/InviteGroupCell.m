//
//  InviteGroupCell.m
//  puuman2
//
//  Created by Ra.（祁文龙） on 14-3-31.
//  Copyright (c) 2014年 AFITC. All rights reserved.
//

#import "InviteGroupCell.h"
#import "FigureHeaderCell.h"
#import "UniverseConstant.h"

@implementation InviteGroupCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        figuresColumnView = [[UIColumnView alloc] initWithFrame:CGRectMake(22, 48, 576, 120)];
        [figuresColumnView setBackgroundColor:[UIColor clearColor]];
        [figuresColumnView setViewDelegate:self];
        [figuresColumnView setViewDataSource:self];
        [figuresColumnView setPagingEnabled:NO];
        [figuresColumnView setScrollEnabled:YES];
        [self addSubview:figuresColumnView];
        addBtn = [[ColorButton alloc] init];
        [addBtn initWithTitle:@"加入" andButtonType:kGrayLeft];
        SetViewLeftUp(addBtn, 496, 144);

    }
    return self;
}

- (void)awakeFromNib
{
    // Initialization code
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
    
    return 96;
    
}

- (NSUInteger)numberOfColumnsInColumnView:(UIColumnView *)columnView
{
    
    return 6;
    
}

- (UITableViewCell *)columnView:(UIColumnView *)columnView viewForColumnAtIndex:(NSUInteger)index
{
    
    NSString * cellIdentifier = @"FigursHeader";
    FigureHeaderCell *cell = (FigureHeaderCell *)[columnView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil)
    {
        cell = [[FigureHeaderCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        
    }
    [cell setRecommend:NO];
    [cell setBackgroundColor:[UIColor clearColor]];
    return cell;
    
}


@end
