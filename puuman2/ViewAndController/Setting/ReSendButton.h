//
//  ReSendButton.h
//  PuumanForPhone
//
//  Created by 祁文龙 on 14-1-9.
//  Copyright (c) 2014年 Declan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ReSendButton : UIButton
{
    UIImageView * mask;
    UILabel *count;
    NSTimer *aniTimer;
}
- (void)startSend;
@end
