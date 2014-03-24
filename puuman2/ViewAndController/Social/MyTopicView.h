//
//  MyTopicView.h
//  puuman2
//
//  Created by Ra.（祁文龙） on 14-3-19.
//  Copyright (c) 2014年 AFITC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyTopicViewController.h"

@interface MyTopicView : UIView
{
    MyTopicViewController *topicAllVC;
}
- (void)setVerticalFrame;
- (void)setHorizontalFrame;
@end
