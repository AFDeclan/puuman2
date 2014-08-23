//
//  DiaryCell.m
//  puuman2
//
//  Created by Ra.（祁文龙） on 14-3-10.
//  Copyright (c) 2014年 AFITC. All rights reserved.
//

#import "DiaryCell.h"
#import "TextDiaryCell.h"
#import "AuPhotoDiaryCell.h"
#import "AudioDiaryCell.h"
#import "VideoDiaryCell.h"
#import "PhotoMoreDiaryCell.h"
#import "PhotoSingleDiaryCell.h"
#import "MainTabBarController.h"
#import "DiaryTableViewController.h"
#import "Diary.h"


@implementation DiaryCell
@synthesize diary = _diary;
@synthesize indexPath = _indexPath;
@synthesize delBtn = _delBtn;
@synthesize delScrollView = _delScrollView;
@synthesize diaryType = _diaryType;
@synthesize controlCanHidden = _controlCanHidden;
@synthesize abbr =_abbr;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [MyNotiCenter addObserver:self selector:@selector(loadInfo) name:Noti_LoadDiaryCellInfo object:nil];
        // Initialization code
         delConfirm = NO;
        _controlCanHidden = YES;
         bg =[[UIView alloc] init];
        [bg setBackgroundColor:[UIColor clearColor]];
        [self.contentView addSubview:bg];
        
        self.contentView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"paper_diary.png"]];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        _timeLine = [[UIView alloc] init];
        _timeLine.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"pic_timeline_diary.png"]];
        [self.contentView addSubview:_timeLine];
        _ageLabel1 = [[UILabel alloc] initWithFrame:CGRectMake(0, 24, 80, 20)];
        [_ageLabel1 setFont:PMFont2];
        [_ageLabel1 setTextColor:PMColor3];
        [_ageLabel1 setBackgroundColor:[UIColor clearColor]];
        [_ageLabel1 setTextAlignment:NSTextAlignmentCenter];
        [self.contentView addSubview:_ageLabel1];
        
        _ageLabel2 = [[UILabel alloc] initWithFrame:CGRectMake(0, 52, 80, 20)];
        [_ageLabel2 setFont:PMFont2];
        [_ageLabel2 setTextColor:PMColor3];
        [_ageLabel2 setBackgroundColor:[UIColor clearColor]];
        [_ageLabel2 setTextAlignment:NSTextAlignmentCenter];
        [self.contentView addSubview:_ageLabel2];
        
        _ageLabel3 = [[UILabel alloc] initWithFrame:CGRectMake(0, 80, 80, 20)];
        [_ageLabel3 setFont:PMFont2];
        [_ageLabel3 setTextColor:PMColor3];
        [_ageLabel3 setBackgroundColor:[UIColor clearColor]];
        [_ageLabel3 setTextAlignment:NSTextAlignmentCenter];
        [self.contentView addSubview:_ageLabel3];
        _icon_from  = [[UIImageView alloc] initWithFrame:CGRectMake(80, 24, 16, 16)];
        [_icon_from setBackgroundColor:[UIColor clearColor]];
        [self.contentView addSubview:_icon_from];
        
        _dateLabel = [[UILabel alloc] initWithFrame:CGRectMake(112, 24, 80, 16)];
        _dateLabel.font = PMFont3;
        _dateLabel.textColor = PMColor2;
        _dateLabel.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:_dateLabel];
        
        _content = [[UIView alloc] init];
        _content.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:_content];
        
        _fromLabel = [[UILabel alloc] initWithFrame:CGRectMake(192, 24, 64, 16)];
        _fromLabel.font = PMFont3;
        _fromLabel.textColor = PMColor3;
        _fromLabel.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:_fromLabel];
        [self initWithShareAndDelBtn];
        dividingLine = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 672, 2)];
        [dividingLine setImage:[UIImage imageNamed:@"line2_diary.png"]];
        [self.contentView addSubview:dividingLine];
        [MyNotiCenter addObserver:self selector:@selector(CellVisibled:) name:Noti_DiaryCellVisible object:nil];
    }
    return self;
}


- (void)loadInfo
{


}

- (void)buildCellViewWithIndexRow:(NSUInteger)index abbreviated:(BOOL)abbr
{
    indexRow = index;
    _abbr = abbr;
    CGFloat height = kHeaderHeight + kFooterHeight + ViewHeight(_content);
    [self buildParentControl];
    SetViewLeftUp(dividingLine, 0, height-2);
    [bg setFrame:CGRectMake(0, 0, 672, height)];
    
    if ([DiaryTableViewController needLoadInfo]) {
        [self loadInfo];
    }
      [self loadData];
}

- (void)initWithShareAndDelBtn
{
    _shareBtn = [[UIButton alloc] initWithFrame:CGRectMake(0,0, 24, 24)];
    [_shareBtn setImage:[UIImage imageNamed:@"btn_share_diary.png"] forState:UIControlStateNormal];
    [_shareBtn setBackgroundColor:[UIColor clearColor]];
    [_shareBtn addTarget:self action:@selector(share:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:_shareBtn];
    
    _delBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 24, 24)];
    [_delBtn setImage:[UIImage imageNamed:@"btn_delete1_diary.png"] forState:UIControlStateNormal];
    [_delBtn addTarget:self action:@selector(delete) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:_delBtn];
    
    UILabel *noti =[[UILabel alloc] init];
    [noti setText:@"确定删除？"];
    [noti setFont:PMFont3];
    [noti setBackgroundColor:[UIColor clearColor]];
    [noti setTextColor:PMColor8];
    [noti adjustSize];
    CGFloat width = ViewWidth(noti), height = ViewHeight(noti);
    _delScrollView=[[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, width, height)];
    SetViewRightCenter(_delScrollView, ViewX(_delBtn), ViewY(_delBtn)+ViewHeight(_delBtn)/2);
    _delScrollView.backgroundColor=[UIColor clearColor];
    [_delScrollView setScrollEnabled:NO];
    [_delScrollView setContentSize:CGSizeMake(width*2, height)];
    [self.contentView addSubview:_delScrollView];
    SetViewLeftUp(noti, width, 0);
    [_delScrollView addSubview:noti];
    if (_diary.sampleDiary)
    {
        [_delBtn setEnabled:NO];
    }else{
        [_delBtn setEnabled:YES];
    }
    
    coinBtn = [[AFSelectedTextImgButton alloc]initWithFrame:CGRectMake(0, 0, 32, 32)];
    [coinBtn setSelectedImg:[UIImage imageNamed:@"coin_diary_receive.png"]];
    [coinBtn setUnSelectedImg:[UIImage imageNamed:@"coin_diary_noreceive.png"]];
    [coinBtn setIconSize:CGSizeMake(32, 32)];
    [coinBtn adjustLayout];
    [coinBtn addTarget:self action:@selector(getCoin) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:coinBtn];
    [coinBtn unSelected];
    
    coinLabel = [[UILabel alloc] init];
    [coinLabel setFrame:CGRectMake(0, 0, 66, 24)];
    [coinLabel setBackgroundColor:[UIColor clearColor]];
    [coinLabel setFont:PMFont3];
    [self.contentView addSubview:coinLabel];
    
    coinView = [[UIImageView alloc] initWithFrame:CGRectMake(32,ViewY(coinBtn)- 50, 10,10)];
    [coinView setImage:[UIImage imageNamed:@"coinView_diary_image.png"]];
    [coinView setBackgroundColor:[UIColor clearColor]];
    [self.contentView addSubview:coinView];
    [coinView setAlpha:0];
    
}


- (void)coinAnimate
{
    SetViewLeftUp(coinView, 32, ViewY(coinBtn)- 50);
    CABasicAnimation *fadeAnimation = [CABasicAnimation animationWithKeyPath:@"opacity"];
    fadeAnimation.fromValue = [NSNumber numberWithFloat:0.2];
    fadeAnimation.toValue = [NSNumber numberWithFloat:1.0];
    fadeAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    fadeAnimation.duration = 0.75;
    [fadeAnimation setBeginTime:0];
    [fadeAnimation setDelegate:self];
    fadeAnimation.removedOnCompletion = NO;
    fadeAnimation.fillMode = kCAFillModeForwards;
    
    CABasicAnimation *scaleAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    scaleAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    scaleAnimation.fromValue = [NSNumber numberWithFloat:1];
    scaleAnimation.toValue = [NSNumber numberWithFloat:2];
    scaleAnimation.duration = 2;
    [scaleAnimation setBeginTime:0];
    scaleAnimation.removedOnCompletion = NO;
    scaleAnimation.fillMode = kCAFillModeForwards;
    
    CAKeyframeAnimation *positionAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    positionAnimation.fillMode = kCAFillModeForwards;
    positionAnimation.removedOnCompletion =NO;
    positionAnimation.duration = 1;
    CGMutablePathRef positionPath = CGPathCreateMutable();
    positionAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    [positionAnimation setBeginTime:0];
    
    CGPathMoveToPoint(positionPath, NULL, [coinView layer].position.x, [coinView layer].position.y);
    CGPathAddQuadCurveToPoint(positionPath, NULL, [coinView layer].position.x, [coinView layer].position.y, [coinView layer].position.x,[coinView layer].position.y+50);
    positionAnimation.path = positionPath;

    
    
    CAAnimationGroup*group = [CAAnimationGroup animation];
    [group  setDuration:1];
//    group.removedOnCompletion = NO;
//    group.fillMode = kCAFillModeForwards;
    [group setDelegate:self];
    [group setAnimations:[NSArray arrayWithObjects:fadeAnimation,scaleAnimation, positionAnimation, nil]];
    [coinView.layer addAnimation:group forKey:@"group"];
    

}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    if (flag) {
        [coinBtn selected];
        coinLabel.text = @"已打赏";
        [coinLabel setTextColor:PMColor3];
        [coinBtn setBackgroundColor:[UIColor clearColor]];
    }
  
}

- (void)getCoin {
    
    [coinBtn setEnabled:NO];
    
    if (_diary.rewarded) {
        [coinBtn selected];

    } else {
        
        if ([_diary reward:1]) {
            PostNotification(Noti_AddCorns, [NSNumber numberWithFloat:-1]);
            [self coinAnimate];
  
        }else{
            [coinBtn unSelected];

        }
    }

}



- (void)buildParentControl
{
    SetViewLeftUp(_delBtn,632, 24);
    SetViewLeftUp(_shareBtn,632, ViewY(_content)+ViewHeight(_content)-24);
    SetViewLeftUp(coinBtn, 20, ViewY(_content) +ViewHeight(_content));
    SetViewLeftUp(coinLabel, 54, ViewY(_content) + ViewHeight(_content)+5);
    
    SetViewRightCenter(_delScrollView, ViewX(_delBtn), ViewY(_delBtn)+ViewHeight(_delBtn)/2);
    if (self.indexPath.row == 0) {
        [_timeLine setFrame:CGRectMake(86, 32, 1, kHeaderHeight + kFooterHeight + ViewHeight(_content) )];
    }else{
        [_timeLine setFrame:CGRectMake(86, 0, 1, kHeaderHeight + kFooterHeight + ViewHeight(_content) )];
    }
    [self buildAgeLabels];
    [self buildFromIdentity];
 
    
}

- (void)loadData
{

    if (_diary.sampleDiary) {
        [coinBtn setAlpha:0];
        [coinLabel setText:@""];
        
    }else{
        if (_diary.UIdentity == [UserInfo sharedUserInfo].identity){
            [coinBtn setAlpha:1];
            if ([_diary rewarded]) {
                [coinBtn selected];
                [coinBtn setBackgroundColor:[UIColor clearColor]];
                coinLabel.text = @"已打赏";
                
            }else {
                [coinBtn unSelected];
                if (_diary.UIdentity == Father){
                    coinLabel.text = @"赏给爸爸!";
                    [coinLabel setTextColor:PMColor6];
                    
                } else {
                    coinLabel.text = @"赏给妈妈!";
                    [coinLabel setTextColor:RGBColor(239, 128, 123)];
                }
            }
        }else{
            [coinBtn unSelected];
            [coinBtn setAlpha:0];
            coinLabel.text = @"";
            if ([_diary rewarded]) {
                if (_diary.UIdentity == Father) {
                    coinLabel.text = @"妈妈赏了你";
                    [coinLabel setTextColor:RGBColor(239, 128, 123)];
                }else {
                    coinLabel.text = @"爸爸赏了你!";
                    [coinLabel setTextColor:PMColor6];
                    
                }
                
            }
        }
    }


}

- (void)buildAgeLabels
{
    //age
    NSDate *date = self.diary.DCreateTime;
    _ageLabel1.alpha = 0;
    _ageLabel2.alpha = 0;
    _ageLabel3.alpha = 0;
    NSArray *age = [date ageFromDate:[[[UserInfo sharedUserInfo] babyInfo] Birthday]];
    NSMutableArray *ageStr = [[NSMutableArray alloc] init];
    NSString *unitStr = nil;
    [_delBtn setAlpha:1];
    
    if (_diary.sampleDiary)
    {
        unitStr = @"样例日记";
        [_delBtn setAlpha:0];
        [_shareBtn setAlpha:0];
        delCanShow = NO;
        shareCanShow = NO;
        [ageStr addObject:unitStr];
    }
    else if ([age count] == 3)
    {
        
        NSString *y = [age objectAtIndex:0];
        NSString *m = [age objectAtIndex:1];
        NSString *d = [age objectAtIndex:2];
        if ([y integerValue] > 0)
        {
            [ageStr addObject:[NSString stringWithFormat:@"%@岁", y]];
        }
        if ([m integerValue] > 0)
        {
           [ageStr addObject:[NSString stringWithFormat:@"%@个月", m]];
        }
        if ([d integerValue] > 0)
        {
           
            [ageStr addObject:[NSString stringWithFormat:@"%@天", d]];
        }
    }
    else if ([age count] == 2)
    {
        [ageStr addObject:@"孕期"];
        NSString *w = [age objectAtIndex:0];
        NSString *d = [age objectAtIndex:1];
        if ([w integerValue] > 0)
        {
            [ageStr addObject:[NSString stringWithFormat:@"%@周", w]];
        }
        if ([d integerValue] > 0)
        {
            [ageStr addObject:[NSString stringWithFormat:@"%@天", d]];
        }
    }
    NSArray *agelabels = [NSArray arrayWithObjects:_ageLabel1,_ageLabel2,_ageLabel3, nil];
    for (int i=0; i<[ageStr count]; i++)
    {
        UILabel *ageLabel = (UILabel *)[agelabels objectAtIndex:i];
        [ageLabel setText:[ageStr objectAtIndex:i]];
        [ageLabel setAlpha:1];
    
    }
    _dateLabel.text = [DateFormatter stringFromDate:date];
}

- (void)buildFromIdentity
{
    if (_diary.sampleDiary)
    {
        _fromLabel.text = @"";
        _icon_from.image = nil;
        return;
    }
   // NSString *fromIdentity = [self.diaryInfo valueForKey:kDiaryUIdentity];
   // NSString *fromIdentity = self.diary.UIdentity;
    UserIdentity fromIdentity = self.diary.UIdentity;
    if (!(self.diary.sampleDiary) &&fromIdentity ==[UserInfo sharedUserInfo].identity)
    {
        [_delBtn setAlpha:1];
    }else{
        [_delBtn setAlpha:0];
    }
    
    if (!fromIdentity) {
        fromIdentity = [UserInfo sharedUserInfo].identity;
    }
    if (fromIdentity==Mother)
    {
        _fromLabel.text = @"来自妈妈";
        _icon_from.image = [UIImage imageNamed:@"tri_pink_diary.png"];
    }
    else  if (fromIdentity==Father)
    {
        _fromLabel.text = @"来自爸爸";
        _icon_from.image = [UIImage imageNamed:@"tri_blue_diary.png"];
    }
    if (!(self.diary.sampleDiary) &&fromIdentity ==[UserInfo sharedUserInfo].identity)
    {
        [_delBtn setAlpha:1];
        delCanShow = YES;
    }else{
        [_delBtn setAlpha:0];
        delCanShow = NO;
    }

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)delete
{
    if(delConfirm)
    {
        [self deleteConfirmed];
    }else{
        delConfirm = YES;
        [UIView animateWithDuration:0.3 animations:^{
            [_delBtn setImage:[UIImage imageNamed:@"btn_delete2_diary.png"] forState:UIControlStateNormal];
            [_delScrollView setContentOffset:CGPointMake(_delScrollView.contentSize.width/2, 0)];
        }];
        [MyNotiCenter postNotificationName:Noti_DelBtnShowed object:self];
    }
    
}

- (void)deleteConfirmed
{
    
    [MyNotiCenter postNotificationName:Noti_DeleteDiary object:self.diary];

    
}

- (void)prepareForReuse
{
    //在这里移除所有临时控件,准备重用
    [self delBtnReset];
}

- (void)delBtnReset
{
    delConfirm = NO;
    [UIView animateWithDuration:0.3 animations:^{
        [_delBtn setImage:[UIImage imageNamed:@"btn_delete1_diary.png"] forState:UIControlStateNormal];
        
        if (_diary.sampleDiary)
        {
            [_delBtn setEnabled:NO];
        }else{
            [_delBtn setEnabled:YES];
        }
        [_delScrollView setContentOffset:CGPointMake(0, 0)];
    }];
}


- (void)share:(id)sender
{
    //子类重载
    
    
}

- (void)CellVisibled:(NSNotification *)notification
{

    float tableY  = [[notification object] floatValue];
    
    if ([MainTabBarController sharedMainViewController].isVertical) {
        if (self.frame.origin.y < 512) {
            _controlCanHidden = NO;
        }
        if (self.frame.origin.y < tableY+512 && self.frame.origin.y + self.frame.size.height > tableY+512) {
            [self showAndHideControlBtnWithHidden:NO];
        }else{
            [self showAndHideControlBtnWithHidden:YES];
        }
    }else{
        if (self.frame.origin.y < 384) {
            _controlCanHidden = NO;
        }
        if (self.frame.origin.y < tableY+384 && self.frame.origin.y + self.frame.size.height > tableY+384) {
            [self showAndHideControlBtnWithHidden:NO];
        }else{
            [self showAndHideControlBtnWithHidden:YES];
        }
    }
   
}

- (void)showAndHideControlBtnWithHidden:(BOOL)isHidden;
{

    if (isHidden) {
        if (_controlCanHidden) {
            [_delBtn setAlpha:0];
            
            [_shareBtn setAlpha:0];
        }
    

    }else{
        if (delCanShow) {
             [_delBtn setAlpha:1];
        }
        if (shareCanShow) {
             [_shareBtn setAlpha:1];
        }

    }
    
}

- (void)setDiaryType:(DiaryType)diaryType
{
    _diaryType = diaryType;
    if(diaryType == kDiaryPhotoType ||diaryType == kDiaryTextType ||diaryType == kDiaryPhotoAudioType)
    {
        shareCanShow = YES;
        
    }else{
        shareCanShow = NO;
    }
    
  
}

+ (CGFloat)heightForDiary:(Diary*) diary abbreviated:(BOOL)abbr
{
    CGFloat height = kHeaderHeight + kFooterHeight;
    NSString *type = diary.type1Str;
    if ([type isEqualToString:DiaryTypeStrText])  //是文本类型
    {
        height += [TextDiaryCell heightForDiary:diary abbreviated:abbr]  ;
    }else if ([type isEqualToString:DiaryTypeStrPhoto])    //是照片类型
    {
                if ([diary.type2Str isEqualToString:DiaryTypeStrAudio]) //有声图
                {
                    height += [AuPhotoDiaryCell heightForDiary:diary abbreviated:abbr];
                }
                else
                {
                    NSArray *photoPaths = diary.filePaths1;
                    if ([photoPaths count]>1) {
                         height += [PhotoMoreDiaryCell heightForDiary:diary abbreviated:abbr];
                    }else{
                         height += [PhotoSingleDiaryCell heightForDiary:diary abbreviated:abbr];
                    }
                   
                }
    }else if ([type isEqualToString:DiaryTypeStrAudio])
    {
        height += [AudioDiaryCell heightForDiary:diary abbreviated:abbr];
    }else if ([type isEqualToString:DiaryTypeStrVideo])
    {
        height += [VideoDiaryCell heightForDiary:diary abbreviated:abbr];
    }
        return height;
}

@end
