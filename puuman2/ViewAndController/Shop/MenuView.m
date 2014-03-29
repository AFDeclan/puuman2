//
//  MenuView.m
//  puman
//
//  Created by 祁文龙 on 13-11-16.
//  Copyright (c) 2013年 创始人团队. All rights reserved.
//

#import "MenuView.h"
#import "ShopViewController.h"
#import "ShopModel.h"

#define MenuBtnWidth 108
#define MenuBtnHeight 64

@implementation MenuView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        childMenu = [[UIView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        [childMenu setBackgroundColor:[UIColor clearColor]];
        [self addSubview:childMenu];
        parentMenu = [[UIView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
         [parentMenu setBackgroundColor:[UIColor clearColor]];
        [self addSubview:parentMenu];
        [self setBackgroundColor:PMColor6];
        [self initParentMenu];
        UIImageView *line = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 240, 1)];
        [line setImage:[UIImage imageNamed:@"line_shop.png"]];
        [self addSubview:line];

    }
    return self;
}

- (void)initParentMenu
{
    for (int i = 0; i < kParentBtnNum; i++) {
        CGRect frame = CGRectMake(0, 0, MenuBtnWidth, MenuBtnHeight);
        frame.origin.x = (i%2)*MenuBtnWidth;
        frame.origin.y = ((int)(i/2))*MenuBtnHeight;
        _typeBtn[i] = [[TypeButton alloc] initWithFrame:frame];
        [_typeBtn[i] initWithIconImg:[ShopModel icon2ForSectionAtIndex:i]  andTitle:[ShopModel titleForSectionAtIndex:i] andTitleColor:PMColor7 andTitleFont:PMFont3];
        [_typeBtn[i] setBackgroundImage:[UIImage imageNamed:@"btn_h_shop.png"] forState:UIControlStateNormal];
        [_typeBtn[i] setAdjustsImageWhenDisabled:NO];
        [_typeBtn[i] setTypeIndex:i];
        [_typeBtn[i] setBackgroundColor:PMColor6];
        [_typeBtn[i] addTarget:self action:@selector(typeBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
        [parentMenu addSubview:_typeBtn[i]];
        if ( i == 10 || i == 11 ) {
            [_typeBtn[i] setState:SingleShopBtn];
        }else{
            [_typeBtn[i] setState:SubShopBtn];
        }
    }
}
- (void)typeBtnClicked:(TypeButton *)sender
{
    [MobClick event:umeng_event_click label:[NSString stringWithFormat:@"Type%d_MenuView",sender.typeIndex]];
    if (!sender.isSelected) {
        if (selectedBtn) {
            [selectedBtn setIsSelected:NO];
            [selectedBtn unSelected];
        }
        selectedBtn = sender;
        [sender setIsSelected:YES];
        [sender selected];
        [ShopModel sharedInstance].sectionIndex = sender.typeIndex;
        PostNotification(Noti_ReloadShopMall, nil);
        if (sender.state == SingleShopBtn) {
            PostNotification(Noti_HiddenMenu, nil);
        }
        if (sender.state == SubShopBtn) {
            [parentMenu setAlpha:1];
            [self initchildMenu];
            CABasicAnimation *a2 = [CABasicAnimation animationWithKeyPath:@"transform.rotation.y"];
            a2.fromValue = [NSNumber numberWithFloat:0.0];
            a2.toValue = [NSNumber numberWithFloat:M_PI/2];
            a2.autoreverses = YES;
            a2.repeatCount = 0;
            a2.duration =0.3;
            [sender.layer addAnimation:a2 forKey:@"y"];
            if ([ShopModel subTypeCntForSectionAtIndex:sender.typeIndex] >= sender.typeIndex) {
                
                if (sender.typeIndex == 0) {
                    [backBtn.layer addAnimation:a2 forKey:@"y"];
                }else{
                    for (int i = 0; i <12; i ++) {
                        if (i == sender.typeIndex) {
                            [_subTypeBtn[sender.typeIndex][i-1].layer addAnimation:a2 forKey:@"y"];
                            break;
                        }
                    }
                }
                
            }
            [UIView animateWithDuration:0.6 animations:^{
                
                [parentMenu setAlpha:0];
                [childMenu setAlpha:1];
            }completion:^(BOOL finished) {
                
            }];
        }
    }
    PostNotification(Noti_ToAllSHop, nil);
   PostNotification(Noti_ReloadRankView, nil);
}

- (void)initchildMenu
{
    for (UIView *view in [childMenu subviews]) {
        [view removeFromSuperview];
    }
    int typeIndex = selectedBtn.typeIndex;
   
    for (int i=0; i<[ShopModel subTypeCntForSectionAtIndex:typeIndex]; i++)
    {
        if (_subTypeBtn[typeIndex][i]) {
            _subTypeBtn[typeIndex][i] = nil;
        }
      
            CGRect frame = CGRectMake(0, 0, MenuBtnWidth, MenuBtnHeight);
            frame.origin.x = ((i+1)%2)*MenuBtnWidth;
            frame.origin.y = ((int)((i+1)/2))*MenuBtnHeight;
            _subTypeBtn[typeIndex][i] = [[SubTypeButton alloc] initWithFrame:frame andTitle:[ShopModel titleForSectionAtIndex:typeIndex andSubType:i]];
            [_subTypeBtn[typeIndex][i] setBackgroundImage:[UIImage imageNamed:@"btn_h_shop.png"] forState:UIControlStateNormal];
           
            [_subTypeBtn[typeIndex][i] addTarget:self action:@selector(subBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
            [_subTypeBtn[typeIndex][i] setTypeIndex:typeIndex];
            [_subTypeBtn[typeIndex][i] setSubIndex:i];
            [_subTypeBtn[typeIndex][i] setBackgroundColor:PMColor6];
        
        [childMenu addSubview:_subTypeBtn[typeIndex][i]];
    }
    if (!backBtn) {
        backBtn = [[TypeButton alloc] initWithFrame:CGRectMake(0, 0, MenuBtnWidth, MenuBtnHeight)];
        [backBtn initWithIconImg:[UIImage imageNamed:@"icon_back_shop.png"] andTitle:@"返回" andTitleColor:[UIColor whiteColor] andTitleFont:PMFont3];
        [backBtn setBackgroundColor:PMColor6];
         [backBtn setBackgroundImage:[UIImage imageNamed:@"btn_h_shop.png"] forState:UIControlStateNormal];
        [backBtn addTarget:self action:@selector(back:) forControlEvents:UIControlEventTouchUpInside];
    }
    [backBtn setTypeIndex:typeIndex];
    [childMenu addSubview:backBtn];
}

- (void)subBtnClicked:(SubTypeButton *)sender
{
    
    [MobClick event:umeng_event_click label:[NSString stringWithFormat:@"Type%d SubType%d_MenuView",sender.typeIndex,sender.subIndex]];
    if (!sender.isSelected) {
        if(selectedSubBtn)
        {
            [selectedSubBtn setIsSelected:NO];
            [selectedSubBtn unSelected];
            
        }
        selectedSubBtn = sender;
        [sender setIsSelected:YES];
        [sender selected];
        [ShopModel sharedInstance].subClassIndex = sender.subIndex;
        PostNotification(Noti_HiddenMenu, nil);
        PostNotification(Noti_ReloadShopMall, nil);
    }else{
        PostNotification(Noti_ToAllSHop, nil);
    }
    
}
- (void)back:(TypeButton *)sender
{
     [MobClick event:umeng_event_click label:@"Back_MenuView"];
    //[self addSubview:parentMenu];
    //[self addSubview:childMenu];
    [childMenu setAlpha:1];
    [selectedBtn setIsSelected:NO];
    [selectedBtn unSelected];
    [selectedSubBtn unSelected];
    [ShopModel sharedInstance].sectionIndex = -1;
    [ShopModel sharedInstance].subClassIndex = -1;
    CABasicAnimation *a2 = [CABasicAnimation animationWithKeyPath:@"transform.rotation.y"];
    a2.fromValue = [NSNumber numberWithFloat:0.0];
    a2.toValue = [NSNumber numberWithFloat:M_PI/2];
    a2.autoreverses = YES;
    a2.repeatCount = 0;
    a2.duration =0.3;
    [sender.layer addAnimation:a2 forKey:@"y"];
    [_typeBtn[0].layer addAnimation:a2 forKey:@"y"];
    [UIView animateWithDuration:0.6 animations:^{
        [childMenu setAlpha:0];
        [parentMenu setAlpha:1];
    }completion:^(BOOL finished) {
        
    }];
   
    PostNotification(Noti_ReloadShopMall, nil);
    PostNotification(Noti_ReloadRankView, nil);
}

- (void)showShopWithTypeIndex:(NSInteger)typeIndex
{

}

- (void)showShopWithTypeIndex:(NSInteger)typeIndex andSubIndex:(NSInteger)subIndex
{

    if (typeIndex == -1) {
        if (selectedBtn.state == SubShopBtn) {
            [self back:backBtn];
        }else{
            [selectedBtn setIsSelected:NO];
            [selectedBtn unSelected];
        }
    }else{
        if (selectedBtn) {
            [selectedBtn unSelected];
        }
        
        selectedBtn = _typeBtn[typeIndex];
        [selectedBtn selected];
        [self typeBtnClicked:_typeBtn[typeIndex]];
    }
    
   

    
}


- (void)selectedParentIndex:(NSInteger)parentIndex andChildIndex:(NSInteger)childIndex
{
    
    if (selectedBtn) {
        [selectedBtn setIsSelected:NO];
        [selectedBtn unSelected];
        [selectedSubBtn unSelected];
        [selectedSubBtn setIsSelected:NO];
    }

    [childMenu setAlpha:0];
    [parentMenu setAlpha:1];
    [ShopModel sharedInstance].sectionIndex = parentIndex;
    [ShopModel sharedInstance].subClassIndex = childIndex;

   
     PostNotification(Noti_ToAllSHop, nil);
     PostNotification(Noti_ReloadShopMall, nil);
     PostNotification(Noti_ReloadRankView, nil);

    
}



@end
