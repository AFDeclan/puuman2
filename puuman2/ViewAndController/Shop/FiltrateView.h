//
//  FiltrateView.h
//  puuman2
//
//  Created by Ra.（祁文龙） on 14-7-16.
//  Copyright (c) 2014年 AFITC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FiltrateView : UIView
{
    UIView *headerView;
    UIView *footerView;
    UIView *contentView;
}

- (void)show;
- (void)hidden;
@end
