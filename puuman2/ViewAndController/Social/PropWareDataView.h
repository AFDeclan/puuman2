//
//  PropWareDataView.h
//  puuman2
//
//  Created by Ra.（祁文龙） on 14-3-25.
//  Copyright (c) 2014年 AFITC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AFImageView.h"

@interface PropWareDataView : UIView
{
    AFImageView *propImageView;
    UIView *mask;
    UIView *mask_name;
    UILabel *name_label;
    UILabel *status_label;
}

- (void)setDataWithWareName:(NSString *)wareNmae andStatus:(NSString *)staus andWarePic:(NSString *)pic;
@end
