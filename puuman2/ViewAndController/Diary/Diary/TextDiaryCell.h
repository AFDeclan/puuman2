//
//  TextDiaryCell.h
//  puman
//
//  Created by Declan on 13-12-28.
//  Copyright (c) 2013年 创始人团队. All rights reserved.
//

#import "DiaryCell.h"
#import "TextLayoutLabel.h"
#import "Diary.h"
@protocol TextDiaryDelegate;
@interface TextDiaryCell : DiaryCell
{
    TextLayoutLabel *_contentLabel;
    UIImageView  *_photoView;
    UIImage *photo;
    UIButton *showBtn;
    UIButton *spreadBtn;
    UILabel *line;
    UILabel *titleLabel;
    NSString *_photoPath;
    UIButton *reloadBtn;
}
@property (assign,nonatomic)id <TextDiaryDelegate> delegate;

@end
@protocol TextDiaryDelegate <NSObject>

- (void)tableView:(UITableView *)parent didSelectRowAtIndexPath:(NSIndexPath *)indexPath;

@end