//
//  DataDetailInfoCell.m
//  puuman2
//
//  Created by Ra.（祁文龙） on 14-3-25.
//  Copyright (c) 2014年 AFITC. All rights reserved.
//

#import "DataDetailInfoCell.h"
#import "UniverseConstant.h"

@implementation DataDetailInfoCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
      
        [self initialization];
        
    }
    return self;
}




-(void)initialization
{
    heightView = [[HeightHistogramView alloc] initWithFrame:CGRectMake(0, 0, 96, 224)];
    [heightView setHeight:200 andTheDate:nil andHighest:200 andLowest:50];
    [self.contentView addSubview:heightView];
    weightView = [[WeightHistogramView alloc] initWithFrame:CGRectMake(0, ViewY(heightView)+ViewHeight(heightView), 96, 224)];
    [weightView setWeight:20 andTheDate:nil andMax:50 andMin:10];
    [self.contentView addSubview:weightView];
   
    
    for (int i =0; i <5; i++) {
        propWare[i] = [[PropWareDataView alloc] initWithFrame:CGRectMake(0, i*136+ViewY(weightView)+ViewHeight(weightView), 96, 136)];
        [propWare[i] setDataWithWareName:@"奶瓶" andStatus:@"购买了" andWarePic:@""];
        [propWare[i] setBackgroundColor:[UIColor clearColor]];
        [self.contentView addSubview:propWare[i]];
    }
    
    vaccineView = [[VaccineDataView alloc] initWithFrame:CGRectMake(0, ViewY(propWare[4])+ViewHeight(propWare[4]), 96, 112)];
    [vaccineView setVaccineDoneNum:2 andShouldDoneNum:3];
    [self.contentView addSubview:vaccineView];
    puumanRankView = [[PuumanRankDataView alloc] initWithFrame:CGRectMake(0, ViewY(vaccineView)+ViewHeight(vaccineView), 96, 192)];
    [puumanRankView setPumanWithNum:50 andRank:2];
    [self.contentView addSubview:puumanRankView];
};

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
