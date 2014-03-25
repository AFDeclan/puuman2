//
//  VaccineDataView.m
//  puuman2
//
//  Created by Ra.（祁文龙） on 14-3-25.
//  Copyright (c) 2014年 AFITC. All rights reserved.
//

#import "VaccineDataView.h"
#import "ColorsAndFonts.h"

@implementation VaccineDataView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        label_vaccine_should = [[UILabel alloc] initWithFrame:CGRectMake(0, 42, frame.size.width,16 )];
        [label_vaccine_should setBackgroundColor:[UIColor clearColor]];
        [label_vaccine_should setTextColor:PMColor2];
        [label_vaccine_should setFont:PMFont3];
        [label_vaccine_should setTextAlignment:NSTextAlignmentCenter];
        [self addSubview:label_vaccine_should];
        label_vaccine_finished= [[UILabel alloc] initWithFrame:CGRectMake(0, 62, frame.size.width,16 )];
        [label_vaccine_finished setBackgroundColor:[UIColor clearColor]];
        [label_vaccine_finished setTextColor:PMColor2];
        [label_vaccine_finished setFont:PMFont3];
        [label_vaccine_finished setTextAlignment:NSTextAlignmentCenter];
        [self addSubview:label_vaccine_finished];
    }
    return self;
}

- (void)setVaccineDoneNum:(NSInteger)doneNum andShouldDoneNum:(NSInteger)shouldDoneNum
{
    [label_vaccine_finished setText:[NSString stringWithFormat:@"已接种%d个",doneNum]];
    [label_vaccine_should setText:[NSString stringWithFormat:@"应接种%d个",shouldDoneNum]];
}

@end
