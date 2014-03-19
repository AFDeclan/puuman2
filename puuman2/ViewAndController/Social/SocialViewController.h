//
//  SocialViewController.h
//  puuman2
//
//  Created by Ra.（祁文龙） on 14-3-1.
//  Copyright (c) 2014年 AFITC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ColorButton.h"
#import "AFImgButton.h"
#import "TopicView.h"
#import "PartnerView.h"

@interface SocialViewController : UIViewController
{
    UIImageView *bg_topImageView;
    UIImageView *bg_rightImageView;
    ColorButton *leftBtn;
    ColorButton *rightBtn;
    AFImgButton *topicBtn;
    AFImgButton *partnerBtn;
    TopicView *topicView;
    PartnerView *partnerView;
    BOOL selectedTopic;
}
@end
