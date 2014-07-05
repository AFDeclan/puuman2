//
//  PregnancyTableViewCell.m
//  puuman2
//
//  Created by AF_Bigwaves on 14-7-4.
//  Copyright (c) 2014年 AFITC. All rights reserved.
//

#import "PregnancyTableViewCell.h"

#define columnB @"http://appui.oss-cn-hangzhou.aliyuncs.com/%E5%AD%95%E6%9C%9F%E5%9B%BE%E7%89%87%EF%BC%88%E4%BA%A7%E6%A3%80%EF%BC%89/"
#define columnA @"http://appui.oss-cn-hangzhou.aliyuncs.com/%E5%AD%95%E6%9C%9F%E5%9B%BE%E7%89%87%EF%BC%88%E6%89%8B%E7%BB%98%EF%BC%89/"
static NSString *clonumAimages[40] = {@"1week%402x.jpg",@"2week%402x.jpg",@"3week%402x.jpg",@"4week%402x.jpg",@"5week%402x.jpg",@"6week%402x.jpg",@"7week%402x.jpg",@"8week%402x.jpg",@"9week%402x.jpg",@"10week%402x.jpg",@"11week%402x.jpg",@"12week%402x.jpg",@"13week%402x.jpg",@"14week%402x.jpg",@"15week%402x.jpg",@"16week%402x.jpg",@"17week%402x.jpg",@"18week%402x.jpg",@"19week%402x.jpg",@"20week%402x.jpg",@"21week%402x.jpg",@"22week%402x.jpg",@"23week%402x.jpg",@"24week%402x.jpg",@"25week%402x.jpg",@"26week%402x.jpg",@"27week%402x.jpg",@"28week%402x.jpg",@"29week%402x.jpg",@"30week%402x.jpg",@"31week%402x.jpg",@"32week%402x.jpg",@"33week%402x.jpg",@"34week%402x.jpg",@"35week%402x.jpg",@"36week%402x.jpg",@"37week%402x.jpg",@"38week%402x.jpg",@"39week%402x.jpg",@"40week%402x.jpg"};
static NSString *clonumBimages[40] = {@"1week-b%402x.PNG",@"2week-b%402x.PNG",@"3week-b%402x.PNG",@"4week-b%402x.PNG",@"5week-b%402x.PNG",@"6week-b%402x.PNG",@"7week-b%402x.PNG",@"8week-b%402x.PNG",@"9week-b%402x.PNG",@"10week-b%402x.PNG",@"11week-b%402x.PNG",@"12week-b%402x.PNG",@"13week-b%402x.PNG",@"14week-b%402x.PNG",@"15week-b%402x.PNG",@"16week-b%402x.PNG",@"17week-b%402x.PNG",@"18week-b%402x.PNG",@"19week-b%402x.PNG",@"20week-b%402x.PNG",@"21week-b%402x.PNG",@"22week-b%402x.PNG",@"23week-b%402x.PNG",@"24week-b%402x.PNG",@"25week-b%402x.PNG",@"26week-b%402x.PNG",@"27week-b%402x.PNG",@"28week-b%402x.PNG",@"29week-b%402x.PNG",@"30week-b%402x.PNG",@"31week-b%402x.PNG",@"32week-b%402x.PNG",@"33week-b%402x.PNG",@"34week-b%402x.PNG",@"35week-b%402x.PNG",@"36week-b%402x.PNG",@"37week-b%402x.PNG",@"38week-b%402x.PNG",@"39week-b%402x.PNG",@"40week-b%402x.PNG"};

@implementation PregnancyTableViewCell
@synthesize indexNum = _indexNum;
@synthesize columnImgBMode = _columnImgBMode;

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
    imageView = [[AFImageView alloc] initWithFrame:CGRectMake(0, 0, kPicWidth,kPicHeight)];
    imageView.contentMode = UIViewContentModeScaleAspectFit;
    [imageView setBackgroundColor:[UIColor clearColor]];
    [self.contentView addSubview:imageView];
    [imageView setImage:[UIImage imageNamed:@"pic_default_diary.png"]];
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


- (void)setIndexNum:(NSInteger)indexNum
{
    [imageView setImage:[UIImage imageNamed:@"pic_default_diary.png"]];
    _indexNum = indexNum;
    [imageView prepareForReuse];
    NSString *imageName = _columnImgBMode ? [NSString stringWithFormat:@"%@%@", columnB,clonumBimages[indexNum]] : [NSString stringWithFormat:@"%@%@",columnA,clonumAimages[indexNum]];
    [imageView getImage:imageName defaultImage:@"pic_default_diary.png"];
}

@end
