//
//  BasicInfoView.m
//  puuman2
//
//  Created by Ra.（祁文龙） on 14-3-24.
//  Copyright (c) 2014年 AFITC. All rights reserved.
//

#import "BasicInfoView.h"
#import "ColorsAndFonts.h"
#import "UniverseConstant.h"

@implementation BasicInfoView

- (id)init
{
    return [self initWithFrame:CGRectMake(0, 0, 304, 56)];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        portrait =[[AFImageView alloc] initWithFrame:CGRectMake(8, 8, 40, 40)];
        [portrait setBackgroundColor:[UIColor blackColor]];
        portrait.layer.cornerRadius = 20;
        portrait.layer.masksToBounds = YES;
        portrait.layer.shadowRadius =0.1;
        [self addSubview:portrait];
        info_name = [[UILabel alloc] initWithFrame:CGRectMake(56, 16, 0, 0)];
        [info_name setTextAlignment:NSTextAlignmentCenter];
        [info_name setTextColor:PMColor2];
        [info_name setFont:PMFont2];
        [info_name setBackgroundColor:[UIColor clearColor]];
        [self addSubview:info_name];
        
        info_relate = [[UILabel alloc] initWithFrame:CGRectMake(56, 36, 96, 12)];
        [info_relate setTextColor:PMColor3];
        [info_relate setFont:PMFont3];
        [info_relate setBackgroundColor:[UIColor clearColor]];
        [self addSubview:info_relate];

        icon_sex = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 16, 16)];
        [self addSubview:icon_sex];

    }
    return self;
}
- (void)setInfoWithName:(NSString *)name andPortrailPath:(NSString*)path andRelate:(NSString *)relate andIsBoy:(BOOL)isBoy
{
    [portrait getImage:path defaultImage:@"pic_default_topic.png"];
    [info_relate setText:relate];
    [info_name setText:name];
    [info_name adjustSize];
    if (isBoy) {
        [icon_sex setImage:[UIImage imageNamed:@"icon_male_topic.png"]];
    }else{
        [icon_sex setImage:[UIImage imageNamed:@"icon_female_topic.png"]];
    }
    
    SetViewLeftUp(icon_sex, ViewX(info_name)+ViewWidth(info_name)+4, ViewY(info_name));
    
}


@end
