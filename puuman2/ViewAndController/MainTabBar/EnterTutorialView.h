//
//  EnterTutorialView.h
//  puman
//
//  Created by 陈晔 on 13-9-6.
//  Copyright (c) 2013年 创始人团队. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EnterTutorialView : UIView
{
    UIImageView *courseView[3];
    UIScrollView *scrollView;
    BOOL isVertical;
    UIButton *startBtn;
}


@end
