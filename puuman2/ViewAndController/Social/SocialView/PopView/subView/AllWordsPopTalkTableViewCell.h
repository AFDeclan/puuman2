//
//  AllWordsPopTalkTableViewCell.h
//  puuman2
//
//  Created by Ra.（祁文龙） on 14-3-20.
//  Copyright (c) 2014年 AFITC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AdaptiveLabel.h"
#import "BasicInfoView.h"
@interface AllWordsPopTalkTableViewCell : UITableViewCell
{
    BasicInfoView *infoView;
    AdaptiveLabel *mainTextView;
}
-(void)buildWithUid:(NSInteger)uid andIndex:(NSInteger)index andCommmet:(NSString *)comment;
+ (CGFloat)heightForComment:(NSString *)comment;
@end