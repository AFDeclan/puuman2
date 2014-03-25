//
//  TopicSelectButton.h
//  puuman2
//
//  Created by Ra.（祁文龙） on 14-3-19.
//  Copyright (c) 2014年 AFITC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TopicSelectButton : UIButton
{
    UIImageView *icon_left;
    UIImageView *icon_right;
    UILabel *label_title;
    UILabel *label_noti;
    
}

- (void)setTitleName:(NSString *)title;
- (void)setDirection:(BOOL)isRight;
- (void)setNoti:(NSString *)noti;
@end
