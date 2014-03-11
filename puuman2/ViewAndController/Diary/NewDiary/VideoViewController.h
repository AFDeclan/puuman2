//
//  VideoViewController.h
//  puuman2
//
//  Created by Ra.（祁文龙） on 14-3-11.
//  Copyright (c) 2014年 AFITC. All rights reserved.
//

#import "PopViewController.h"
#import "NewCameraControlView.h"
@interface VideoViewController : PopViewController<CameraControlDelegate>
{
    NewCameraControlView *controlView;
}

@end
