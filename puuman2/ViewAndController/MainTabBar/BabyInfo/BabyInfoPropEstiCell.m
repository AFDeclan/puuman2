//
//  BabyInfoPropEstiCell.m
//  puuman2
//
//  Created by AF_Bigwaves on 14-7-4.
//  Copyright (c) 2014年 AFITC. All rights reserved.
//

#import "BabyInfoPropEstiCell.h"
#import "ColorsAndFonts.h"
#import "UniverseConstant.h"
@implementation BabyInfoPropEstiCell

@synthesize estiLabel = _estiLabel;


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initialization];
    }
    return self;
}


- (void)initialization
{
    _estiLabel = [[AdaptiveLabel alloc] initWithFrame:CGRectMake(15, 10, 0, 0)];
    //[_estiLabel setText:@"使用感觉不错!"];
    [_estiLabel setTextColor:PMColor2];
    [_estiLabel setFont:PMFont1];
    [_estiLabel setTitle:@"使用感觉还不错" withMaxWidth:180];

//    NSMutableAttributedString *attributedString1= [[NSMutableAttributedString alloc] initWithString:_estiLabel.text];
//    NSMutableParagraphStyle *paragraphStyle1 = [[NSMutableParagraphStyle alloc] init];
//    [paragraphStyle1 setLineSpacing:20];
//    [attributedString1 addAttribute:NSParagraphStyleAttributeName value:paragraphStyle1 range:NSMakeRange(0, [_estiLabel.text length])];
//    [_estiLabel setAttributedText:attributedString1];
//    [_estiLabel sizeToFit];
   [self.contentView addSubview:_estiLabel];
    
//    lineView = [[UIView alloc] initWithFrame:CGRectMake(15, , 180,1)];
//    [lineView setBackgroundColor:PMColor5];
//    [self.contentView addSubview:lineView];



}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
