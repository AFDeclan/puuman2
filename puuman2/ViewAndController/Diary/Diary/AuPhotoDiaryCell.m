//
//  AuPhotoDiaryCell.m
//  puman
//
//  Created by Declan on 13-12-28.
//  Copyright (c) 2013年 创始人团队. All rights reserved.
//

#import "AuPhotoDiaryCell.h"
#import "UniverseConstant.h"
#import "DiaryFileManager.h"
//#import "CustomAlertView.h"
#import "DetailShowViewController.h"
#import "UIImage+CroppedImage.h"
#import "DiaryViewController.h"

@implementation AuPhotoDiaryCell

@synthesize reuseIdentifier = _reuseIdentifier;
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        //在这里初始化控件（可重用的部分）
        [MyNotiCenter addObserver:self selector:@selector(stopPlayAudio) name:Noti_PauseMultiMedia object:nil];
        
        _photoView = [[UIImageView alloc] initWithFrame:CGRectMake(56, 24, 416, 416)];
        [_content addSubview:_photoView];
        
        UITapGestureRecognizer *tapPhoto = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showPhoto)];
        [_photoView addGestureRecognizer:tapPhoto];
        [_photoView setBackgroundColor:[UIColor clearColor]];
        _photoView.userInteractionEnabled = YES;
        
        playBtn = [[NewAudioPlayView alloc] initWithFrame:CGRectMake(216, 392, 96, 96)];
        [playBtn setDelegate:self];
        [_content addSubview:playBtn];
      
      

        
        titleView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 416, 80)];
        [titleView setImage:[UIImage imageNamed:@"bg_title_diary.png"]];
        [titleView setBackgroundColor:[UIColor clearColor]];
        [_photoView addSubview:titleView];
        titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 400, 80)];
        [titleLabel setTextAlignment:NSTextAlignmentRight];
        [titleLabel setFont:PMFont1];
        [titleLabel setTextColor:[UIColor whiteColor]];
        [titleLabel setBackgroundColor:[UIColor clearColor]];
        [titleView addSubview:titleLabel];
        [titleView setAlpha:0];
        
    }
    return self;
    
}

- (void)buildCellViewWithIndexRow:(NSUInteger)index abbreviated:(BOOL)abbr
{
    titleLabel.text = [self.diaryInfo valueForKey:kTitleName];
    if ([[self.diaryInfo valueForKey:kTitleName] isEqualToString:@""]) {
        [titleView setAlpha:0];
    }else{
        [titleView setAlpha:1];
    }
    //在这里调整控件坐标，填充内容
    photo = [DiaryFileManager thumbImageForPath:[self.diaryInfo valueForKey:kFilePathName]];
    photo = [UIImage croppedImage:photo WithHeight:592 andWidth:640];
    [_photoView setImage:photo];
    
    NSString *filePath = [self.diaryInfo valueForKey:kFilePath2Name];
    [playBtn setPlayFile:[NSURL fileURLWithPath:filePath]];
     _content.frame = CGRectMake(112,kHeaderHeight,ContentWidth,488);
    [super buildCellViewWithIndexRow:index abbreviated:abbr];

   
}

- (void)stopPlayAudio
{
    [playBtn stopPlay];
}

- (void)stopPlay
{

}
- (void)startPlay
{

}




- (void)dealloc
{
    [MyNotiCenter removeObserver:self];
}

- (void)share:(id)sender
{
//    //子类重载
//    NSString *text;
//    NSString *title = [self.diaryInfo valueForKey:kTitleName];
//    [[DiaryViewController sharedDiaryViewController] shareDiaryWithText:text title:title image:photo];
   // [CustomAlertView sharedInView:nil content:@"分享本条日记到......？" shareText:text title:title image:photo];
    
}

- (void)showPhoto
{
    [DetailShowViewController showPhotoPath:[self.diaryInfo valueForKey:kFilePathName]];

}

- (void)prepareForReuse
{
    [super prepareForReuse];
    //去除临时控件，准备重用
    
}

+ (CGFloat)heightForDiary:(NSDictionary *)diaryInfo abbreviated:(BOOL)abbr
{
    //计算高度
    return 488;
}


@end
