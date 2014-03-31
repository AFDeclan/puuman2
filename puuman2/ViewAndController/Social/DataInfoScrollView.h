//
//  DataInfoScrollView.h
//  puuman2
//
//  Created by Ra.（祁文龙） on 14-3-25.
//  Copyright (c) 2014年 AFITC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BodyPartnerDataView.h"
#import "PropWarePartnerDataView.h"
#import "PuumanRankPartnerDataView.h"
#import "VaccinePartnerDataView.h"
#import "Group.h"


@interface DataInfoScrollView : UIScrollView<UIScrollViewDelegate>
{
    BodyPartnerDataView *heightView;
    BodyPartnerDataView *weightView;
    VaccinePartnerDataView *vaccineView;
    PuumanRankPartnerDataView *puumanRankView;
    PropWarePartnerDataView *propWareView[5];

}
- (void)reloadWithGroupInfo:(Group *)group;
- (void)setVerticalFrame;
- (void)setHorizontalFrame;
@end
