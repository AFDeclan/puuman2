//
//  DataDetailInfoCell.h
//  puuman2
//
//  Created by Ra.（祁文龙） on 14-3-25.
//  Copyright (c) 2014年 AFITC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HeightHistogramView.h"
#import "WeightHistogramView.h"
#import "VaccineDataView.h"
#import "PuumanRankDataView.h"
#import "PropWareDataView.h"

@interface DataDetailInfoCell : UITableViewCell
{
    HeightHistogramView *heightView;
    WeightHistogramView *weightView;
    VaccineDataView *vaccineView;
    PuumanRankDataView *puumanRankView;
    PropWareDataView *propWare[5];

    
}
@end
