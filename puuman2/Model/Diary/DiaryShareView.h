//
//  DiaryShareView.h
//  PuumanForPhone
//
//  Created by Ra.（祁文龙） on 14-1-25.
//  Copyright (c) 2014年 Declan. All rights reserved.
//

#import "CustomPopUpView.h"


@interface DiaryShareView : CustomPopUpView
{
    UIView *contentView;
    UIButton *weibo;
    UIButton *weixin;
    UILabel *weiBoLabel;
    UILabel *weixinLabel;
    NSString *shareText;
    NSString *shareTitle;
    UIImage *shareImg;
}
- (void)setInfoWithText:(NSString *)text_ title:(NSString *)title_ image:(UIImage*)img_;

@end
