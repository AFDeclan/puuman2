//
//  TopicTitleCell.m
//  puuman2
//
//  Created by Ra.（祁文龙） on 14-3-21.
//  Copyright (c) 2014年 AFITC. All rights reserved.
//

#import "TopicTitleCell.h"
#import "ColorsAndFonts.h"

@implementation TopicTitleCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)initialization
{
    bgImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 608, 144)];
    [self addSubview:bgImageView];
    
    info_title = [[UILabel alloc] initWithFrame:CGRectMake(80, 48, 320, 28)];
    [info_title setBackgroundColor:[UIColor clearColor]];
    [info_title setFont:PMFont1];
    [self addSubview:info_title];
    info_num = [[UILabel alloc] initWithFrame:CGRectMake(80, 76, 320, 20)];
    [info_num setBackgroundColor:[UIColor clearColor]];
    [info_num setFont:PMFont2];
    [info_num setTextColor:PMColor3];
    [self addSubview:info_num];
    [info_title setText:@"宝宝都有哪些糗事？"];
    [info_num setText:@"已有2035人参与"];
    
}

-(void)setTitleViewWithTopic:(Topic *)topic
{
    [info_title setText:topic.TTitle];
    [info_num setText:[NSString stringWithFormat:@"已有%d人参与",topic.TNo]];
    
}

@end
