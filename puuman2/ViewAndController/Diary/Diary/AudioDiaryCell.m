//
//  AudioDiaryCell.m
//  puman
//
//  Created by Declan on 13-12-28.
//  Copyright (c) 2013年 创始人团队. All rights reserved.
//

#import "AudioDiaryCell.h"
#import "UniverseConstant.h"
//#import "CustomAlertView.h"

@implementation AudioDiaryCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        //在这里初始化控件（可重用的部分）
        [MyNotiCenter addObserver:self selector:@selector(stopAudio) name:Noti_PauseMultiMedia object:nil];
        titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 16, ContentWidth, 24)];
        [titleLabel setFont:PMFont1];
        [titleLabel setTextColor:PMColor1];
        [titleLabel setBackgroundColor:[UIColor clearColor]];
        [_content addSubview:titleLabel];
        [titleLabel setAlpha:0];
        
        playBtn = [[NewAudioPlayView alloc] initWithFrame:CGRectMake(220, 24, 96, 96)];
        [playBtn setDelegate:self];
        [_content addSubview:playBtn];
        reloadBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [reloadBtn setFrame:CGRectMake(56, 8, ContentWidth-128, 80)];
        [reloadBtn setBackgroundColor:[UIColor clearColor]];
        [_content addSubview:reloadBtn];
        [reloadBtn setTitle:@"录音下载失败，点击重新下载" forState:UIControlStateNormal];
        [reloadBtn setTitleColor:PMColor2 forState:UIControlStateNormal];
        [reloadBtn addTarget:self action:@selector(reloadFile) forControlEvents:UIControlEventTouchUpInside];
        [reloadBtn setAlpha:0];

    }
    return self;
    
}

- (void)buildCellViewWithIndexRow:(NSUInteger)index abbreviated:(BOOL)abbr
{
    [_shareBtn setAlpha:0];
    float height = 0;
    titleLabel.text = self.diary.title;
    if ([self.diary.title isEqualToString:@""]) {
        [titleLabel setAlpha:0];
    }else{
        height += 40;
        [titleLabel setAlpha:1];
    }
    SetViewLeftUp(playBtn, 216, 24+height);
    height += 24+96;
   
    //在这里调整控件坐标，填充内容
    //audio player init

    _content.frame = CGRectMake(112,kHeaderHeight,ContentWidth,height);
   

    
//    if ([[NSFileManager defaultManager] fileExistsAtPath:filePath])
//    {
//        [playBtn setPlayFile:[NSURL fileURLWithPath:filePath]];
//        [playBtn setAlpha:1];
//    }else{
//      [playBtn setAlpha:0];
//    }
   
    [super buildCellViewWithIndexRow:index abbreviated:abbr];
}

- (void)loadInfo
{
    [super loadInfo];
    
//    if ([[self.diary urls1] count]>0 && !filePath)
//    {
//        if ([[NSFileManager defaultManager] fileExistsAtPath:[self.diary.filePaths1 objectAtIndex:0]])
//        {
//            NSError *error;
//            [[NSFileManager defaultManager] removeItemAtPath:[self.diary.filePaths1 objectAtIndex:0] error:&error];
//        }
//    }

    filePath = [self.diary.filePaths1 objectAtIndex:0];
    NSError *playerError;
    AVAudioPlayer *player = [[AVAudioPlayer alloc] initWithContentsOfURL:[NSURL fileURLWithPath:filePath] error:&playerError];
    
    if (player)
    {
        [playBtn setPlayFile:[NSURL fileURLWithPath:filePath]];
        [playBtn setAlpha:1];
        [reloadBtn setAlpha:0];
    }else{
        [playBtn setAlpha:0];
        [reloadBtn setAlpha:1];
        
    }
}

- (void)reloadFile
{
    [self.diary redownloadContent1AtIndex:0 withRecall:^(BOOL finished){
        [self loadInfo];
    }];
}

- (void)stopAudio
{
    [playBtn stopPlay];
}

- (void)stopPlay
{
   
}
- (void)startPlay
{

}


- (void)share:(id)sender
{
    //子类重载
//    NSString *text;
//    UIImage *img;
//    NSString *path = [self.diaryInfo valueForKey:kFilePathName];
//    img = [DiaryFileManager imageForPath:path];
//    NSString *title = [self.diaryInfo valueForKey:kTitleName];
//    [CustomAlertView sharedInView:nil content:@"分享本条日记到......？" shareText:text title:title image:img];
    
}

- (void)dealloc
{
    [MyNotiCenter removeObserver:self];
}

- (void)prepareForReuse
{
    [super prepareForReuse];
    //去除临时控件，准备重用
}

+ (CGFloat)heightForDiary:(Diary*)diary abbreviated:(BOOL)abbr
{
    CGFloat height = 120;
    if (![diary.title isEqualToString:@""])
        height += 40;
    //计算高度
    
    return height;
}

@end
