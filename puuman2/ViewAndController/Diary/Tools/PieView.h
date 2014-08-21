//
//  PieView.h
//  PuumanForPhone
//
//  Created by Ra.（祁文龙） on 14-6-20.
//  Copyright (c) 2014年 Declan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PieLayer.h"

@class PieLayer, PieElement,PieLayerDeleagate;
;

@interface PieView : UIView<PieLayerDeleagate>
@property (nonatomic, copy) void(^elemTapped)(PieElement*);
@property (nonatomic,assign) id <PieLayerDeleagate> pieLayerDelegate;
@property (nonatomic, assign) BOOL finishLoad;

@end

@interface PieView (ex)
@property(nonatomic,readonly,retain) PieLayer *layer;
@end
