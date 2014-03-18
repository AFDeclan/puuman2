//
//  DiaryShowCell.h
//  puman
//
//  Created by 祁文龙 on 13-11-14.
//  Copyright (c) 2013年 创始人团队. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DiaryShowCell : UITableViewCell
{

}
@property (weak, nonatomic) IBOutlet UILabel *detailLabel;
@property (weak, nonatomic) IBOutlet UILabel *nodeLabel;
@property (weak, nonatomic) IBOutlet UIImageView *flagImgView;
@property (weak, nonatomic) IBOutlet UIButton *touch;
@property (retain) NSDictionary* diaryInfo;
- (void) buildCellViewWithIndexRow:(NSUInteger)index;
- (IBAction)touchePressed:(UIButton *)sender;
@end
