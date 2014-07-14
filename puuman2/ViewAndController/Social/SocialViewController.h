//
//  SocialViewController.h
//  puuman2
//
//  Created by Ra.（祁文龙） on 14-3-1.
//  Copyright (c) 2014年 AFITC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AFColorButton.h"
#import "AFSelectedTextImgButton.h"
#import "SocialContentView.h"

@interface SocialViewController : UIViewController
{
    UIImageView *bg_topImageView;
    UIImageView *bg_rightImageView;
    AFColorButton *leftBtn;
    AFColorButton *rightBtn;
    AFSelectedTextImgButton *topicBtn;
    AFSelectedTextImgButton *partnerBtn;
    SocialContentView *contnetView;
    BOOL selectedTopic;

}



@end
