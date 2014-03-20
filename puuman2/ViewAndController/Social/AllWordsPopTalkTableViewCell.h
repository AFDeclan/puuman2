//
//  AllWordsPopTalkTableViewCell.h
//  puuman2
//
//  Created by Ra.（祁文龙） on 14-3-20.
//  Copyright (c) 2014年 AFITC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TextLayoutLabel.h"

@interface AllWordsPopTalkTableViewCell : UITableViewCell<UITableViewDataSource,UITableViewDelegate>
{
    UIImageView *portrait;
    UILabel *name;
    UILabel *status;
    UIImageView *icon_sex;
    TextLayoutLabel *detail;
}
- (void)setCellWithTalk:(NSDictionary *)talkInfo;
+ (CGFloat)heightForTalk:(NSDictionary *)talkInfo;
@end
