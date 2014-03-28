//
//  InsuranceCell.m
//  puman
//
//  Created by 祁文龙 on 13-11-11.
//  Copyright (c) 2013年 创始人团队. All rights reserved.
//

#import "InsuranceCell.h"
#import "InsuranceCellSubview.h"
#import "UniverseConstant.h"
@implementation InsuranceCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.contentView.backgroundColor = PMColor4;
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        CGRect frame = CGRectMake(0, 16, 208, 256);
        for (int i=0; i<3; i++)
        {
            _insuranceView[i] = [[InsuranceCellSubview alloc] initWithFrame:frame];
            [self.contentView addSubview:_insuranceView[i]];
            frame.origin.x += frame.size.width + 8;
        }
        
    }
    return self;
}

- (void)setInsurances:(NSArray *)insurances;
{
    _insurances = insurances;
    for (int i=0; i<3; i++)
    {
        if (i >= [insurances count])
        {
            [_insuranceView[i] setInsurance:nil];
        }
        else {
            [_insuranceView[i] setInsurance:[insurances objectAtIndex:i]];
        }
    }
}


@end
