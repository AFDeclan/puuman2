//
//  DiaryShowCell.m
//  puman
//
//  Created by 祁文龙 on 13-11-14.
//  Copyright (c) 2013年 创始人团队. All rights reserved.
//

#import "DiaryShowCell.h"
#import "DiaryModel.h"
#import <AVFoundation/AVFoundation.h>
#import "UIImage+CroppedImage.h"
#import "DiaryViewController.h"

@implementation DiaryShowCell
@synthesize detailLabel =_detailLabel;
@synthesize nodeLabel = _nodeLabel;
@synthesize flagImgView = _flagImgView;
@synthesize diary = _diary;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void) buildCellViewWithIndexRow:(NSUInteger)index
{
    
 
    [_detailLabel setText:_diary.title];
    NSString *diaryType = _diary.type1Str;
     if ([diaryType isEqualToString:DiaryTypeStrText]) [self bulidTextCell];
     else if ([diaryType isEqualToString:DiaryTypeStrPhoto]) [self bulidPhotoCell];
     else if ([diaryType isEqualToString:DiaryTypeStrAudio]) [self bulidAudiotCell];
     else if ([diaryType isEqualToString:DiaryTypeStrVideo]) [self bulidVideoCell];

}
- (void)bulidTextCell
{
    if ([_diary.title isEqualToString:@""]) {
         NSString *path = [_diary.filePaths1 objectAtIndex:0] ;
        NSString *text;
        if ([[NSFileManager defaultManager]fileExistsAtPath:path])
            text = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
        else text = @"";
        if (text == nil) text = @"";
         [_detailLabel setText:text];
    }
    
    
    if ([_diary.type2Str isEqualToString:DiaryTypeStrPhoto])
    {
         NSString *photoPath = [_diary.filePaths2 objectAtIndex:2];
         UIImage *photo = [[UIImage alloc] initWithContentsOfFile:photoPath];
          photo = [UIImage croppedImage:photo WithHeight:112 andWidth:112];
         [_flagImgView setImage:photo];
          [_nodeLabel setText:@"添加了图文日记"];
    }else{
          [_nodeLabel setText:@"添加了文字日记"];
          [_flagImgView setImage:[UIImage imageNamed:@"icon_text_h_diary.png"]];
    }
    
}
- (void)bulidPhotoCell
{
     if ([_diary.title isEqualToString:@""]) {
         CGRect frame = _nodeLabel.frame;
         frame.origin.y = 26;
         [_nodeLabel setFrame:frame];
     }
    NSString *photoPathsString = [_diary.filePaths1 objectAtIndex:0];
    NSArray *photoPaths = [photoPathsString componentsSeparatedByString:@"#@#"];
    UIImage *photo = [[UIImage alloc] initWithContentsOfFile:[photoPaths objectAtIndex:0]];
    photo = [UIImage croppedImage:photo WithHeight:112 andWidth:112];
    [_flagImgView setImage:photo];
    [_nodeLabel setText:@"添加了图片日记"];
  
}
- (void)bulidAudiotCell
{
    if ([_diary.title isEqualToString:@""]) {
        CGRect frame = _nodeLabel.frame;
        frame.origin.y = 26;
        [_nodeLabel setFrame:frame];
    }
    [_flagImgView setImage:[UIImage imageNamed:@"icon_audio_h_diary.png"]];
    [_nodeLabel setText:@"添加了录音日记"];
}
- (void)bulidVideoCell
{
    if ([_diary.title isEqualToString:@""]) {
        CGRect frame = _nodeLabel.frame;
        frame.origin.y = 26;
        [_nodeLabel setFrame:frame];
    }
    UIImage *image = [self imageForVideo];
    image = [UIImage croppedImage:image WithHeight:112 andWidth:112];
    [_flagImgView setImage:image];
    [_nodeLabel setText:@"添加了视频日记"];
}
- (UIImage *)imageForVideo
{
    NSString *filePath = [_diary.filePaths1 objectAtIndex:0];
    if (!filePath) return nil;
    NSString *cutImagePath = [filePath stringByAppendingString:@"_cutImage"];
    if ([[NSFileManager defaultManager]fileExistsAtPath:cutImagePath])
    {
        UIImage *image = [[UIImage alloc] initWithContentsOfFile:cutImagePath];
        return image;
    }
    AVURLAsset *asset = [[AVURLAsset alloc] initWithURL:[NSURL fileURLWithPath:filePath] options:nil];
    AVAssetImageGenerator *gen = [[AVAssetImageGenerator alloc] initWithAsset:asset];
    gen.appliesPreferredTrackTransform = YES;
    CMTime time = CMTimeMakeWithSeconds(0.0, 600);
    NSError *error = nil;
    CMTime actualTime;
    CGImageRef cgImage = [gen copyCGImageAtTime:time actualTime:&actualTime error:&error];
    UIImage *image = [[UIImage alloc] initWithCGImage:cgImage];
    if (!image)
        image = [[UIImage alloc] init];
    return image;
}
- (IBAction)touchePressed:(UIButton *)sender
{
    [MobClick event:umeng_event_click label:@"showDiaryCell_DiaryShowCell"];
    //int index =  [[DiaryModel sharedDiaryModel] indexForDiaryNearDate:[_diaryInfo valueForKey:kDateName] filtered:DIARY_FILTER_ALL];
    int index =[[DiaryModel sharedDiaryModel]indexForDiaryInDay:_diary.DCreateTime];
    [[DiaryViewController sharedDiaryViewController] showDiaryAtIndex:index];
}
@end
