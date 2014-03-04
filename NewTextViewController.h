//
//  NewTextViewController.h
//  puuman2
//
//  Created by Ra.（祁文龙） on 14-3-4.
//  Copyright (c) 2014年 AFITC. All rights reserved.
//

#import "CustomPopViewController.h"
#import "CustomTextField.h"


@interface NewTextViewController :CustomPopViewController
{
    CustomTextField *titleTextField;
    UIView *imgBox;
    UIButton *takePicBtn;
    UIImageView *imageView;
    UITextView *textView;
    UIButton *delBtn;
}
@end
