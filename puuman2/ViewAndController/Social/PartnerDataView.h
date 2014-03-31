//
//  PartnerDataView.h
//  puuman2
//
//  Created by Ra.（祁文龙） on 14-3-19.
//  Copyright (c) 2014年 AFITC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Friend.h"
#import "PartnerDataInGroupView.h"
#import "PartnerDataOutGroupView.h"

@interface PartnerDataView : UIView<FriendDelegate>
{
    PartnerDataInGroupView *inGroupView;
    PartnerDataOutGroupView *outGroupView;
}
- (void)setVerticalFrame;
- (void)setHorizontalFrame;
@end
