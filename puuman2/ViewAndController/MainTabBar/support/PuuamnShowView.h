//
//  PuuamnShowView.h
//  PuumanForPhone
//
//  Created by Ra.（祁文龙） on 14-6-26.
//  Copyright (c) 2014年 Declan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PuuamnShowView : UIView
{

    UILabel *coin_num;
    UILabel *coin_label;
    float num;
}
- (void)updateData;
@end
