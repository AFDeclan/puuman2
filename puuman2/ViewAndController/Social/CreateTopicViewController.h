//
//  CreateTopicViewController.h
//  puuman2
//
//  Created by Ra.（祁文龙） on 14-3-20.
//  Copyright (c) 2014年 AFITC. All rights reserved.
//

#import "CustomPopViewController.h"
#import "AFColorButton.h"
#import "CustomTextField.h"
#import "Forum.h"

@interface CreateTopicViewController : CustomPopViewController<ForumDelegate,UITextFieldDelegate>
{
    AFColorButton *instructionBtn;
    AFColorButton *createBtn;
    CustomTextField *inputTextFied;
    UIImageView *bgTitleImageView;
}

- (void)showKeyBoard;
@end
