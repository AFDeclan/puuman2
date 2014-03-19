//
//  PartnerView.h
//  puuman2
//
//  Created by Ra.（祁文龙） on 14-3-19.
//  Copyright (c) 2014年 AFITC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PartnerDataView.h"
#import "PartnerChatView.h"

@interface PartnerView : UIView
{
    PartnerDataView *partnerData;
    PartnerChatView *partnerChat;
}
- (void)selectedData;
- (void)selectedChat;
- (void)setVerticalFrame;
- (void)setHorizontalFrame;
@end
