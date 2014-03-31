//
//  InviteGroupCell.h
//  puuman2
//
//  Created by Ra.（祁文龙） on 14-3-31.
//  Copyright (c) 2014年 AFITC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIColumnView.h"
#import "ColorButton.h"

@interface InviteGroupCell : UITableViewCell<UIColumnViewDataSource, UIColumnViewDelegate>
{
    UILabel *noti_Title;
    UILabel *date_invite;
    UIColumnView *figuresColumnView;
    ColorButton *addBtn;
}
@end
