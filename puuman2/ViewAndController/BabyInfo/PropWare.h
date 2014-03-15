//
//  PropWare.h
//  puman
//
//  Created by 祁文龙 on 13-11-19.
//  Copyright (c) 2013年 创始人团队. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Ware.h"
#import "AFImageView.h"



@interface PropWare : UIButton
{
    UILabel *w_Name;
    AFImageView *w_Pic;
    UIImageView *bg_Pic;
    Ware *_ware;
    NSInteger parentMenu;
    NSInteger childMenu;
}
- (void)setParentMenu:(NSInteger)index andChildMenu:(NSInteger)num;
- (void)initWithWare:(Ware *)ware ;

@end
