//
//  DataInfoScrollView.m
//  puuman2
//
//  Created by Ra.（祁文龙） on 14-3-25.
//  Copyright (c) 2014年 AFITC. All rights reserved.
//

#import "DataInfoScrollView.h"
#import "UniverseConstant.h"

@implementation DataInfoScrollView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.delegate = self;
        [self setShowsHorizontalScrollIndicator:NO];
        [self setShowsVerticalScrollIndicator:NO];
        heightView = [[BodyPartnerDataView alloc] initWithFrame:CGRectMake(0, 0, 0, 224)];
        [self addSubview:heightView];
        weightView  = [[BodyPartnerDataView alloc] initWithFrame:CGRectMake(0, ViewY(heightView)+ViewHeight(heightView), 0, 224)];
        [self addSubview:weightView];
        
        for (int i =0; i <5; i++) {
            propWareView[i] = [[PropWarePartnerDataView alloc] initWithFrame:CGRectMake(0, i*136+ViewY(weightView)+ViewHeight(weightView), 0, 136)];
            [self addSubview:propWareView[i]];
        }
        
        vaccineView = [[VaccinePartnerDataView alloc] initWithFrame:CGRectMake(0, ViewY(propWareView[4])+ViewHeight(propWareView[4]), 0, 112)];
        [self addSubview:vaccineView];

        puumanRankView = [[PuumanRankPartnerDataView alloc] initWithFrame:CGRectMake(0, ViewY(vaccineView)+ViewHeight(vaccineView), 0, 224)];
        [self addSubview:puumanRankView];
        
        
    }
    return self;
}


- (void)setVerticalFrame
{
    [heightView setVerticalFrame];
    [weightView setVerticalFrame];
    [vaccineView setVerticalFrame];
    [puumanRankView setVerticalFrame];
    for (int i =0; i <5; i++) {
        [propWareView[i] setVerticalFrame];
    }
    PostNotification(Noti_PartnerDataViewScrolled, [NSNumber numberWithFloat:self.contentOffset.y]);

}
- (void)setHorizontalFrame
{
    [heightView setHorizontalFrame];
    [weightView setHorizontalFrame];
    [vaccineView setHorizontalFrame];
    [puumanRankView setHorizontalFrame];
    for (int i =0; i <5; i++) {
        [propWareView[i] setHorizontalFrame];
    }
    
    PostNotification(Noti_PartnerDataViewScrolled, [NSNumber numberWithFloat:self.contentOffset.y]);

}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (scrollView == self) {
        NSLog(@"%f",self.contentOffset.y);
        PostNotification(Noti_PartnerDataViewScrolled, [NSNumber numberWithFloat:scrollView.contentOffset.y]);
    }
    
}

@end
