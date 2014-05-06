//
//  BabyPreTableViewCell.m
//  puuman2
//
//  Created by Ra.（祁文龙） on 14-5-5.
//  Copyright (c) 2014年 AFITC. All rights reserved.
//

#import "BabyPreTableViewCell.h"
#import "ColorsAndFonts.h"
#import "UniverseConstant.h"

#define columnB @"http://appui.oss-cn-hangzhou.aliyuncs.com/%E5%AD%95%E6%9C%9F%E5%9B%BE%E7%89%87%EF%BC%88%E4%BA%A7%E6%A3%80%EF%BC%89/"
#define columnA @"http://appui.oss-cn-hangzhou.aliyuncs.com/%E5%AD%95%E6%9C%9F%E5%9B%BE%E7%89%87%EF%BC%88%E6%89%8B%E7%BB%98%EF%BC%89/"
static NSString *clonumAimages[40] = {@"1week%402x.jpg",@"2week%402x.jpg",@"3week%402x.jpg",@"4week%402x.jpg",@"5week%402x.jpg",@"6week%402x.jpg",@"7week%402x.jpg",@"8week%402x.jpg",@"9week%402x.jpg",@"10week%402x.jpg",@"11week%402x.jpg",@"12week%402x.jpg",@"13week%402x.jpg",@"14week%402x.jpg",@"15week%402x.jpg",@"16week%402x.jpg",@"17week%402x.jpg",@"18week%402x.jpg",@"19week%402x.jpg",@"20week%402x.jpg",@"21week%402x.jpg",@"22week%402x.jpg",@"23week%402x.jpg",@"24week%402x.jpg",@"25week%402x.jpg",@"26week%402x.jpg",@"27week%402x.jpg",@"28week%402x.jpg",@"29week%402x.jpg",@"30week%402x.jpg",@"31week%402x.jpg",@"32week%402x.jpg",@"33week%402x.jpg",@"34week%402x.jpg",@"35week%402x.jpg",@"36week%402x.jpg",@"37week%402x.jpg",@"38week%402x.jpg",@"39week%402x.jpg",@"40week%402x.jpg"};
static NSString *clonumBimages[40] = {@"1week-b%402x.PNG",@"2week-b%402x.PNG",@"3week-b%402x.PNG",@"4week-b%402x.PNG",@"5week-b%402x.PNG",@"6week-b%402x.PNG",@"7week-b%402x.PNG",@"8week-b%402x.PNG",@"9week-b%402x.PNG",@"10week-b%402x.PNG",@"11week-b%402x.PNG",@"12week-b%402x.PNG",@"13week-b%402x.PNG",@"14week-b%402x.PNG",@"15week-b%402x.PNG",@"16week-b%402x.PNG",@"17week-b%402x.PNG",@"18week-b%402x.PNG",@"19week-b%402x.PNG",@"20week-b%402x.PNG",@"21week-b%402x.PNG",@"22week-b%402x.PNG",@"23week-b%402x.PNG",@"24week-b%402x.PNG",@"25week-b%402x.PNG",@"26week-b%402x.PNG",@"27week-b%402x.PNG",@"28week-b%402x.PNG",@"29week-b%402x.PNG",@"30week-b%402x.PNG",@"31week-b%402x.PNG",@"32week-b%402x.PNG",@"33week-b%402x.PNG",@"34week-b%402x.PNG",@"35week-b%402x.PNG",@"36week-b%402x.PNG",@"37week-b%402x.PNG",@"38week-b%402x.PNG",@"39week-b%402x.PNG",@"40week-b%402x.PNG"};
#define  BABY_COLUMN_CNT   40
#define kPicWidth 256
#define kPicHeight 296


static NSString *info[40] ={@"·宝宝·\n因为精子与卵子暂时还没有接触，所以婴儿还没有形成。为了便利，怀孕期通常从最后一次月经周期开始算起，共40周（280天）。但是，真正的排卵和精子的受精在最后月经后的两周才会发生，所以怀孕的最初两周并不是真正的怀孕期间。严格来说，婴儿是精子与卵子受精大约38周后诞生的。\n·妈妈·\n受精后12天会形成胎盘，并分泌人绒毛膜促性腺激素（hCG），此时可以用早孕试纸自我检测怀孕与否，但最好还是等到人绒毛膜促性腺激素充分分泌，大概需要1~2周的时间，这样会得到更准确的结果。如果体质敏感的话，这种荷尔蒙的变化会引起呕吐等症状。妊娠呕吐在怀孕第3个月时最厉害，此时人绒毛膜促性腺激素分泌达到最高潮；之后会慢慢变好。为了运输更多的氧与营养，血液量也会开始增加。血液量的增幅在怀孕的前三个月程度最大，分娩时会有比没怀孕时多出30%~50%的血液。为了适应增加的血液量，心脏也会跳得更快更有力，脉搏次数会比没怀孕时每分钟多跳15下，因此可能有疲劳、气喘的症状。这段时间乳房的感觉也会和以前不太一样，用手指按乳房时会感到有些硬，甚至麻木或疼痛，乳房和乳头也开始变大，乳晕也会变宽，颜色变深，这是因为血液循环变得活跃起来，使色素沉着。这种变化在出产后也有可能持续。同时子宫的内膜开始变厚，血管也更加发达了。"};





@implementation BabyPreTableViewCell
@synthesize  showInfo = _showInfo;
@synthesize maskAlpha = _maskAlpha;
@synthesize contentY = _contentY;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        [self initialization];
    }
    return self;
}

- (void)initialization
{
    _showInfo = NO;
    content = [[UIView alloc] initWithFrame:CGRectMake(8, 32, kPicWidth, kPicHeight)];
    [self.contentView addSubview:content];
    
    imgView = [[AFImageView alloc] initWithFrame:CGRectMake(0, 0, kPicWidth, kPicHeight)];
    [content addSubview:imgView];
    
    qusetionView = [[UIImageView alloc] initWithFrame:CGRectMake(180, 16, 64, 64)];
    [qusetionView setImage:[UIImage imageNamed:@"btn_preinfo_baby.png"] ];
    [content addSubview:qusetionView];
    
    infoView = [[UIView alloc] initWithFrame:CGRectMake(0, -kPicHeight, kPicWidth, kPicHeight)];
    [content addSubview:infoView];
    
    content.layer.masksToBounds = YES;
    
    UIView *bgInfo = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kPicWidth, kPicHeight)];
    [bgInfo setBackgroundColor:[UIColor blackColor]];
    [bgInfo setAlpha:0.5];
    [infoView addSubview:bgInfo];

    
    weekTitle = [[UILabel alloc] initWithFrame:CGRectMake(0, 10, kPicWidth, 28)];
    [weekTitle setBackgroundColor:[UIColor clearColor]];
    [weekTitle setTextColor:[UIColor whiteColor]];
    [weekTitle setTextAlignment:NSTextAlignmentCenter];
    [weekTitle setFont:PMFont(28)];
    [infoView addSubview:weekTitle];
    
    infoTextView = [[UITextView alloc] initWithFrame:CGRectMake(12,40, kPicWidth - 24, kPicHeight-40-8)];
    [infoTextView setBackgroundColor:[UIColor clearColor]];
    [infoTextView setTextColor:[UIColor whiteColor]];
    [infoTextView setTextAlignment:NSTextAlignmentCenter];
    [infoTextView setFont:PMFont2];
    [infoView addSubview:infoTextView];

    mask  = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kPicWidth, kPicHeight)];
    [mask setBackgroundColor:[UIColor whiteColor]];
    [content addSubview:mask];
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


- (void)buildCellWithIndex:(NSInteger)index andSelectedIndex:(NSInteger)selectedIndex andColumnImgBMode:(BOOL)bModel
{
    NSString *imageName = bModel ? [NSString stringWithFormat:@"%@%@", columnB,clonumBimages[index -1]] : [NSString stringWithFormat:@"%@%@",columnA,clonumAimages[index-1]];
    [weekTitle setText:[NSString stringWithFormat:@"%dweek",index]];
    [infoTextView setText:info[0]];
    
    [imgView getImage:imageName defaultImage:@"pic_default_baby.png"];

    if (selectedIndex == index) {
        [mask setAlpha:0];
        SetViewLeftUp(content, 8, 0);
    }else{
        [mask setAlpha:0.5];
        SetViewLeftUp(content, 8, 32);
    }

}

- (void)setShowInfo:(BOOL)showInfo
{
    if (_showInfo != showInfo) {
        _showInfo = showInfo;
        if (showInfo) {
            [UIView animateWithDuration:0.5 animations:^{
                SetViewLeftUp(infoView, 0, 0);
                [qusetionView setAlpha:0];
            } ];
        }else{
            [UIView animateWithDuration:0.5 animations:^{
                SetViewLeftUp(infoView, 0, -kPicHeight);
                [qusetionView setAlpha:1];
            }];
        }
    }
  
}

- (void)setMaskAlpha:(float)maskAlpha
{
    _maskAlpha = maskAlpha;
    [mask setAlpha:maskAlpha];
}

- (void)setContentY:(float)contentY
{
    _contentY = contentY;
    SetViewLeftUp(content, 8, contentY);
}
@end
