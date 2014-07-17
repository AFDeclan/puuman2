//
//  WareInfoViewController.h
//  puuman2
//
//  Created by Ra.（祁文龙） on 14-7-17.
//  Copyright (c) 2014年 AFITC. All rights reserved.
//

#import "CustomShopPopViewController.h"
#import "AFSelectedImgButton.h"
#import "AFColorButton.h"
#import "AFImageView.h"
#import "SelectedButton.h"
#import "WareInfoView.h"
#import "WareEvaluationView.h"

@interface WareInfoViewController : CustomShopPopViewController<SelectedButtonDelegate>
{
    UIView *basicInfoView;
    AFImageView *wareImgView;
    UILabel *wareName;
    UILabel *priceLabel;
    
    AFSelectedImgButton *describeBtn;
    AFSelectedImgButton *evaluateBtn;
    AFColorButton *shareBtn;
    AFColorButton *addToCart;
    SelectedButton *addCountBtn;
    SelectedButton *reduceCountBtn;
    UILabel *changeCountLabel;
    WareInfoView *infoView;
    WareEvaluationView *evaluationView;
}
@end
