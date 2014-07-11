//
//  WareInfoView.h
//  puuman2
//
//  Created by Ra.（祁文龙） on 14-7-11.
//  Copyright (c) 2014年 AFITC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIColumnView.h"

@interface WareInfoView : UIView<UIColumnViewDataSource,UIColumnViewDelegate>
{
    UIColumnView *infoTableView;
}
@end
