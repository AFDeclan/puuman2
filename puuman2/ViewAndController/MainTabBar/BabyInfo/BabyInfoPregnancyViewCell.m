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

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        [self initialization];
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
    

    
    contentView = [[UIView alloc] init];
    [contentView setBackgroundColor:RGBColor(239, 215, 207)];
    [self.contentView addSubview:contentView];
    
    clearInfoView = [[UIView alloc] init];
    [clearInfoView setBackgroundColor:[UIColor clearColor]];
    [contentView addSubview:clearInfoView];
    
    tapView = [[UIView alloc] init];
    [clearInfoView addSubview:tapView];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hiddenInfo)];
    [tapView addGestureRecognizer:tap];

    
    
     bottomBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [bottomBtn setBackgroundColor:[UIColor whiteColor]];
    [bottomBtn setAlpha:0.5];
    [bottomBtn setImage:[UIImage imageNamed:@"back_up_babyInfo.png"] forState:UIControlStateNormal];
    [bottomBtn addTarget:self action:@selector(disAppearInfoView) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:bottomBtn];
    
    picView = [[UIView alloc] init];
    [picView setBackgroundColor:[UIColor clearColor]];
    [clearInfoView addSubview:picView];
    [MyNotiCenter addObserver:self selector:@selector(showInfo) name:Noti_PreBabyShowInfo object:nil];
    
    
}



- (void)initClearInfoView
{

    changeModelBtn = [[BabyInfoChooseButton alloc] init];
    [changeModelBtn setType:kBabyInfoBModle];
    [changeModelBtn addTarget:self action:@selector(changeModelBtn) forControlEvents:UIControlEventTouchUpInside];
    [clearInfoView addSubview:changeModelBtn];
    
    propBtn = [[BabyInfoChooseButton alloc] init];
    [propBtn setType:kBabyInfoModle];
    [propBtn addTarget:self action:@selector(propBtn) forControlEvents:UIControlEventTouchUpInside];
    [clearInfoView addSubview:propBtn];
    
    grayLineRight = [[UIImageView alloc] init];
    [grayLineRight  setImage:[UIImage imageNamed:@"grayline_right_babyInfo.png"]];
    [clearInfoView addSubview:grayLineRight];
    
    grayLineLeft = [[UIImageView alloc] init];
    [grayLineLeft setImage:[UIImage imageNamed:@"grayline_left_babyInfo.png"]];
    [clearInfoView addSubview:grayLineLeft];
    
     nextPropView = [[UIImageView alloc] init];
    [nextPropView setImage:[UIImage imageNamed:@"gray_back_right_babyInfo"]];
    [clearInfoView addSubview:nextPropView];
    
    preBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [preBtn setFrame:CGRectMake(0 ,250, 23, 42)];
    [preBtn setImage:[UIImage imageNamed:@"pre_pic_btn.png"] forState:UIControlStateNormal];
    [preBtn addTarget:self action:@selector(preBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [picView addSubview:preBtn];
    
    nextBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [nextBtn setFrame:CGRectMake(610, 250, 23, 42)];
    [nextBtn setImage:[UIImage imageNamed:@"next_pic_btn.png"] forState:UIControlStateNormal];
    [nextBtn addTarget:self action:@selector(nextBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [picView addSubview:nextBtn];

    babyShowView = [[UIView alloc] initWithFrame:CGRectMake(85, 0, 480, 540)];
    [picView addSubview:babyShowView];
    
    weekView = [[UIView alloc] initWithFrame:CGRectMake(110,456, 62, 36)];
    [weekView setBackgroundColor:[UIColor redColor]];
    [weekView setAlpha:0.1];
    [weekView.layer setMasksToBounds:YES];
    [weekView.layer setCornerRadius:18.0];
    [picView addSubview:weekView];
    
     weekLabel = [[UILabel alloc] initWithFrame:CGRectMake(110, 456, 62, 36)];
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
    [nextBtn setAlpha:0];
    if (_columnView) {
        [_columnView removeFromSuperview];
        _columnView = nil;
    }
    
    _columnView = [[UIColumnView alloc] initWithFrame:CGRectMake(0, 0, 480, 540)];
    [_columnView setBackgroundColor:[UIColor clearColor]];
    [_columnView setViewDataSource:self];
    [_columnView setColumnViewDelegate:self];
    [_columnView setPagingEnabled:YES];
    [babyShowView addSubview:_columnView];
    [self reloadColumnView];
    

}

- (void)setVerticalFrame
{
    [contentView setFrame:CGRectMake(0, 96, 768, 928)];
    [clearInfoView setFrame:CGRectMake(0, 0, 768, 928)];
    [tapView setFrame:CGRectMake(0, 0, 768, 928)];
    [bottomBtn setFrame:CGRectMake(0, 976, 768, 48)];
    [bottomBtn setImageEdgeInsets:UIEdgeInsetsMake(8, 352, 8, 352)];
    [changeModelBtn setFrame:CGRectMake(24, 118, 160, 24)];
    [propBtn setFrame:CGRectMake(528, 84, 220, 85)];
    [picView setFrame:CGRectMake(66, 250, 636, 540)];
    [grayLineLeft setFrame:CGRectMake(24, 160, 240, 86)];
    [grayLineRight setFrame:CGRectMake(504, 158, 240, 86)];
    [nextPropView setFrame:CGRectMake(744, 110, 10, 18)];

//    [weekView setFrame:CGRectMake(300, 516, 62, 36)];
//    [weekLabel setFrame:CGRectMake(300, 516, 62, 36)];
 //   [_columnView setFrame:CGRectMake(85, 60, 480, 540)];


}

- (void)setHorizontalFrame
{
    [contentView setFrame:CGRectMake(0, 96, 1024, 672)];
    [clearInfoView setFrame:CGRectMake(0, 0, 1024, 672)];
    [tapView setFrame:CGRectMake(0, 0, 1024, 672)];
    [bottomBtn setFrame:CGRectMake(0, 720, 1024, 48)];
    [bottomBtn setImageEdgeInsets:UIEdgeInsetsMake(8, 480, 8, 480)];
    [changeModelBtn setFrame:CGRectMake(24, 118, 160, 24)];
    [propBtn setFrame:CGRectMake(780, 84, 220, 85)];
    [picView setFrame:CGRectMake(180, 60, 636, 540)];
    [grayLineLeft setFrame:CGRectMake(24, 160, 240, 86)];
    [grayLineRight setFrame:CGRectMake(780, 158, 240, 86)];
    [nextPropView setFrame:CGRectMake(1000,110, 10, 18)];
//    [preBtn setFrame:CGRectMake(180, 310, 23, 42)];
//    [nextBtn setFrame:CGRectMake(790, 310, 23, 42)];
//    [weekView setFrame:CGRectMake(300, 516, 62, 36)];
//    [weekLabel setFrame:CGRectMake(300, 516, 62, 36)];
 //   [_columnView setFrame:CGRectMake(85, 60, 480, 540)];

}

- (void) reloadColumnView
{
    [_columnView reloadData];
    NSArray *age = [[NSDate date] ageFromDate:[[[UserInfo sharedUserInfo]babyInfo] Birthday]];
    if ([age count] == 2) {
    
        NSInteger weekAge = [[age objectAtIndex:0] integerValue];
        if (weekAge >  BABY_COLUMN_CNT) weekAge =  BABY_COLUMN_CNT;
        [self setWeekWithIndex:weekAge];
    
    } else {
    
        [self setWeekWithIndex:1];
    }

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
    [self setWeekWithIndex:[self indexForColumnView]];
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
    [nextBtn setAlpha:1];
    [preBtn setAlpha:1];

    if (columnIndex >= 40) {

        [nextBtn setAlpha:0];
        
    }else if (columnIndex <=  1) {
        
        [preBtn setAlpha:0];
    }
    [_columnView setScrollEnabled:YES];

    
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
    
    PostNotification(Noti_HiddenBabyView, nil);
    
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
    
    [_delegate gotoNextCellWithProp:YES];
    
}


- (void)preBtnClick
{
    
    if (columnIndex > 1) {
        [nextBtn setAlpha:1];
        [_columnView setContentOffset:CGPointMake((columnIndex - 2)*kPicWidth, 0) animated:YES];
    }else{
        [preBtn setAlpha:0];

    }
    
    
}

- (void)nextBtnClick
{
    if (columnIndex < 40) {
        [preBtn setAlpha:1];
        [_columnView setContentOffset:CGPointMake((columnIndex )*kPicWidth, 0) animated:YES];

    }else{
        [nextBtn setAlpha:0];

    }
   
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
    [self initColumnView];
    [self.contentView bringSubviewToFront:picView];
    [self setColumnImgBMode:NO];
    [self scrollToToday];
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)showInfo
{
    [_columnView setScrollEnabled:NO];
}

- (void)hiddenInfo
{
    PostNotification(Noti_PreBabyHiddenInfo, nil);
    
}

- (void)scrollToToday
{
    NSArray *ages = [[NSDate date] ageFromDate:[[[UserInfo sharedUserInfo] babyInfo] Birthday]];
    int age = 1;
    if ([ages count] == 2) {
        age = [[ages objectAtIndex:0] intValue];
    }
    
    age = age>1?age:1;
    age = age>40?40:age;

    [UIView animateWithDuration:0.5 animations:^{
        [_columnView setContentOffset:CGPointMake(kPicWidth*(age-1), 0) ];
    }];
    
}


@end
