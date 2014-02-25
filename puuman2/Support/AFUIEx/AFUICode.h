//
//  AFUICode.h
//  AFUIEx
//
//  Created by Declan on 14-2-25.
//  Copyright (c) 2014年 AFITC. All rights reserved.
//

#ifndef AF_AFUICode_h
#define puuman2_AFUICode_h

#define SetViewLeftUp(view, x, y) view.center = CGPointMake(x+view.frame.size.width/2, y+view.frame.size.height/2)
#define SetViewLeftDown(view, x, y) view.center = CGPointMake(x+view.frame.size.width/2, y-view.frame.size.height/2)
#define SetViewLeftCenter(view, x, y) view.center = CGPointMake(x+view.frame.size.width/2, y)
#define SetViewRightCenter(view, x, y) view.center = CGPointMake(x-view.frame.size.width/2, y)
#define SetViewRightDown(view, x, y) view.center = CGPointMake(x-view.frame.size.width/2, y-view.frame.size.height/2)
#define SetViewCenterUp(view, x, y) view.center = CGPointMake(x, y+view.frame.size.height/2)
#define SetViewWidth(view, width) view.frame = CGRectMake(view.frame.origin.x, view.frame.origin.y, width, view.frame.size.height)
#define SetViewHeight(view, height) view.frame = CGRectMake(view.frame.origin.x, view.frame.origin.y, view.frame.size.width, height)
#define ViewWidth(view) view.frame.size.width
#define ViewHeight(view) view.frame.size.height
#define ViewX(view) view.frame.origin.x
#define ViewY(view) view.frame.origin.y
#define ViewDownY(view) (view.frame.origin.y + view.frame.size.height)
#define ViewRightX(view) (view.frame.origin.x + view.frame.size.width)

#endif
