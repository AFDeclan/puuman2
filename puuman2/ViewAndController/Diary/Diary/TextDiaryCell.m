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
    titleLabel.text = [self.diaryInfo valueForKey:kTitleName];
    if ([[self.diaryInfo valueForKey:kTitleName] isEqualToString:@""]) {
        [titleLabel setFrame:CGRectMake(0, 0, 0, 0)];
        [titleLabel setAlpha:0];
    }else{
        [titleLabel setFrame:CGRectMake(0, 16, ContentWidth, 24)];
        [titleLabel setAlpha:1];
    }

    CGRect frame;
    if ([[self.diaryInfo valueForKey:kType2Name] isEqualToString:vType_Photo] &&![[self.diaryInfo valueForKey:kFilePath2Name] isEqualToString:@""])
    {
        frame = CGRectMake(0, 24 + ViewHeight(titleLabel) + ViewY(titleLabel), ContentWidth-TEXT_PHOTO_HEIGHT-16, 0);
        [showBtn setAlpha:1];
        NSString *photoPath = [self.diaryInfo valueForKey:kFilePath2Name];
        photo = [DiaryFileManager imageForPath:photoPath];
        UIImage  *photo2 = [UIImage croppedImage:photo WithHeight:256 andWidth:256];
        _photoView.image = photo2;
        SetViewLeftUp(showBtn,ContentWidth-TEXT_PHOTO_HEIGHT, 24 + ViewHeight(titleLabel) + ViewY(titleLabel));
        
       
    }else{
        
        frame = CGRectMake(0, 24 + ViewHeight(titleLabel) + ViewY(titleLabel), ContentWidth, 0);
        [showBtn setAlpha:0];

    }

    if (_contentLabel) {
        [_contentLabel removeFromSuperview];
    }
    _contentLabel = [[TextLayoutLabel alloc] initWithFrame:CGRectMake(16, 8, ContentWidth, 80)];
    _contentLabel.numberOfLines = 0;
    _contentLabel.font = PMFont2;
    _contentLabel.textColor = PMColor2;
    _contentLabel.backgroundColor = [UIColor clearColor];
    [_contentLabel setLinesSpacing:12];
    [_contentLabel setCharacterSpacing:1];
    [_content addSubview:_contentLabel];
    NSString *filePath = [self.diaryInfo valueForKey:kFilePathName];
    NSString *text;
    if ([[NSFileManager defaultManager] fileExistsAtPath:filePath])
        text = [NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:nil];
    else text = @"";
    if (text == nil) text = @"";
    CGFloat dh = [_contentLabel setText:text abbreviated:abbr];
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
    if ([[self.diaryInfo valueForKey:kType2Name] isEqualToString:vType_Photo])
        if (dh < TEXT_PHOTO_HEIGHT) dh = TEXT_PHOTO_HEIGHT;
    dh += ViewHeight(titleLabel)+ViewY(titleLabel)+24;
    if (dh <80) {
        dh = 80;
    }
    [_content setFrame:CGRectMake(112,kHeaderHeight, ContentWidth,dh )];
    [super buildCellViewWithIndexRow:index abbreviated:abbr];
}

- (void)share:(id)sender
{
   

//    //子类重载
//    NSString *text;
//    UIImage *img;
//    NSString *path = [self.diaryInfo objectForKey:kFilePathName] ;
//    NSString *diaryType2 = [self.diaryInfo valueForKey:kType2Name];
//    if ([[NSFileManager defaultManager]fileExistsAtPath:path])
//        text = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
//    else text = @"";
//    if ([text length] == 1) {
//        text = [text stringByAppendingString:@" "];
//    }
//    if ([diaryType2 isEqualToString:vType_Photo])
//    {
//        NSString *photoPath = [self.diaryInfo valueForKey:kFilePath2Name];
//        img = [[UIImage alloc] initWithContentsOfFile:photoPath];
//    }
//    NSString *title = [self.diaryInfo valueForKey:kTitleName];
//    
//     [[DiaryViewController sharedDiaryViewController] shareDiaryWithText:text title:title image:img];
    
    
}
- (void)prepareForReuse
{
    [super prepareForReuse];
    //去除临时控件，准备重用
}
- (void)showPhoto
{
    if (photo) {
        NSString *photoPath = [self.diaryInfo valueForKey:kFilePath2Name];
        [DetailShowViewController showPhotoPath:photoPath];
    }

}
+ (CGFloat)heightForDiary:(NSDictionary *)diaryInfo abbreviated:(BOOL)abbr
{
    CGFloat height = 0;
    if (![[diaryInfo valueForKey:kTitleName] isEqualToString:@""])
        height += 40;
    CGRect frame;
    if ([[diaryInfo valueForKey:kType2Name] isEqualToString:vType_Photo])
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
    NSString *filePath = [diaryInfo valueForKey:kFilePathName];
    NSString *text;
    if ([[NSFileManager defaultManager] fileExistsAtPath:filePath])
        text = [NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:nil];
    else text = @"";
    if (text == nil) text = @"";
    CGFloat dh = [textLayoutLabel setText:text abbreviated:abbr];



    if ([[diaryInfo valueForKey:kType2Name] isEqualToString:vType_Photo])
        if (dh < TEXT_PHOTO_HEIGHT) dh = TEXT_PHOTO_HEIGHT;
    height += dh +24;
    textLayoutLabel = nil;
    if (height < 80)
        height = 80;
    return height;
    
};


@end
