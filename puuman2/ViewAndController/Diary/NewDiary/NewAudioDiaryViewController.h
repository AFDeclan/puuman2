//
//  NewAudioDiaryViewController.h
//  puuman2
//
//  Created by Ra.（祁文龙） on 14-3-5.
//  Copyright (c) 2014年 AFITC. All rights reserved.
//

#import "CustomPopViewController.h"
#import "CustomTextField.h"
#import "NewAudioRecordView.h"
#import "NewAudioPlayView.h"

@interface NewAudioDiaryViewController : CustomPopViewController<NewAudioRecordDelegate,NewAudioPlayDelegate>
{
    CustomTextField *titleTextField;
    NewAudioRecordView *record;
    NewAudioPlayView *play;
    UILabel *label_start;
    UILabel *label_restart;
    UILabel *label_stop;
    UILabel *label_play;
    UILabel *label_stopPlay;
}
@property (retain, nonatomic) NSDictionary *taskInfo;
@end
