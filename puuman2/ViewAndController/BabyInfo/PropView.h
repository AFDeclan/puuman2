//
//  PropView.h
//  puman
//
//  Created by 祁文龙 on 13-11-19.
//  Copyright (c) 2013年 创始人团队. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PropWare.h"

@interface PropView : UIView
{
    NSArray *props;
    PropWare *propWare1;
    PropWare *propWare2;
    PropWare *propWare3;
    PropWare *propWare4;
    PropWare *propWare5;
}
- (void)reloadData;
@end
