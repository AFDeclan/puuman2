//
//  BabyInfoPregnancyViewCell.m
//  puuman2
//
//  Created by AF_Bigwaves on 14-7-2.
//  Copyright (c) 2014年 AFITC. All rights reserved.
//

#import "BabyInfoPregnancyViewCell.h"
#import "ColorsAndFonts.h"
#import "LoginViewController.h"
#import "MainTabBarController.h"
#import "CAKeyframeAnimation+DragAnimation.h"
#import "NSDate+Compute.h"
#import "PregnancyTableViewCell.h"


@implementation BabyInfoPregnancyViewCell
@synthesize delegate = _delegate;
@synthesize columnImgBMode = _columnImgBMode;
@synthesize PreDelegate = _PreDelegate;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        [self initialization];
        [self initColumnView];
        [self initClearInfoView];
        if ([[MainTabBarController sharedMainViewController] isVertical]) {
          
            [self setVerticalFrame];
        } else {
        
            [self setHorizontalFrame];
        }
        
    }
    return self;
}

- (void)initialization
{
    
    contentView = [[UIView alloc] initWithFrame:CGRectMake(0, 96, 1024, 672)];
    [contentView setBackgroundColor:RGBColor(239, 215, 207)];
    [self.contentView addSubview:contentView];
    
    clearInfoView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 1024, 672)];
    [clearInfoView setBackgroundColor:[UIColor clearColor]];
    [contentView addSubview:clearInfoView];
    
     bottomBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [bottomBtn setFrame:CGRectMake(0, 720, 1024, 48)];
    [bottomBtn setBackgroundColor:[UIColor whiteColor]];
    [bottomBtn setAlpha:0.5];
    [bottomBtn setImage:[UIImage imageNamed:@"back_up_babyInfo.png"] forState:UIControlStateNormal];
    [bottomBtn setImageEdgeInsets:UIEdgeInsetsMake(8, 480, 8, 480)];
    [bottomBtn addTarget:self action:@selector(disAppearInfoView) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:bottomBtn];
    
}

- (void)initClearInfoView
{
    
//    UIImageView *bgImageView = [[UIImageView alloc] initWithFrame:CGRectMake(265,60, 480, 540)];
//    [bgImageView setImage:[UIImage imageNamed:@"bg_pregnancy_image_babyInfo.png"]];
//    [clearInfoView addSubview:bgImageView];
    
    changeModelBtn = [[BabyInfoChooseButton alloc] initWithFrame:CGRectMake(24, 118, 160, 24)];
    [changeModelBtn setType:kBabyInfoBModle];
    [changeModelBtn addTarget:self action:@selector(changeModelBtn) forControlEvents:UIControlEventTouchUpInside];
    [clearInfoView addSubview:changeModelBtn];
    
    propBtn = [[BabyInfoChooseButton alloc] initWithFrame:CGRectMake(780, 84, 220, 85)];
    [propBtn setType:kBabyInfoModle];
    [propBtn addTarget:self action:@selector(propBtn) forControlEvents:UIControlEventTouchUpInside];
    [clearInfoView addSubview:propBtn];
    
    picView = [[UIView alloc] initWithFrame:CGRectMake(180, 60,636, 540)];
    [picView setBackgroundColor:[UIColor clearColor]];
    [clearInfoView addSubview:picView];
    
    UIImageView *grayLineRight = [[UIImageView alloc] initWithFrame:CGRectMake(24, 160, 240, 86)];
    [grayLineRight  setImage:[UIImage imageNamed:@"grayline_right_babyInfo.png"]];
    [clearInfoView addSubview:grayLineRight];
    
    UIImageView *grayLineLeft = [[UIImageView alloc] initWithFrame:CGRectMake(780, 158, 240, 86)];
    [grayLineLeft setImage:[UIImage imageNamed:@"grayline_left_babyInfo.png"]];
    [clearInfoView addSubview:grayLineLeft];
    
    UIImageView *nextPropView = [[UIImageView alloc] initWithFrame:CGRectMake(1000,110, 10, 18)];
    [nextPropView setImage:[UIImage imageNamed:@"gray_back_right_babyInfo"]];
    [clearInfoView addSubview:nextPropView];
    
    preBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [preBtn setImage:[UIImage imageNamed:@"pre_pic_btn.png"] forState:UIControlStateNormal];
    [preBtn addTarget:self action:@selector(preBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [picView addSubview:preBtn];
    
    nextBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [nextBtn setImage:[UIImage imageNamed:@"next_pic_btn.png"] forState:UIControlStateNormal];
    [nextBtn addTarget:self action:@selector(nextBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [picView addSubview:nextBtn];
    
    
    UIView *bg_question = [[UIView alloc] initWithFrame:CGRectMake(445, 36, 60, 60)];
    [bg_question setBackgroundColor:RGBColor(153, 193, 222)];
     bg_question.layer.cornerRadius = 30.0f;
     bg_question.layer.masksToBounds = YES;
    [bg_question setAlpha:0.5];
    [picView addSubview:bg_question];

    questionBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [questionBtn setFrame:CGRectMake(0, 0, 60, 60)];
    [questionBtn setBackgroundColor:[UIColor clearColor]];
    [questionBtn setImage:[UIImage imageNamed:@"btn_preinfo_baby.png"] forState:UIControlStateNormal];
    [questionBtn addTarget:self action:@selector(showInfo) forControlEvents:UIControlEventTouchUpInside];
    [bg_question addSubview:questionBtn];
  
   
    
     weekView = [[UIView alloc] initWithFrame:CGRectMake(120, 456, 62, 36)];
    [weekView setBackgroundColor:[UIColor redColor]];
    [weekView setAlpha:0.1];
    [weekView.layer setMasksToBounds:YES];
    [weekView.layer setCornerRadius:18.0];
    [picView addSubview:weekView];
    
    weekLabel = [[UILabel alloc] initWithFrame:CGRectMake(120, 456, 62, 36)];
    [weekLabel setFont:PMFont(24)];
    [weekLabel setText:@""];
    [weekLabel setTextAlignment:NSTextAlignmentCenter];
    [weekLabel setTextColor:[UIColor whiteColor]];
    [picView addSubview:weekLabel];
    
}

- (void)initColumnView
{
    _columnImgBMode = NO;
    [preBtn setAlpha:0];
    [nextBtn setAlpha:1];
    _columnView = [[UIColumnView alloc] initWithFrame:CGRectMake(85, 60, 480, 540)];
    [_columnView setBackgroundColor:[UIColor clearColor]];
    [_columnView setViewDataSource:self];
    [_columnView setColumnViewDelegate:self];
    [_columnView setPagingEnabled:YES];
    [picView addSubview:_columnView];
    [self reloadColumnView];

}

- (void)setVerticalFrame
{
    [contentView setFrame:CGRectMake(0, 96, 768, 928)];
    [clearInfoView setFrame:CGRectMake(0, 0, 768, 928)];
    [bottomBtn setFrame:CGRectMake(0, 976, 768, 48)];
    [changeModelBtn setFrame:CGRectMake(24, 118, 160, 24)];
    [propBtn setFrame:CGRectMake(780, 84, 220, 85)];
    [picView setFrame:CGRectMake(66, 170, 636, 540)];
//    [preBtn setFrame:CGRectMake(180, 310, 23, 42)];
//    [nextBtn setFrame:CGRectMake(790, 310, 23, 42)];
//    [weekView setFrame:CGRectMake(300, 516, 62, 36)];
//    [weekLabel setFrame:CGRectMake(300, 516, 62, 36)];
 //   [_columnView setFrame:CGRectMake(85, 60, 480, 540)];


}

- (void)setHorizontalFrame
{
    [contentView setFrame:CGRectMake(0, 96, 1024, 672)];
    [clearInfoView setFrame:CGRectMake(0, 0, 1024, 672)];
    [bottomBtn setFrame:CGRectMake(0, 720, 1024, 48)];
    [changeModelBtn setFrame:CGRectMake(24, 118, 160, 24)];
    [propBtn setFrame:CGRectMake(780, 84, 220, 85)];
    [picView setFrame:CGRectMake(180, 60, 636, 540)];
//    [preBtn setFrame:CGRectMake(180, 310, 23, 42)];
//    [nextBtn setFrame:CGRectMake(790, 310, 23, 42)];
//    [weekView setFrame:CGRectMake(300, 516, 62, 36)];
//    [weekLabel setFrame:CGRectMake(300, 516, 62, 36)];
 //   [_columnView setFrame:CGRectMake(85, 60, 480, 540)];

}

- (void) reloadColumnView
{
    [_columnView reloadData];
//    NSArray *age = [[NSDate date] ageFromDate:[[[UserInfo sharedUserInfo]babyInfo] Birthday]];
//    if ([age count] == 2) {
//    
//        NSInteger weekAge = [[age objectAtIndex:0] integerValue];
//        if (weekAge >  BABY_COLUMN_CNT) weekAge =  BABY_COLUMN_CNT;
//        [self setWeekWithIndex:weekAge];
//    
//    } else {
//    
//        [self setWeekWithIndex:1];
//    }
//
}

- (NSUInteger)numberOfColumnsInColumnView:(UIColumnView *)columnView
{

    return  BABY_COLUMN_CNT;


}
- (CGFloat) columnView:(UIColumnView *)columnView widthForColumnAtIndex:(NSUInteger)index
{

    return kPicWidth;

}

- (UITableViewCell *) columnView:(UIColumnView *)columnView viewForColumnAtIndex:(NSUInteger)index
{
   NSString *identify = @"babyPreView";
    
   PregnancyTableViewCell  *cell = (PregnancyTableViewCell *)[columnView dequeueReusableCellWithIdentifier:identify];
    if (!cell) {
        cell = [[PregnancyTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identify];
    }
    [cell setBackgroundColor:[UIColor clearColor]];
    [cell setColumnImgBMode:_columnImgBMode];
    [cell setIndexNum:index];
    return cell;
}

- (void)scrollViewDidScroll:(UIColumnView *)scrollView
{
    scrolling = YES;

}
- (void)scrollViewDidEndDecelerating:(UIColumnView *)scrollView
{

    scrolling = NO;
    [self setWeekWithIndex:[self indexForColumnView]];
    
}
- (void)scrollViewDidEndDragging:(UIColumnView *)scrollView willDecelerate:(BOOL)decelerate
{
    scrolling = NO;
    [self setWeekWithIndex:[self indexForColumnView]];

}

- (void)columnView:(UIColumnView *)columnView didSelectColumnAtIndex:(NSUInteger)index
{


}

- (NSInteger)indexForColumnView
{

    CGFloat offset = _columnView.contentOffset.x;
    int index = offset/(kPicWidth/2);

    return (int)(index / 2)+1;
}

- (void)setWeekWithIndex:(NSInteger)index
{

    columnIndex = index;
    weekLabel.text = [NSString stringWithFormat:@"%d周",index];

}

- (void)setColumnImgBMode:(BOOL)columnImgBMode
{

    _columnImgBMode = columnImgBMode;
    [_columnView setContentOffset:CGPointMake((columnIndex - 5)*kPicWidth, 0)];
    [self reloadColumnView];
    [_columnView setContentOffset:CGPointMake((columnIndex - 1)*kPicWidth, 0)];

}

- (void)disAppearInfoView
{
    
    [_PreDelegate disAppearBabyView];
    
}

- (void)changeModelBtn
{
    _columnImgBMode = !_columnImgBMode;
    if (_columnImgBMode) {
        
     changeModelBtn.stateLabel.text = @"切换到图解";
       
    } else {
     changeModelBtn.stateLabel.text = @"切换到B超";
      
    }
    [_columnView reloadData];
}

- (void)propBtn
{
    
    [_delegate gotoTheNextPropView];
    
}

- (void)showInfo
{



}

- (void)preBtnClick
{
    

    [_columnView setContentOffset:CGPointMake((columnIndex - 1)*kPicWidth, 0) animated:NO];
  
    
}

- (void)nextBtnClick
{
   
    [_columnView setContentOffset:CGPointMake((columnIndex +1)*kPicWidth, 0) animated:NO];
   
    
    
}
- (void)changeBabyInfo
{
    LoginViewController *modifyInfoVC = [[LoginViewController alloc] initWithNibName:nil bundle:nil];
    [[MainTabBarController sharedMainViewController].view addSubview:modifyInfoVC.view];
    [modifyInfoVC setControlBtnType:kCloseAndFinishButton];
    [modifyInfoVC setTitle:@"欢迎使用扑满日记！" withIcon:nil];
    [modifyInfoVC loginSetting];
    [modifyInfoVC show];
    
}

- (void) refreshBabyInfo
{

    [self setColumnImgBMode:NO];

}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
