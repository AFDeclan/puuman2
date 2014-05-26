//
//  VideoDiaryCell.m
//  puman
//
//  Created by Declan on 13-12-28.
//  Copyright (c) 2013年 创始人团队. All rights reserved.
//

#import "VideoDiaryCell.h"
#import "MainTabBarController.h"
#import "DiaryFileManager.h"
#import "Device.h"
#import "DetailShowViewController.h"
#import "UniverseConstant.h"



@implementation VideoDiaryCell

@synthesize reuseIdentifier = _reuseIdentifier;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        //在这里初始化控件（可重用的部分）
        _imgView = [[DiaryImageView alloc] initWithFrame:CGRectMake(56, 24, 416, 416)];
        [_imgView setBackgroundColor:[UIColor clearColor]];
        _imgView.userInteractionEnabled = YES;
        [_content addSubview:_imgView];
        
        _playBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _playBtn.frame = CGRectMake(216, 184, 96, 96);
        [_playBtn setImage:[UIImage imageNamed:@"btn_play_diary.png"] forState:UIControlStateNormal];
        [_playBtn addTarget:self action:@selector(playVideo) forControlEvents:UIControlEventTouchUpInside];
        [_content addSubview:_playBtn];
        [_playBtn setAlpha:0];
        titleView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 416-80, 416, 80)];
        [titleView setImage:[UIImage imageNamed:@"bg_title_diary.png"]];
        [titleView setBackgroundColor:[UIColor clearColor]];
        [_imgView addSubview:titleView];
        
        titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(56, 24, 416, 416)];
        [titleLabel setTextAlignment:NSTextAlignmentRight];
        [titleLabel setFont:PMFont1];
        [titleLabel setTextColor:[UIColor whiteColor]];
        [titleLabel setBackgroundColor:[UIColor clearColor]];
        [titleView addSubview:titleLabel];
        [titleView setAlpha:0];
        reloadBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [reloadBtn setFrame:CGRectMake(56, 24, 416, 416)];
        [reloadBtn setBackgroundColor:[UIColor clearColor]];
        [_content addSubview:reloadBtn];
        [reloadBtn setTitle:@"录像下载失败，点击重新下载" forState:UIControlStateNormal];
        [reloadBtn setTitleColor:PMColor2 forState:UIControlStateNormal];
        [reloadBtn addTarget:self action:@selector(reloadFile) forControlEvents:UIControlEventTouchUpInside];
        [reloadBtn setAlpha:0];

    }
    return self;
    
}

- (void)buildCellViewWithIndexRow:(NSUInteger)index abbreviated:(BOOL)abbr
{
    titleLabel.text = self.diary.title;
    if ([self.diary.title isEqualToString:@""]) {
        [titleView setAlpha:0];
    }else{
        [titleView setAlpha:1];
    }
    [_shareBtn setAlpha:0];
    [_imgView setImage:[UIImage imageNamed:@"pic_default_diary.png"]];
    _content.frame = CGRectMake(112,kHeaderHeight,ContentWidth,440);
    [super buildCellViewWithIndexRow:index abbreviated:abbr];
    //在这里调整控件坐标，填充内容
}

- (void)loadInfo
{
    [super loadInfo];
    
//    if ([[self.diary urls1] count]>0 && !filePath)
//    {
//            if ([[NSFileManager defaultManager] fileExistsAtPath:[self.diary.filePaths1 objectAtIndex:0]])
//            {
//                    NSError *error;
//                    [[NSFileManager defaultManager] removeItemAtPath:[self.diary.filePaths1 objectAtIndex:0] error:&error];
//           }
//    }
    filePath = [self.diary.filePaths1 objectAtIndex:0];
  
    if ([[NSFileManager defaultManager] fileExistsAtPath:filePath])
    {
        [_imgView setCropSize:CGSizeMake(832, 832)];
        [_imgView loadVideoImgWithPath:[self.diary.filePaths1 objectAtIndex:0]];
        [_playBtn setAlpha:1];
        [_imgView setAlpha:1];
        [reloadBtn setAlpha:0];
    }else{
        
        [_imgView setAlpha:0];
        [_playBtn setAlpha:0];
        [reloadBtn setAlpha:1];
    }
    
}

- (void)playVideo
{
   [DetailShowViewController showVideo:filePath andTitle:titleLabel.text];
}


- (void)reloadFile
{
    [self.diary redownloadContent1AtIndex:0 withRecall:^(BOOL finished){
        [self loadInfo];
    }];
}

- (void)share:(id)sender
{
    //子类重载
    
}

- (void)prepareForReuse
{
    [super prepareForReuse];
    //去除临时控件，准备重用
}

+ (CGFloat)heightForDiary:(NSDictionary *)diaryInfo abbreviated:(BOOL)abbr 
{
    return 440;
}

@end
