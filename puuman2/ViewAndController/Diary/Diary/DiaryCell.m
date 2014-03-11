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


@implementation DiaryCell
@synthesize diaryInfo = _diaryInfo;
@synthesize indexPath = _indexPath;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
         delConfirm = NO;
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
        
    }
    return self;
}

- (void)buildCellViewWithIndexRow:(NSUInteger)index abbreviated:(BOOL)abbr
{
    
    CGFloat height = kHeaderHeight + kFooterHeight + ViewHeight(_content);
    [self buildParentControl];
    SetViewLeftUp(dividingLine, 0, height-2);
    [bg setFrame:CGRectMake(0, 0, 672, height)];
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


}

- (void)buildParentControl
{
    SetViewLeftUp(_delBtn,632, 24);
    SetViewLeftUp(_shareBtn,632, ViewY(_content)+ViewHeight(_content)-24);
    SetViewRightCenter(_delScrollView, ViewX(_delBtn), ViewY(_delBtn)+ViewHeight(_delBtn)/2);
    if (self.indexPath.row == 0) {
        [_timeLine setFrame:CGRectMake(86, 32, 1, kHeaderHeight + kFooterHeight + ViewHeight(_content) )];
    }else{
        [_timeLine setFrame:CGRectMake(86, 0, 1, kHeaderHeight + kFooterHeight + ViewHeight(_content) )];
    }
    [self buildAgeLabels];
    [self buildFromIdentity];
}

- (void)buildAgeLabels
{
    //age
     NSDate *date = [self.diaryInfo valueForKey:kDateName];
    _ageLabel1.alpha = 0;
    _ageLabel2.alpha = 0;
    _ageLabel3.alpha = 0;
    NSArray *age = [date ageFromDate:[[BabyData sharedBabyData] babyBirth]];
    NSMutableArray *ageStr = [[NSMutableArray alloc] init];
    NSString *unitStr = nil;
    
    if ([_diaryInfo valueForKey:kSampleDiary])
    {
        unitStr = @"样例日记";
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
    if ([_diaryInfo valueForKey:kSampleDiary])
    {
        _fromLabel.text = @"";
        _icon_from.image = nil;
        return;
    }
    NSString *fromIdentity = [self.diaryInfo valueForKey:kDiaryUIdentity];
    if (![self.diaryInfo valueForKey:kSampleDiary] &&[fromIdentity isEqualToString:[UserInfo sharedUserInfo].identityStr])
    {
        [_delBtn setAlpha:1];
    }else{
        [_delBtn setAlpha:0];
    }
    
    if (!fromIdentity) {
        fromIdentity = [UserInfo sharedUserInfo].identityStr;
    }
    if ([fromIdentity isEqualToString: kUserIdentity_Mother])
    {
        _fromLabel.text = @"来自妈妈";
        _icon_from.image = [UIImage imageNamed:@"tri_pink_diary.png"];
    }
    else  if ([fromIdentity isEqualToString: kUserIdentity_Father])
    {
        _fromLabel.text = @"来自爸爸";
        _icon_from.image = [UIImage imageNamed:@"tri_blue_diary.png"];
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
    }
    
}

- (void)deleteConfirmed
{
    
    [MyNotiCenter postNotificationName:Noti_DeleteDiary object:self.diaryInfo];
    
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
        
        if ([_diaryInfo valueForKey:kSampleDiary])
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

+ (CGFloat)heightForDiary:(NSDictionary *)diaryInfo abbreviated:(BOOL)abbr
{
    CGFloat height = kHeaderHeight + kFooterHeight;
    NSString *type = [diaryInfo valueForKey:kTypeName];
    if ([type isEqualToString:vType_Text])  //是文本类型
    {
        height += [TextDiaryCell heightForDiary:diaryInfo abbreviated:abbr]  ;
    }
    else if ([type isEqualToString:vType_Photo])    //是照片类型
        {
                if ([[diaryInfo valueForKey:kType2Name] isEqualToString:vType_Audio]) //有声图
                {
                    height += [AuPhotoDiaryCell heightForDiary:diaryInfo abbreviated:abbr];
                }
                else
                {
                   // height += [PhotoDiaryCell heightForDiary:diaryInfo abbreviated:abbr];
                }
        }
                else if ([type isEqualToString:vType_Audio])
                {
                  //  height += [AudioDiaryCell heightForDiary:diaryInfo abbreviated:abbr];
                }
                else if ([type isEqualToString:vType_Video])
                {
                   // height += [VideoDiaryCell heightForDiary:diaryInfo abbreviated:abbr];
                }
        return height;
}

@end
