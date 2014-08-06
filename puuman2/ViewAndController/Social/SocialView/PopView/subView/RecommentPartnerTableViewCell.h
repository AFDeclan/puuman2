//
//  RecommentPartnerTableViewCell.h
//  puuman2
//
//  Created by Ra.（祁文龙） on 14-3-20.
//  Copyright (c) 2014年 AFITC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Member.h"

typedef enum
{
    kPartnerBirthday,
    kPartnerHeight,
    kPartnerWeight
    
}PartnerDataInfoType;

@interface RecommentPartnerTableViewCell : UITableViewCell
{

    UILabel *label_first;
    UILabel *label_second;
    UILabel *label_compare;
    UIImageView *line;
    UIImageView *icon;
}

- (void)buildWithData:(Member *)data andUserData:(Member *)userData andDataType:(PartnerDataInfoType )type;

@end
