//
//  NewAudioProgressView.h
//  puuman2
//
//  Created by Ra.（祁文龙） on 14-3-5.
//  Copyright (c) 2014年 AFITC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NewAudioProgressView : UIScrollView
{
    UIView *progress;
    UILabel *label_time;
}
@property (assign,nonatomic)NSTimeInterval maxTime;
@property (assign,nonatomic)NSTimeInterval currentTime;
@end
