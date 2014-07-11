//
//  WareInfoPopViewController.h
//  puuman2
//
//  Created by Ra.（祁文龙） on 14-7-10.
//  Copyright (c) 2014年 AFITC. All rights reserved.
//

#import "CustomPopViewController.h"
#import "AFSelecedTextImgButton.h"
#import "ColorButton.h"
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
    
    AFSelecedTextImgButton *describeBtn;
    AFSelecedTextImgButton *evaluateBtn;
    ColorButton *shareBtn;
    ColorButton *addToCart;
    SelectedButton *addCountBtn;
    SelectedButton *reduceCountBtn;
    UILabel *changeCountLabel;
    WareInfoView *infoView;
    WareEvaluationView *evaluationView;
}
@end
