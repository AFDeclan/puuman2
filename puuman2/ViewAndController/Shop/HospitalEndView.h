//
//  HospitalEndView.h
//  puman
//
//  Created by 祁文龙 on 13-12-21.
//  Copyright (c) 2013年 创始人团队. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol HospitalEndViewDelegate;
@interface HospitalEndView : UIView
{
    UIImageView *bgView;
    UIImageView *envelope;
    UIImageView *verticalenvelope;
    UIImageView *envelopeBg;
    UIImageView *letter;
    UIImageView *arrow;
    UIButton *arrowBtn;
}
@property (weak,nonatomic)id<HospitalEndViewDelegate>delegate;
-(void)startAnimate;

@end
@protocol HospitalEndViewDelegate <NSObject>

- (void)envelopeOpened;

@end