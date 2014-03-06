//
//  TimeView.h
//  puman
//
//  Created by Ra.（祁文龙） on 14-2-11.
//  Copyright (c) 2014年 创始人团队. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TimeView : UIView
{
    UILabel *minuteLabel;
    UILabel *secondLabel;
    NSTimer *timer;
    int videoTime;
}
- (void)showTimeWithSecond:(NSInteger)time;
- (void)startRecord;
- (void)stopRecord;
@end
