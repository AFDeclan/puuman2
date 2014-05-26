//
//  TopicCommentCell.h
//  puuman2
//
//  Created by Ra.（祁文龙） on 14-5-23.
//  Copyright (c) 2014年 AFITC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AdaptiveLabel.h"
#import "BasicInfoView.h"
#import "Comment.h"

@interface TopicCommentCell : UIView
{
    BasicInfoView *infoView;
    AdaptiveLabel *mainTextView;
}

- (void)buildWithComment:(Comment *)comment;
@end
