//
//  WareCell.m
//  puman
//
//  Created by 陈晔 on 13-9-13.
//  Copyright (c) 2013年 创始人团队. All rights reserved.
//

#import "WareCell.h"
#import "WareCellSubView.h"
#import "UniverseConstant.h"

@implementation WareCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.contentView.backgroundColor = PMColor5;
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        CGRect frame = CGRectMake(4, 16, 200, 256);
        for (int i=0; i<3; i++)
        {
            _wareView[i] = [[WareCellSubView alloc] initWithFrame:frame];
            [self.contentView addSubview:_wareView[i]];
            frame.origin.x += frame.size.width;
        }
    }
    return self;
}

- (void)setWares:(NSArray *)wares
{
    _wares = wares;
    for (int i=0; i<3; i++)
    {
        if (i >= [wares count])
        {
            [_wareView[i] setWare:nil];
        }
        else {
            [_wareView[i] setWare:[wares objectAtIndex:i]];
        }
    }
}

- (void)prepareForReuse
{
    for (int i=0; i<3; i++)
        [_wareView[i] prepareForReuse];
}

@end
