//
//  ImportRefreshCell.m
//  puuman2
//
//  Created by Ra.（祁文龙） on 14-7-25.
//  Copyright (c) 2014年 AFITC. All rights reserved.
//

#import "ImportRefreshCell.h"
#import "UniverseConstant.h"

@implementation ImportRefreshCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        [MyNotiCenter addObserver:self selector:@selector(showAnimate:) name:Noti_ImportRefresh object:nil];
        [self initialization];
    }
    return self;
}

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)initialization
{
    self.contentView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"paper_diary.png"]];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    indicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    indicatorView.center = CGPointMake(336, 16);
    [self.contentView addSubview:indicatorView];
    indicatorView.color = PMColor6;
    [indicatorView setHidesWhenStopped:YES];
    
}

- (void)showAnimate:(NSNotification *)notification
{
    if ([[notification object] boolValue]) {
        [indicatorView startAnimating];
    }else{
        [indicatorView stopAnimating];

    }
}

@end
