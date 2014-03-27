//
//  PuumanPartnerDataCell.m
//  puuman2
//
//  Created by Ra.（祁文龙） on 14-3-26.
//  Copyright (c) 2014年 AFITC. All rights reserved.
//

#import "PuumanPartnerDataCell.h"
#import "ColorsAndFonts.h"
#import "UniverseConstant.h"

@implementation PuumanPartnerDataCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        rank_icon = [[UIImageView alloc] initWithFrame:CGRectMake(0, 88, 96, 104)];
        [self addSubview:rank_icon];
        puuman_label  = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 96, 24)];
        [puuman_label setBackgroundColor:[UIColor clearColor]];
        [puuman_label setTextColor:PMColor1];
        [puuman_label setFont:PMFont1];
        [puuman_label setTextAlignment:NSTextAlignmentCenter];
        [self addSubview:puuman_label];
    }
    return self;
}

- (void)setPumanWithNum:(float)puumanNum andRank:(NSInteger)rank
{
    [puuman_label setText:[NSString stringWithFormat:@"%0.1f",puumanNum]];
    [rank_icon setAlpha:1];
    if (rank == 1) {
        [rank_icon setImage:[UIImage imageNamed:@"pic_dais1_fri.png"]];
        SetViewLeftUp(puuman_label, 0, 32);
    }else if(rank ==2)
    {
        [rank_icon setImage:[UIImage imageNamed:@"pic_dais2_fri.png"]];
        
        SetViewLeftUp(puuman_label, 0, 52);
    }else if (rank == 3){
        [rank_icon setImage:[UIImage imageNamed:@"pic_dais3_fri.png"]];
        
        SetViewLeftUp(puuman_label, 0, 72);
    }else{
        [rank_icon setAlpha:0];
        SetViewLeftUp(puuman_label, 0, 98);
    }
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end