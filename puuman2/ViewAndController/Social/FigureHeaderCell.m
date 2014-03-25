//
//  FigureHeaderCell.m
//  puuman2
//
//  Created by Ra.（祁文龙） on 14-3-25.
//  Copyright (c) 2014年 AFITC. All rights reserved.
//

#import "FigureHeaderCell.h"
#import "ColorsAndFonts.h"
#import "UserInfo.h"


@implementation FigureHeaderCell
@synthesize recommend = _recommend;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        portrait  =[[AFImageView alloc] initWithFrame:CGRectMake(28, 16, 40, 40)];
        [portrait setBackgroundColor:[UIColor clearColor]];
        portrait.layer.cornerRadius = 20;
        portrait.layer.masksToBounds = YES;
        portrait.layer.shadowRadius =0.1;
        [portrait getImage:[[UserInfo sharedUserInfo] portraitUrl] defaultImage:@""];
        [self.contentView addSubview:portrait];
        info_compare = [[UILabel alloc] initWithFrame:CGRectMake(0, 88, 96, 16)];
        [info_compare setTextAlignment:NSTextAlignmentCenter];
        [info_compare setTextColor:PMColor2];
        [info_compare setFont:PMFont3];
        [info_compare setBackgroundColor:[UIColor clearColor]];
        [info_compare setText:@"一年八个月"];
        [self.contentView  addSubview:info_compare];
        name_sex = [[AFTextImgButton alloc] initWithFrame:CGRectMake(0, 60, 96, 16)];
        [name_sex setEnabled:NO];
        [self.contentView  addSubview:name_sex];
        [name_sex setTitle:@"宝宝" andImg:[UIImage imageNamed:@"icon_male_topic.png"] andButtonType:kButtonTypeTen];
        
        recommendView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
        [recommendView setBackgroundColor:[UIColor clearColor]];
        [portrait addSubview:recommendView];
        
        UIImageView *bg_recommend = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
        [bg_recommend setBackgroundColor:[UIColor blackColor]];
        bg_recommend.layer.cornerRadius = 20;
        bg_recommend.layer.masksToBounds = YES;
        bg_recommend.layer.shadowRadius =0.1;
        [bg_recommend setAlpha:0.3];
        [recommendView addSubview:bg_recommend];
        
        UILabel *label_recommend= [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
        [label_recommend setTextAlignment:NSTextAlignmentCenter];
        [label_recommend setTextColor:[UIColor whiteColor]];
        [label_recommend setFont:PMFont3];
        [label_recommend setBackgroundColor:[UIColor clearColor]];
        [label_recommend setText:@"推荐"];
        [recommendView  addSubview:label_recommend];

        
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setRecommend:(BOOL)recommend
{
    _recommend = recommend;
    if (recommend) {
        [recommendView setAlpha:1];
    }else{
        [recommendView setAlpha:0];
    }
}
@end
