//
//  NewTextDiaryViewController.h
//  puuman2
//
//  Created by Ra.（祁文龙） on 14-3-4.
//  Copyright (c) 2014年 AFITC. All rights reserved.
//

#import "CustomPopViewController.h"
#import "CustomTextField.h"
#import "NewTextPhotoSelectedViewController.h"
#import "Forum.h"
@interface NewTextDiaryViewController :CustomPopViewController<NewTextSelectPhotoDelegate,UITextViewDelegate,ForumDelegate>
{
    CustomTextField *titleTextField;
    UIView *imgBox;
    UIButton *takePicBtn;
    UIImageView *imageView;
    UITextView *_textView;
    UIButton *delBtn;
    UIImage *photo;
}
@property (assign, nonatomic) BOOL isTopic;
@property (retain, nonatomic) NSDictionary *taskInfo;
@end
