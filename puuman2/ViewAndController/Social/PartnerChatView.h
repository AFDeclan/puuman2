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
#import "ChatInputViewController.h"


@interface PartnerChatView : UIView<UITableViewDataSource,UITableViewDelegate>
{
    UIView *bgHeadView;
    UIImageView *icon_head;
    UITableView *chatTable;
    UILabel *noti_label;
    UILabel *info_title;
    ChatInputViewController *inputVC;
}
- (void)setVerticalFrame;
- (void)setHorizontalFrame;
- (void)showInputView;
- (void)hiddenInputView;
@end
