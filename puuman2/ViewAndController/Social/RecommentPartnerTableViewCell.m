//
//  RecommentPartnerTableViewCell.m
//  puuman2
//
//  Created by Ra.（祁文龙） on 14-3-20.
//  Copyright (c) 2014年 AFITC. All rights reserved.
//

#import "RecommentPartnerTableViewCell.h"
#import "ColorsAndFonts.h"

@implementation RecommentPartnerTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        [self initialization];
    }
    return self;
}

- (void)initialization
{
    label_first = [[UILabel alloc] initWithFrame:CGRectMake(66, 0, 366, 16)];
    [label_first setBackgroundColor:[UIColor clearColor]];
    [label_first setFont:PMFont2];
    [label_first setTextColor:PMColor2];
    [label_first setTextAlignment:NSTextAlignmentCenter];
    [self addSubview:label_first];
    
    label_second = [[UILabel alloc] initWithFrame:CGRectMake(66, 0, 366, 16)];
    [label_second setBackgroundColor:[UIColor clearColor]];
    [label_second setFont:PMFont2];
    [label_second setTextColor:PMColor2];
    [label_second setTextAlignment:NSTextAlignmentCenter];
    [self addSubview:label_second];
    label_compare = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 144, 80)];
    [label_compare setBackgroundColor:[UIColor clearColor]];
    [label_compare setFont:PMFont2];
    [label_compare setTextColor:PMColor1];
    [label_compare setTextAlignment:NSTextAlignmentCenter];
    [self addSubview:label_compare];
    
    line = [[UIImageView alloc] init];
    [line setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@""]]];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
