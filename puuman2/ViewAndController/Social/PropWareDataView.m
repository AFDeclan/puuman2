//
//  PropWareDataView.m
//  puuman2
//
//  Created by Ra.（祁文龙） on 14-3-25.
//  Copyright (c) 2014年 AFITC. All rights reserved.
//

#import "PropWareDataView.h"
#import "ColorsAndFonts.h"
#import "UniverseConstant.h"
#import "MainTabBarController.h"

@implementation PropWareDataView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
          [MyNotiCenter addObserver:self selector:@selector(scrollViewMoved:) name:Noti_PartnerDataViewScrolled object:nil];
        propImageView = [[AFImageView alloc] initWithFrame:CGRectMake(0, 40,96, 96)];
        [propImageView setBackgroundColor:[UIColor clearColor]];
        [self addSubview:propImageView];
        
       
        
        mask_name = [[UIView alloc] initWithFrame:CGRectMake(0, 64, 96,32)];
        [mask_name setBackgroundColor:[UIColor whiteColor]];
        [mask_name setAlpha:0.5];
        [propImageView addSubview:mask_name];
        
        name_label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 96, 32)];
        [name_label setTextAlignment:NSTextAlignmentCenter];
        [name_label setTextColor:PMColor2];
        [name_label setFont:PMFont4];
        [name_label setNumberOfLines:2];
        [name_label setBackgroundColor:[UIColor clearColor]];
        [mask_name  addSubview:name_label];
        
        status_label = [[UILabel alloc] initWithFrame:CGRectMake(12, 20, 84, 12)];
        [status_label setTextColor:PMColor3];
        [status_label setFont:PMFont3];
        [status_label setBackgroundColor:[UIColor clearColor]];
        [self  addSubview:status_label];
        
        mask = [[UIView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        [mask setBackgroundColor:[UIColor blackColor]];
        [self addSubview:mask];
    }
    return self;
}

- (void)setDataWithWareName:(NSString *)wareNmae andStatus:(NSString *)staus andWarePic:(NSString *)pic
{

    [name_label setText:wareNmae];
    [status_label setText:staus];
    [propImageView setImage:[UIImage imageNamed:pic]];
    [mask setAlpha:0.3];
    
//    if ([MainTabBarController sharedMainViewController].isVertical) {
//        if (self.frame.origin.y <= 448  &&   self.frame.size.height+self.frame.origin.y >= 448) {
//            [mask setAlpha:0];
//        }else{
//            [mask setAlpha:0.3];
//        }
//    }else{
//        if (self.frame.origin.y <= 112  &&   self.frame.size.height+self.frame.origin.y >= 112) {
//            [mask setAlpha:0];
//        }else{
//            [mask setAlpha:0.3];
//        }
//    }
    
 

}

- (void)scrollViewMoved:(NSNotification *)notification
{
    
    float y = [[notification object] floatValue];
    
    if ([MainTabBarController sharedMainViewController].isVertical) {
        if (y+448>=self.frame.origin.y  &&  448 + y <= self.frame.size.height+self.frame.origin.y) {
            [mask setAlpha:0];
        }else{
            [mask setAlpha:0.3];
        }

    }else{
        if (y+112>=self.frame.origin.y  &&  112 + y <= self.frame.size.height+self.frame.origin.y) {
            [mask setAlpha:0];
        }else{
            [mask setAlpha:0.3];
        }
    }

    
}

@end
