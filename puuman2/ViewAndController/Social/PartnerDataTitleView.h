//
//  PartnerDataTitleView.h
//  puuman2
//
//  Created by Ra.（祁文龙） on 14-3-24.
//  Copyright (c) 2014年 AFITC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIColumnView.h"

@interface PartnerDataTitleView : UIView<UIColumnViewDataSource, UIColumnViewDelegate>
{
    UIView *bgHeadView;
    UIImageView *icon_head;
    UITableView *chatTable;
    UILabel *noti_label;
    UILabel *info_title;
    UIColumnView *portraitsView;
}
@end