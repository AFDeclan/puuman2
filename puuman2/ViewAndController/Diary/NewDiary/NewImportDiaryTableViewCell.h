//
//  NewImportDiaryTableViewCell.h
//  puuman2
//
//  Created by Ra.（祁文龙） on 14-3-5.
//  Copyright (c) 2014年 AFITC. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol NewImportCellDelegate;
@interface NewImportDiaryTableViewCell : UITableViewCell
{
    UIButton *delBtn;
    UIImageView *imgView;
}
@property(assign,nonatomic)id<NewImportCellDelegate> delegate;
@property(assign,nonatomic)UIImage *image;
@property(assign,nonatomic)NSInteger index;
@end

@protocol NewImportCellDelegate <NSObject>

- (void)deleteWithIndex:(NSInteger)index;

@end