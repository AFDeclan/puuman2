//
//  HospitalHomeView.h
//  puman
//
//  Created by 祁文龙 on 13-11-27.
//  Copyright (c) 2013年 创始人团队. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HospitalBigView.h"
#import "HospitalPrivateView.h"
#import "HospitalSmallView.h"
#import "HospitalEndView.h"
@protocol HospitalHomeViewDelegate;
typedef enum{
    kBigHospital,
    kSmallHospital,
    kPrivateHospital,
    kNoneHospital,
    kEndHospital
} HospitalOnShow;
@interface HospitalHomeView : UIView<HospitalEndViewDelegate>
{
    UIButton *bigHospitalBtn;
    UIImageView *bigHospital;
    UIButton *privateHospitalBtn;
    UIImageView *privateHospital;
    UIButton *smallHospitalBtn;
    UIImageView *smallHospital;
    NSTimer *aniTimer;
    UIImageView *bgImg;
    
    HospitalBigView *bigHospitalView;
    HospitalPrivateView *privateHospitalView;
    HospitalSmallView *smallHospitalView;
    HospitalEndView *endHosipitalView;
    HospitalOnShow hospitalAnimate;
    
    BOOL bigHospitalClicked;
    BOOL smallHospitalClicked;
    BOOL privateHospitalClicked;
    UIImageView *bigHospitalFlag;
    UIImageView *smallHospitalFlag;
    UIImageView *privateHospitalFlag;
    
}
@property (weak,nonatomic)id<HospitalHomeViewDelegate>delegate;
@property (assign,nonatomic)HospitalOnShow hospitalOnShow;
- (void)back;
- (void)initialization;
@end

@protocol HospitalHomeViewDelegate <NSObject>

- (void)setDatawithHospital:(HospitalOnShow)hospitalType;
- (void)restartBtnAppear;
@end