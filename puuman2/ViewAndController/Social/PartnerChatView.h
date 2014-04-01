//
//  PartnerChatView.h
//  puuman2
//
//  Created by Ra.（祁文龙） on 14-3-19.
//  Copyright (c) 2014年 AFITC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AdaptiveLabel.h"
#import "TextLayoutLabel.h"



@interface PartnerChatView : UIView<UITableViewDataSource,UITableViewDelegate>
{
    UIView *bgHeadView;
    UIImageView *icon_head;
    UITableView *chatTable;
    UILabel *noti_label;
    UILabel *info_title;
   
}


- (void)setVerticalFrame;
- (void)setHorizontalFrame;

@end
