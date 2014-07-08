//
//  ShopAllWareHeaderView.m
//  puuman2
//
//  Created by Ra.（祁文龙） on 14-3-28.
//  Copyright (c) 2014年 AFITC. All rights reserved.
//

#import "ShopAllWareHeaderView.h"
#import "ColorsAndFonts.h"
#import "ShopClassModel.h"
#import "ShopModel.h"

@implementation ShopAllWareHeaderView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setBackgroundColor:PMColor5];
        icon_ware = [[UIImageView alloc] initWithFrame:CGRectMake(16, 24, 32, 32)];
        [self addSubview:icon_ware];
   
        
               
        wareLabel = [[UILabel alloc] initWithFrame:CGRectMake(56, 24, 0, 28)];
        [wareLabel setBackgroundColor:[UIColor clearColor]];
        [wareLabel setFont:PMFont1];
        [wareLabel setTextColor:PMColor6];
        [self addSubview:wareLabel];
        
        filtrateBtn = [[ColorButton alloc] init];
        [filtrateBtn initWithTitle:@"筛选" andButtonType:kGrayLeft];
        [self addSubview:filtrateBtn];
        [filtrateBtn addTarget:self action:@selector(filtrate) forControlEvents:UIControlEventTouchUpInside];

      
    }
    return self;
}

- (void)filtrate
{

}

- (void)setStatusWithKindIndex:(NSInteger)index andUnfold:(BOOL)unfold
{
    [icon_ware setImage:[ShopClassModel iconForSectionAtIndex:index]];
    NSString *titleName;
    if (unfold) {
        if ([ShopModel sharedInstance].subClassIndex < 0) {
            
             titleName = [ShopClassModel titleForSectionAtIndex:[ShopModel sharedInstance].sectionIndex];
        }else{
             titleName = [ShopClassModel titleForSectionAtIndex:[ShopModel sharedInstance].sectionIndex andSubType:[ShopModel sharedInstance].subClassIndex];
        }
        }else{
        titleName = [ShopClassModel titleForSectionAtIndex:index];
    }

    CGSize size = [titleName sizeWithFont:wareLabel.font];
    [wareLabel setText:titleName];
    CGRect nameFrame = wareLabel.frame;
    nameFrame.size.width = size.width;
    [wareLabel setFrame:nameFrame];
    

}

- (void)setVerticalFrame
{
    SetViewLeftUp(filtrateBtn,ViewWidth(self)- ViewWidth(filtrateBtn), 16);

}

- (void)setHorizontalFrame
{
    SetViewLeftUp(filtrateBtn, ViewWidth(self)- ViewWidth(filtrateBtn), 16);

}


@end
