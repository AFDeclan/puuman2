//
//  DiaryNewButton.h
//  puman
//
//  Created by 祁文龙 on 13-12-25.
//  Copyright (c) 2013年 创始人团队. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum{
    ImportDiary = 0,
    TextDiary,
    AudioDiary,
    CameraDiary,
    VideoDiary
}NewButtonType;
@interface DiaryNewButton : UIView
{
    UIScrollView *bgCommon;
    UIButton *commonBtn;
    UIButton *newBtn;
    BOOL perVertical;
}
- (void)showBtns;
- (void)setShowStatus;
- (void)hiddenBtns;
- (void)setHideStatus;
- (BOOL)directionChangedWithVertical:(BOOL)vertical;
@property(assign,nonatomic)  NewButtonType commonBtnType;
@property(assign,nonatomic)  BOOL newBtnShowed;
@end
