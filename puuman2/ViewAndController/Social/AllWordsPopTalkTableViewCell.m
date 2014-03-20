//
//  AllWordsPopTalkTableViewCell.m
//  puuman2
//
//  Created by Ra.（祁文龙） on 14-3-20.
//  Copyright (c) 2014年 AFITC. All rights reserved.
//

#import "AllWordsPopTalkTableViewCell.h"
#import "ColorsAndFonts.h"

@implementation AllWordsPopTalkTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        
    }
    return self;
}

- (void)initialization
{
    portrait = [[UIImageView alloc] initWithFrame:CGRectMake(8, 10, 40, 40)];
    portrait.layer.cornerRadius = 48;
    portrait.layer.masksToBounds = YES;
    portrait.layer.shadowRadius =0.1;
    [self.contentView addSubview:portrait];
    name = [[UILabel alloc] initWithFrame:CGRectMake(56, 16, 0, 16)];
    [name setFont:PMFont2];
    [name setTextColor:PMColor2];
    [name setBackgroundColor:[UIColor clearColor]];
    [self.contentView addSubview:name];
    
    status = [[UILabel alloc] initWithFrame:CGRectMake(56, 16, 0, 16)];
    [status setFont:PMFont3];
    [status setTextColor:PMColor3];
    [status setBackgroundColor:[UIColor clearColor]];
    [self.contentView addSubview:status];
    icon_sex = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 16, 16)];
    [self.contentView addSubview:icon_sex];
    
}

- (void)setCellWithTalk:(NSDictionary *)talkInfo;
{
    if (detail) {
        [detail removeFromSuperview];
    }
    detail = [[TextLayoutLabel alloc] initWithFrame:CGRectMake(0, 0, 340, 0)];
    detail.numberOfLines = 0;
    detail.font = PMFont3;
    detail.textColor = PMColor2;
    detail.backgroundColor = [UIColor clearColor];
    [detail setLinesSpacing:10];
    [detail setCharacterSpacing:1];
    [self.contentView addSubview:detail];
    NSString *text= @"";
    CGFloat dh = [detail setText:text abbreviated:NO];
    detail.frame = CGRectMake(168, 16, 340, dh);

    
    

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

+ (CGFloat)heightForTalk:(NSDictionary *)talkInfo
{

    TextLayoutLabel *textLayoutLabel  = [[TextLayoutLabel alloc] initWithFrame:CGRectMake(0, 0, 340, 0)];
    textLayoutLabel.numberOfLines = 0;
    textLayoutLabel.font = PMFont3;
    textLayoutLabel.textColor = PMColor2;
    textLayoutLabel.backgroundColor = [UIColor clearColor];
    [textLayoutLabel setLinesSpacing:10];
    [textLayoutLabel setCharacterSpacing:1];
    NSString *text= @"";
    CGFloat dh = [textLayoutLabel setText:text abbreviated:NO];
    dh +=32;
    dh = dh>60?dh:60;
    return dh;
    
}
@end
