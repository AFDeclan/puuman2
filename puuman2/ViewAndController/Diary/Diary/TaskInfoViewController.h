//
//  TaskInfoViewController.h
//  puuman2
//
//  Created by Ra.（祁文龙） on 14-3-8.
//  Copyright (c) 2014年 AFITC. All rights reserved.
//

#import "CustomPopViewController.h"
#import "AFImageView.h"

@interface TaskInfoViewController : CustomPopViewController<AFImageViewDelegate>
{
    
    UIScrollView *_scrollView;
    UILabel *_infoLabel;
    AFImageView *_infoImgView;
}
@property (assign, nonatomic) NSDictionary *taskInfo;
@end
