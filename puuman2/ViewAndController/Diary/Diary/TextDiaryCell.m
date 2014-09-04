//
//  TextDiaryCell.m
//  puman
//
//  Created by Declan on 13-12-28.
//  Copyright (c) 2013年 创始人团队. All rights reserved.
//

#import "TextDiaryCell.h"
#import "UniverseConstant.h"
#import "DiaryModel.h"
#import "UILabel+AdjustSize.h"
//#import "CustomAlertView.h"
#import "DetailShowViewController.h"
#import "UIImage+CroppedImage.h"
#import "DiaryViewController.h"
#import "DiaryFileManager.h"
#import "DiaryCell.h"
#import "Share.h"

#define  TEXT_PHOTO_HEIGHT 128


@implementation TextDiaryCell
@synthesize delegate =_delegate;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        //在这里初始化控件（可重用的部分）
        photo = nil;
       
        titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 16, ContentWidth, 24)];
        [titleLabel setFont:PMFont1];
        [titleLabel setTextColor:PMColor1];
        [titleLabel setBackgroundColor:[UIColor clearColor]];
        [_content addSubview:titleLabel];
        [titleLabel setAlpha:0];
        
        
         showBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 128, 128)];
        [showBtn setBackgroundColor:[UIColor clearColor]];
        [showBtn addTarget:self action:@selector(showPhoto) forControlEvents:UIControlEventTouchUpInside];
        [_content addSubview:showBtn];
        _photoView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 128, 128)];
        [_photoView setBackgroundColor:[UIColor clearColor]];
        [showBtn setAlpha:0];
        [showBtn addSubview:_photoView];
        
        _contentLabel = [[TextLayoutLabel alloc] initWithFrame:CGRectMake(0, 0, ContentWidth, 80)];
        _contentLabel.numberOfLines = 4;
        _contentLabel.font = PMFont2;
        _contentLabel.textColor = PMColor2;
        _contentLabel.backgroundColor = [UIColor clearColor];
        [_contentLabel setLinesSpacing:6];
        [_contentLabel setCharacterSpacing:1];
        [_content addSubview:_contentLabel];

        
        line = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 64, 12)];
        [line setText:@"......"];
        [line setTextColor:PMColor2];
        [line setFont:PMFont2];
        [line setBackgroundColor:[UIColor clearColor]];
        [_content addSubview:line];
        [line setAlpha:1];
        
        spreadBtn = [[UIButton alloc] init];
        [spreadBtn setBackgroundColor:[UIColor clearColor]];
        [spreadBtn addTarget:self action:@selector(spread) forControlEvents:UIControlEventTouchUpInside];
        [_content addSubview:spreadBtn];
        reloadBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [reloadBtn setFrame:CGRectMake(16, 8, ContentWidth-128-32, 80)];
        [reloadBtn setBackgroundColor:[UIColor clearColor]];
        [_content addSubview:reloadBtn];
        [reloadBtn setTitle:@"文字记录下载失败，点击重新下载" forState:UIControlStateNormal];
        [reloadBtn setTitleColor:PMColor2 forState:UIControlStateNormal];
        [reloadBtn addTarget:self action:@selector(reloadFile) forControlEvents:UIControlEventTouchUpInside];
        [reloadBtn setAlpha:0];
    }
    return self;
    
}

- (void)spread
{
    [_delegate tableView:nil didSelectRowAtIndexPath:self.indexPath];
}

- (void)buildCellViewWithIndexRow:(NSUInteger)index abbreviated:(BOOL)abbr
{
   [_shareBtn setAlpha:1];
    titleLabel.text = self.diary.title;
    if ([self.diary.title isEqualToString:@""]) {
        [titleLabel setFrame:CGRectMake(0, 0, 0, 0)];
        [titleLabel setAlpha:0];
    }else{
        [titleLabel setFrame:CGRectMake(0, 16, ContentWidth, 24)];
        [titleLabel setAlpha:1];
    }

    CGRect frame = CGRectMake(0, 24 + ViewHeight(titleLabel) + ViewY(titleLabel), ContentWidth, 0);
    [showBtn setAlpha:0];
    if ([self.diary.type2Str isEqualToString:DiaryTypeStrPhoto]) {
        frame = CGRectMake(0, 24 + ViewHeight(titleLabel) + ViewY(titleLabel), ContentWidth-TEXT_PHOTO_HEIGHT-16, 0);
        [showBtn setAlpha:1];
        [_photoView setImage:[UIImage imageNamed:@"pic_default_diary.png"]];
        SetViewLeftUp(showBtn,ContentWidth-TEXT_PHOTO_HEIGHT, 24 + ViewHeight(titleLabel) + ViewY(titleLabel));
    }
    CGFloat dh = 0;
    
   
    
//    if ([[self.diary urls1] count]>0 && !filePath)
//    {
//        
//        if ([[NSFileManager defaultManager] fileExistsAtPath:[self.diary.filePaths1 objectAtIndex:0]])
//        {
//            NSError *error;
//            [[NSFileManager defaultManager] removeItemAtPath:[self.diary.filePaths1 objectAtIndex:0] error:&error];
//        }
//    }

    filePath = [self.diary.filePaths1 objectAtIndex:0];
    if (_contentLabel) {
        [_contentLabel removeFromSuperview];
    }
    if ([[NSFileManager defaultManager] fileExistsAtPath:filePath])
    {
        
        _contentLabel = [[TextLayoutLabel alloc] initWithFrame:CGRectMake(16, 8, ContentWidth, 80)];
        _contentLabel.numberOfLines = 0;
        _contentLabel.font = PMFont2;
        _contentLabel.textColor = PMColor2;
        _contentLabel.backgroundColor = [UIColor clearColor];
        [_contentLabel setLinesSpacing:12];
        [_contentLabel setCharacterSpacing:1];
        [_content addSubview:_contentLabel];
        NSString *text = [NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:nil];
        if (text == nil) text = @"";
    
        dh = [_contentLabel setText:text abbreviated:abbr];
        frame.size.height = dh;
        [_contentLabel setFrame:frame];
        if (_contentLabel.didAbbr) {
            [line setAlpha:1];
            SetViewLeftUp(line, 0,frame.origin.y+ frame.size.height);
            // SetViewLeftUp(line, 16, _contentLabel.frame.origin.y+_contentLabel.frame.size.height);
            [spreadBtn setFrame:frame];
            [spreadBtn setAlpha:1];
        }else{
            [line setAlpha:0];
            [spreadBtn setAlpha:0];
        }
        [reloadBtn setAlpha:0];
    }else{
        
        SetViewLeftUp(reloadBtn, 16, 24 + ViewHeight(titleLabel) + ViewY(titleLabel));
        [reloadBtn setAlpha:1];
         [line setAlpha:0];
    }
    
    if ([self.diary.type2Str isEqualToString:DiaryTypeStrPhoto])
        if (dh < TEXT_PHOTO_HEIGHT) dh = TEXT_PHOTO_HEIGHT;
    dh += ViewHeight(titleLabel)+ViewY(titleLabel)+24;
    if (dh <80) {
        dh = 80;
    }
    [_content setFrame:CGRectMake(112,kHeaderHeight, ContentWidth,dh )];
    [super buildCellViewWithIndexRow:index abbreviated:abbr];
}

- (void)loadInfo
{
    [super loadInfo];
    
    if ([self.diary.type2Str isEqualToString:DiaryTypeStrPhoto])
    {
//        if ([[self.diary urls2] count]>0 && !_photoPath)
//        {
//            if ([UIImage imageWithContentsOfFile:[self.diary.filePaths2 objectAtIndex:0]])
//                {
//                        NSError *error;
//                        [[NSFileManager defaultManager] removeItemAtPath:[self.diary.filePaths2 objectAtIndex:0] error:&error];
//                }
//        }
        _photoPath = [self.diary.filePaths2 objectAtIndex:0];
        if ([UIImage imageWithContentsOfFile:_photoPath]&&[UIImage imageWithContentsOfFile:_photoPath])
        {
            photo = [DiaryFileManager imageForPath:_photoPath];
            UIImage  *photo2 = [UIImage croppedImage:photo WithHeight:256 andWidth:256];
            [_photoView setImage:photo2];
        }else{
            [_photoView setImage:[UIImage imageNamed:@"pic_redownload.png"]];
         
        }

    }
    
}

- (void)share:(id)sender
{
   
    [super share:sender];
    //子类重载
//    NSString *text;
//    UIImage *img;
//    NSString *path = [self.diary.filePaths1 objectAtIndex:0] ;
//    NSString *diaryType2 = self.diary.type2Str;
//    if ([[NSFileManager defaultManager]fileExistsAtPath:path])
//        text = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
//    else text = @"";
//    if ([text length] == 1) {
//        text = [text stringByAppendingString:@" "];
//    }
//    if ([diaryType2 isEqualToString:DiaryTypeStrPhoto])
//    {
//        NSString *photoPath = [self.diary.filePaths2 objectAtIndex:0];
//        img = [[UIImage alloc] initWithContentsOfFile:photoPath];
//    }
//    NSString *title = self.diary.title;
//    
//    
//    [ShareSelectedViewController shareText:text title:title image:img];
    
    
}
- (void)prepareForReuse
{
    [super prepareForReuse];
    //去除临时控件，准备重用
}
- (void)showPhoto
{
    if ([UIImage imageWithContentsOfFile:_photoPath]&&[UIImage imageWithContentsOfFile:_photoPath])
    {
        [DetailShowViewController showPhotoPath:_photoPath andTitle:titleLabel.text];

    }else{
        [self.diary redownloadContent2AtIndex:0 withRecall:^(BOOL finished){
            [self loadInfo];
        }];
    }


}

- (void)reloadFile
{
    [self.diary redownloadContent1AtIndex:0 withRecall:^(BOOL finished){
        [self buildCellViewWithIndexRow:indexRow abbreviated:self.abbr];
    }];
}

+ (CGFloat)heightForDiary:(Diary*)diary abbreviated:(BOOL)abbr
{
    CGFloat height = 0;
    if (![diary.title isEqualToString:@""])
        height += 40;
    CGRect frame;
    if ([diary.type2Str isEqualToString:DiaryTypeStrPhoto])
    {
        frame = CGRectMake(0, 0, ContentWidth-TEXT_PHOTO_HEIGHT-16, 80);
    }
    else frame = CGRectMake(0, 0, ContentWidth, 80);
    TextLayoutLabel *textLayoutLabel  = [[TextLayoutLabel alloc] initWithFrame:CGRectMake(16, 8, ContentWidth, 80)];
    textLayoutLabel.numberOfLines = 0;
    textLayoutLabel.font = PMFont2;
    textLayoutLabel.textColor = PMColor2;
    textLayoutLabel.backgroundColor = [UIColor clearColor];
    [textLayoutLabel setLinesSpacing:12];
    [textLayoutLabel setCharacterSpacing:1];
        
    NSString *filePath = [diary.filePaths1 objectAtIndex:0];
    NSString *text;
    if ([[NSFileManager defaultManager] fileExistsAtPath:filePath])
        text = [NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:nil];
    else text = @"";
    if (text == nil) text = @"";
    CGFloat dh = [textLayoutLabel setText:text abbreviated:abbr];
        
        
        
    if ([diary.type2Str isEqualToString:DiaryTypeStrPhoto])
        if (dh < TEXT_PHOTO_HEIGHT) dh = TEXT_PHOTO_HEIGHT;
    height += dh +24;
    textLayoutLabel = nil;

    
    if (height < 80)
        height = 80;
    return height;
    
};


@end
