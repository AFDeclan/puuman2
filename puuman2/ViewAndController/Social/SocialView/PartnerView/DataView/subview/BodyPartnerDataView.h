//
//  HeightPartnerDataView.h
//  puuman2
//
//  Created by Ra.（祁文龙） on 14-3-26.
//  Copyright (c) 2014年 AFITC. All rights reserved.
//

#import "PartnerDataCellView.h"

@interface BodyPartnerDataView : PartnerDataCellView
{
    float max ;
    float min;
}

@property(nonatomic,assign)BOOL isHeight;
@end
