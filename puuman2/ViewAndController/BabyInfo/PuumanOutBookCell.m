//
//  PuumanOutBookCell.m
//  puuman2
//
//  Created by Ra.（祁文龙） on 14-3-14.
//  Copyright (c) 2014年 AFITC. All rights reserved.
//

#import "PuumanOutBookCell.h"
#import "ColorsAndFonts.h"
#import "PumanBookModel.h"

@implementation PuumanOutBookCell

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
    out_icon = [[UIImageView alloc] initWithFrame:CGRectMake(20, 20, 40, 40)];
    [out_icon setImage:[UIImage imageNamed:@"circle2_baby.png"]];
    [self.contentView addSubview:out_icon];

    label_out = [[UILabel alloc] initWithFrame:CGRectMake(20, 20, 40, 40)];
    [label_out setFont:PMFont2];
    [label_out setTextAlignment:NSTextAlignmentCenter];
    [label_out setTextColor:PMColor2];
    [label_out setBackgroundColor:[UIColor clearColor]];
    [self.contentView addSubview:label_out];
    label_date = [[UILabel alloc] initWithFrame:CGRectMake(124, 64, 76, 16)];
    [label_date setFont:PMFont3];
    [label_date setTextAlignment:NSTextAlignmentRight];
    [label_date setTextColor:PMColor3];
    [label_date setBackgroundColor:[UIColor clearColor]];
    [self.contentView addSubview:label_date];
    label_title = [[UILabel alloc] initWithFrame:CGRectMake(76, 36, 72, 16)];
    [label_title setFont:PMFont2];
    [label_title setTextColor:PMColor2];
    [label_title setBackgroundColor:[UIColor clearColor]];
    [self.contentView addSubview:label_title];
    
    label_status = [[UILabel alloc] initWithFrame:CGRectMake(72, 8, 128, 16)];
    [label_status setFont:PMFont3];
    [label_status setTextAlignment:NSTextAlignmentRight];
    [label_status setTextColor:PMColor3];
    [label_status setBackgroundColor:[UIColor clearColor]];
    [self.contentView addSubview:label_status];
    UIImageView *partLine  = [[UIImageView alloc] initWithFrame:CGRectMake(0, 86, 216, 2)];
    [partLine setImage:[UIImage imageNamed:@"line3_baby.png"]];
    [partLine setAlpha:0.5];
    [self.contentView addSubview:partLine];
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setBookInfo:(NSDictionary *)bookInfo
{
    label_out.text = [bookInfo valueForKey:kBookBonusKey];
    label_date.text = [bookInfo valueForKey:kBookDateKey];
    label_title.text = [bookInfo valueForKey:kBookTitleKey];
  
    NSInteger status =[[bookInfo valueForKey:kBookStatusKey] integerValue];
    if (status > 1)
    {
      label_status.text = @"已返利";

    }
    else
    {
        if (status) {
            label_status.text = [NSString stringWithFormat:@"确认中 已返%@", [bookInfo valueForKey:kBookPaidKey]];
        }else{
            label_status.text = @"返利中";
        }
    }

}
@end
