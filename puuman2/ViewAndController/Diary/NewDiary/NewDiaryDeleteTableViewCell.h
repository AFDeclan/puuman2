//
//  NewDiaryDeleteTableViewCell.h
//  puuman2
//
//  Created by Ra.（祁文龙） on 14-3-7.
//  Copyright (c) 2014年 AFITC. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol NewDiaryDeleteTableViewCellDelegate;
@interface NewDiaryDeleteTableViewCell : UITableViewCell
{
    UIButton *delBtn;
    UIImageView *imgView;
}
@property(assign,nonatomic)id<NewDiaryDeleteTableViewCellDelegate> delegate;
@property(assign,nonatomic)UIImage *img;
@property(assign,nonatomic)NSInteger index;
@end

@protocol NewDiaryDeleteTableViewCellDelegate <NSObject>

- (void)deleteWithIndex:(NSInteger)index;

@end

