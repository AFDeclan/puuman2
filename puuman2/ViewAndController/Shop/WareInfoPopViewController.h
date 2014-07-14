//
//  WareInfoPopViewController.h
//  puuman2
//
//  Created by Ra.（祁文龙） on 14-7-10.
//  Copyright (c) 2014年 AFITC. All rights reserved.
//

#import "CustomPopViewController.h"
#import "AFSelectedTextImgButton.h"
#import "AFColorButton.h"
#import "AFImageView.h"
#import "SelectedButton.h"
#import "WareInfoView.h"
#import "WareEvaluationView.h"


@interface WareInfoPopViewController : CustomPopViewController<SelectedButtonDelegate>
{
    
    UIView *basicInfoView;
    AFImageView *wareImgView;
    UILabel *wareName;
    UILabel *priceLabel;
    
    AFSelectedTextImgButton *describeBtn;
    AFSelectedTextImgButton *evaluateBtn;
    AFColorButton *shareBtn;
    AFColorButton *addToCart;
    SelectedButton *addCountBtn;
    SelectedButton *reduceCountBtn;
    UILabel *changeCountLabel;
    WareInfoView *infoView;
    WareEvaluationView *evaluationView;
}
@end
