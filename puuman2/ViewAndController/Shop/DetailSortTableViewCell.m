//
//  DetailSortTableViewCell.m
//  PuumanForPhone
//
//  Created by Ra.（祁文龙） on 14-6-23.
//  Copyright (c) 2014年 Declan. All rights reserved.
//

#import "DetailSortTableViewCell.h"
#import "ShopModel.h"

@implementation DetailSortTableViewCell
@synthesize row = _row;
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        for (int i = 0; i <2; i ++) {
            subCell[i] = [[SortCell alloc] init];
            [subCell[i] setBackgroundColor:[UIColor clearColor]];
            [self.contentView addSubview:subCell[i]];

        }
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

- (void)setRow:(NSInteger)row
{
    _row = row;
    for (int i = 0; i < 2; i ++) {
        if (i+_row*2 - 2 < (_row*2 >[[ShopModel sharedInstance] subClassCnt]?[[ShopModel sharedInstance] subClassCnt]:_row*2)) {
            [subCell[i] setAlpha:1];
            [subCell[i] setFlagTag:i+_row*2 - 2];
            SetViewLeftUp(subCell[i%2], 32 + 96*i , 0);
        }else{
            [subCell[i] setAlpha:0];
        }
    }
 
}

@end
