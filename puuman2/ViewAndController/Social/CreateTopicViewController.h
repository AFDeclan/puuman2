//
//  CreateTopicViewController.h
//  puuman2
//
//  Created by Ra.（祁文龙） on 14-3-20.
//  Copyright (c) 2014年 AFITC. All rights reserved.
//

#import "CustomPopViewController.h"
#import "ColorButton.h"
#import "CustomTextField.h"
#import "Forum.h"

@interface CreateTopicViewController : CustomPopViewController<ForumDelegate>
{
    ColorButton *instructionBtn;
    ColorButton *createBtn;
    CustomTextField *inputTextFied;
    UIImageView *bgTitleImageView;
}

- (void)showKeyBoard;
@end
