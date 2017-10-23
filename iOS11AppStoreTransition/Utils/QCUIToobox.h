//
//  QCUIToobox.h
//  QingClass
//
//  Created by 0dayZh on 2016/11/15.
//  Copyright © 2016年 qingclass. All rights reserved.
//

#ifndef QCUIToobox_h
#define QCUIToobox_h

/// 通过 storyboard name 直接获得对应 storyboard
#define QCStoryboard(sb) [UIStoryboard storyboardWithName:sb bundle:nil]

/// 获取 storyboard 的初始 view controller
#define QCInitialViewController(sb) [QCStoryboard(sb) instantiateInitialViewController]

/// 通过 vc 的 StoryboardID 和对应 storyboard name 获得 vc 的事例
#define QCViewController(sb, vc)    [QCStoryboard(sb) instantiateViewControllerWithIdentifier:vc]

/// 从 nib 中加载 view
#define QCView(viewNibName) [[[NSBundle mainBundle] loadNibNamed:viewNibName owner:nil options:nil] lastObject]


//获取物理屏幕的尺寸
#define QCScreenHeight  ([UIScreen mainScreen].bounds.size.height)
#define QCScreenWidth   ([UIScreen mainScreen].bounds.size.width)
#define QC_ScreenWidth  ((QCScreenWidth<QCScreenHeight)?QCScreenWidth:QCScreenHeight)
#define QC_ScreenHeight ((QCScreenWidth<QCScreenHeight)?QCScreenHeight:QCScreenWidth)
#define QC_RATE         (QC_ScreenWidth/320.0)
#define QC_RATE_SCALE   (QC_ScreenWidth/375.0)//以ip6为标准 ip5缩小 ip6p放大 zoom
#define QC_RATE_6P      ((QC_ScreenWidth>375.0)?QC_ScreenWidth/375.0:1.0)//只有6p会放大


//颜色
#define QCMakeColor(r,g,b,a) ([UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a])
#define QCMakeColorRGB(hex)  ([UIColor colorWithRed:((hex>>16)&0xff)/255.0 green:((hex>>8)&0xff)/255.0 blue:(hex&0xff)/255.0 alpha:1.0])
#define QCMakeColorRGBA(hex,a) ([UIColor colorWithRed:((hex>>16)&0xff)/255.0 green:((hex>>8)&0xff)/255.0 blue:(hex&0xff)/255.0 alpha:a])
#define QCMakeColorARGB(hex) ([UIColor colorWithRed:((hex>>16)&0xff)/255.0 green:((hex>>8)&0xff)/255.0 blue:(hex&0xff)/255.0 alpha:((hex>>24)&0xff)/255.0])


#ifdef DEBUG
#   define QCLog(...) NSLog(__VA_ARGS__)
#   define QCLogMethod() QCLog(@"[%@(%p) %@] invoked", NSStringFromClass([self class]), self, NSStringFromSelector(_cmd))
#else
#   define QCLog(...) (void)0
#   define QCLogMethod()    (void)0
#endif  // #ifdef DEBUG

#endif /* QCUIToobox_h */
