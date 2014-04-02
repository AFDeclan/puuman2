//
//  CompareInfoTableViewCell.m
//  puuman2
//
//  Created by Ra.（祁文龙） on 14-4-2.
//  Copyright (c) 2014年 AFITC. All rights reserved.
//

#import "CompareInfoTableViewCell.h"
#import "ColorsAndFonts.h"

@implementation CompareInfoTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        leftContent = [[UILabel alloc] initWithFrame:CGRectMake(24, 0, 144, 32)];
        [leftContent setTextColor:PMColor2];
        [leftContent setFont:PMFont2];
        [leftContent setBackgroundColor:[UIColor clearColor]];
        [leftContent setTextAlignment:NSTextAlignmentRight];
        [self.contentView addSubview:leftContent];
        middleContent = [[UILabel alloc] initWithFrame:CGRectMake(192, 0, 48, 32)];
        [middleContent setTextColor:PMColor3];
        [middleContent setFont:PMFont3];
        [middleContent setBackgroundColor:[UIColor clearColor]];
        [middleContent setTextAlignment:NSTextAlignmentCenter];
        [self.contentView addSubview:middleContent];
        rightContent = [[UILabel alloc] initWithFrame:CGRectMake(264, 0, 144, 32)];
        [rightContent setTextColor:PMColor2];
        [rightContent setFont:PMFont2];
        [rightContent setBackgroundColor:[UIColor clearColor]];
        [rightContent setTextAlignment:NSTextAlignmentLeft];
        [self.contentView addSubview:rightContent];

    }
    return self;
}


- (void)buildCompareCellWithKeyName:(NSString *)key value1:(NSString *)v1 value2:(NSString *)v2 
{
    [middleContent setText:key];
    [leftContent setText:v1];
    [rightContent setText:v2];

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

@end
