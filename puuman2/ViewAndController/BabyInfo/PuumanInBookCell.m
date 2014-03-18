//
//  PuumanInBookCell.m
//  puuman2
//
//  Created by Ra.（祁文龙） on 14-3-14.
//  Copyright (c) 2014年 AFITC. All rights reserved.
//

#import "PuumanInBookCell.h"
#import "ColorsAndFonts.h"
#import "PumanBookModel.h"

@implementation PuumanInBookCell

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
 
    
    in_icon = [[UIImageView alloc] initWithFrame:CGRectMake(20, 20, 40, 40)];
    [in_icon setImage:[UIImage imageNamed:@"circle1_baby.png"]];
    [self.contentView addSubview:in_icon];
    
    label_in = [[UILabel alloc] initWithFrame:CGRectMake(20, 20, 40, 40)];
    [label_in setFont:PMFont2];
    [label_in setTextAlignment:NSTextAlignmentCenter];
    [label_in setTextColor:[UIColor whiteColor]];
    [label_in setBackgroundColor:[UIColor clearColor]];
    [self.contentView addSubview:label_in];
    
    label_staus = [[UILabel alloc] initWithFrame:CGRectMake(76, 36, 72, 16)];
    [label_staus setFont:PMFont2];
    [label_staus setTextColor:[UIColor whiteColor]];
    [label_staus setBackgroundColor:[UIColor clearColor]];
    [self.contentView addSubview:label_staus];
    
    label_date = [[UILabel alloc] initWithFrame:CGRectMake(124, 64, 76, 16)];
    [label_date setFont:PMFont3];
    [label_date setTextAlignment:NSTextAlignmentRight];
    [label_date setBackgroundColor:[UIColor clearColor]];
    [label_date setTextColor:PMColor7];
    [self.contentView addSubview:label_date];
    
    UIImageView *partLine  = [[UIImageView alloc] initWithFrame:CGRectMake(0, 86, 216, 2)];
    [partLine setImage:[UIImage imageNamed:@"line1_baby.png"]];
    [partLine setAlpha:0.5];
    [self.contentView addSubview:partLine];
}

- (void)setBookInfo:(NSDictionary *)bookInfo
{
    label_in.text = [bookInfo valueForKey:kBookBonusKey];
    label_staus.text = [bookInfo valueForKey:kBookTitleKey];
    label_date.text = [bookInfo valueForKey:kBookDateKey];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
