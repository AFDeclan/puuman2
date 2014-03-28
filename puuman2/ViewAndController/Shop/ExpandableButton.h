//
//  ExpandableButton.h
//  puman
//
//  Created by 祁文龙 on 13-12-19.
//  Copyright (c) 2013年 创始人团队. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AFButton.h"
@interface ExpandableButton : AFButton
{
    UILabel *titleLabel;
    UIImageView *icon;
    UIImageView *line;
}

- (void)setTitle:(NSString *)title;
- (void)setIsExpand:(BOOL)isExpand;
@end
