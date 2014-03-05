//
//  NewCameraControlView.h
//  puuman2
//
//  Created by Ra.（祁文龙） on 14-3-5.
//  Copyright (c) 2014年 AFITC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NewCameraControlView : UIView
{
    UIImageView *controlBg;
    UIButton *closeBtn;
    UIButton *finishBtn;
    UIButton *frontRareChangeBtn;
    UIButton *modelChangeBtn;
    UIButton *audioBtn;
    UIButton *playCameraBtn;
    
    //sampleImg
    UIImageView *sampleImageView;
    UILabel *photoNumLabel;
    UIImageView *numLabelBgView;
}
@end
