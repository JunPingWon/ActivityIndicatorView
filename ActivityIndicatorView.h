//
//  ActivityIndicatorView.h
//  ActivityIndicatorView
//
//  Created by JunpingWon on 15/10/30.
//  Copyright (c) 2015年 JunpingWon. All rights reserved.
//

#import <UIKit/UIKit.h>

//声明协议
@protocol ActivityIndicatorViewDelegate;

@interface ActivityIndicatorView : UIView

//圆圈的个数
@property (nonatomic, assign) NSInteger numberOfCircles;
//两个圆之间的间距
@property (nonatomic, assign) CGFloat internalSpacing;
//圆的半径
@property (nonatomic,assign) CGFloat radius;
//两个圆动画的延迟
@property (nonatomic, assign) CGFloat delay;
//两个圆动画的持续时间
@property (nonatomic,assign) CGFloat duration;

//Cocoa Touch框架里大量使用了代理这种设计模式，在每个UI控件类里面都声明了一个类型为id的delegate或是dataSource，查看Cocoa的头文件可以发现很多如下的属性：通常格式为@property(nonatomic, assign)id<protocol_name> delegate;  即这个代理要遵循某一个协议，也就是说只有遵循了这个协议的类对象才具备代理资格。这同时也要求了代理类必须在头文件中声明遵循这个protocol_name协议并实现其中的@required方法，@optional的方法是可选的。

@property (nonatomic,assign) id <ActivityIndicatorViewDelegate>delegate;

- (void)startAnimation;
- (void)stopAnimation;

@end

@protocol ActivityIndicatorViewDelegate <NSObject>

@optional

//获取特定位置圆圈的背景色
- (UIColor *)activityIndicatorView:(ActivityIndicatorView *)activityIndicatorView circleBackgroundColorAtIndex:(NSInteger)index;

@end
