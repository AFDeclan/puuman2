//
//  VotingCell.m
//  puuman2
//
//  Created by Ra.（祁文龙） on 14-3-24.
//  Copyright (c) 2014年 AFITC. All rights reserved.
//

#import "VotingCell.h"
#import "UserInfo.h"

@implementation VotingCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        infoView = [[BasicInfoView alloc] init];
        [self.contentView addSubview:infoView];
        [infoView setInfoWithName:@"宝宝" andPortrailPath:[[UserInfo sharedUserInfo] portraitUrl] andRelate:@"哥哥" andIsBoy:YES];
        
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
