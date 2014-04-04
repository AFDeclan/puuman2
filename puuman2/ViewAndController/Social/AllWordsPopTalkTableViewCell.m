//
//  AllWordsPopTalkTableViewCell.m
//  puuman2
//
//  Created by Ra.（祁文龙） on 14-3-20.
//  Copyright (c) 2014年 AFITC. All rights reserved.
//

#import "AllWordsPopTalkTableViewCell.h"
#import "ColorsAndFonts.h"
#import "MemberCache.h"
#import "Member.h"
#import "UniverseConstant.h"

@implementation AllWordsPopTalkTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        [self initContent];
    }
    return self;
}

- (void)initContent
{
    
    infoView = [[BasicInfoView alloc] init];
    [self.contentView addSubview:infoView];
    
}

-(void)buildWithUid:(NSInteger)uid andIndex:(NSInteger)index  andCommmet:(NSString *)comment
{
    if (mainTextView) {
        [mainTextView removeFromSuperview];
    }
    mainTextView = [[AdaptiveLabel alloc] initWithFrame:CGRectMake(170, 16, 0, 0)];
    [mainTextView setBackgroundColor:[UIColor clearColor]];
    [mainTextView setFont:PMFont2];
    [mainTextView setTextColor:PMColor1];
    [self.contentView addSubview:mainTextView];
    [mainTextView setTitle:comment withMaxWidth:340];
    [mainTextView setText:comment];
    Member *member =[[MemberCache sharedInstance] getMemberWithUID:uid];
    if (member) {
        [infoView setInfoWithName:member.BabyNick andPortrailPath:member.BabyPortraitUrl andRelate:@"哥哥" andIsBoy:member.BabyIsBoy];
    }
    
    
}

- (void)memberDownloaded:(Member *)member
{
    [infoView setInfoWithName:member.BabyNick andPortrailPath:member.BabyPortraitUrl andRelate:@"哥哥" andIsBoy:member.BabyIsBoy];

}
//Member数据下载失败
- (void)memberDownloadFailed
{

}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


+ (CGFloat)heightForComment:(NSString *)comment
{

    AdaptiveLabel *example = [[AdaptiveLabel alloc] initWithFrame:CGRectMake(56, 0, 0, 0)];
    [example setFont:PMFont2];
    [example setTitle:comment withMaxWidth:536];
        
  
    return ViewHeight(example)+32 >60?ViewHeight(example)+32:60;
    
}
@end
