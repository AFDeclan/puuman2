//
//  TopicCell.h
//  puuman2
//
//  Created by Ra.（祁文龙） on 14-3-24.
//  Copyright (c) 2014年 AFITC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AFImageView.h"
#import "BasicInfoView.h"

@interface TopicCell : UITableViewCell
{
    BasicInfoView *infoView;
     UILabel *info_time;
    UIView *headerView;
    UIView *contentView;
    UIView *footerView;
   
    
}

@end
