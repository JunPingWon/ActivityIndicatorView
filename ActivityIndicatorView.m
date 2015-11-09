//
//  ActivityIndicatorView.m
//  ActivityIndicatorView
//
//  Created by JunpingWon on 15/10/30.
//  Copyright (c) 2015年 JunpingWon. All rights reserved.
//

#import "ActivityIndicatorView.h"

//类目
@interface ActivityIndicatorView ()
//默认的颜色
@property (nonatomic, strong)UIColor *defaultColor;
//表示动画是否开启
@property (nonatomic, assign)BOOL isAnimation;
//设置默认的圆的一些属性
- (void)setupDefaults;
//添加圆
- (void)addCircles;
//移除圆
- (void)removeCircles;
//调整frame
- (void)adjustFrame;
//创建圆并设置半径，颜色和横坐标
- (UIView *)createCircleWithRadius:(CGFloat)radius Color:(UIColor *)color positionX:(CGFloat)x;
//创建动画设置动画的持续时间和两个圆的动画间隔时间
- (CABasicAnimation *)createAnimationWithDuration:(CGFloat)duration delay:(CGFloat)delay;

@end

@implementation ActivityIndicatorView

#pragma mark -Initialization
- (id)init {
    self = [super initWithFrame:CGRectZero];
    if (self) {
        [self setupDefaults];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setupDefaults];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self setupDefaults];
    }
    return self;
}

#pragma mark - Private Methord
- (void)setupDefaults {
//如果是从代码层面开始使用Autolayout,需要对使用的View的translatesAutoresizingMaskIntoConstraints的属性设置为NO.即可开始通过代码添加Constraint,否则View还是会按照以往的autoresizingMask进行计算.而在Interface Builder中勾选了Ues Autolayout,IB生成的控件的translatesAutoresizingMaskIntoConstraints属性都会被默认设置NO.
    self.translatesAutoresizingMaskIntoConstraints = NO;
    self.numberOfCircles = 5;
    self.internalSpacing = 5;
    self.radius = 10;
    self.delay = 0.2;
    self.duration = 0.8;
    self.defaultColor = [UIColor lightGrayColor];
}

- (UIView *)createCircleWithRadius:(CGFloat)radius
                             Color:(UIColor *)color
                         positionX:(CGFloat)x {
    UIView *circle = [[UIView alloc] initWithFrame:CGRectMake(x, 0, radius * 2, radius * 2)];
    circle.backgroundColor = color;
    circle.layer.cornerRadius = radius;
    circle.translatesAutoresizingMaskIntoConstraints = NO;
    return circle;
}

- (CABasicAnimation *)createAnimationWithDuration:(CGFloat)duration delay:(CGFloat)delay {
    
    CABasicAnimation *anim = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    anim.delegate = self;
    anim.fromValue = [NSNumber numberWithFloat:0.0f];
    anim.toValue = [NSNumber numberWithFloat:1.0f];
    anim.autoreverses = YES;
    anim.duration = duration;
    anim.removedOnCompletion = NO;
    anim.beginTime = CACurrentMediaTime() + delay;
    anim.repeatCount = INFINITY;
    anim.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    
    return anim;
    
}

- (void)addCircles {
    for (NSUInteger i = 0; i < self.numberOfCircles; i++) {
        UIColor *color = nil;
        if (self.delegate && [self.delegate respondsToSelector:@selector(activityIndicatorView:circleBackgroundColorAtIndex:)]) {
            color = [self.delegate activityIndicatorView:self circleBackgroundColorAtIndex:i];
        }
        UIView *circle = [self createCircleWithRadius:self.radius Color:(color == nil) ? self.defaultColor : color positionX:(i * ((2 * self.radius) + self.internalSpacing))];
        [circle setTransform:CGAffineTransformMakeScale(0, 0)];
        [circle.layer addAnimation:[self createAnimationWithDuration:self.duration delay:(i * self.delay)] forKey:@"scale"];
        [self addSubview:circle];
    }
}
//移除
- (void)removeCircles {
    
    for (id obj in self.subviews) {
        [obj removeFromSuperview];
    }
}

- (void)adjustFrame {
    
    CGRect frame = self.frame;
    
    frame.size.width = self.numberOfCircles * ((self.radius * 2) + self.internalSpacing) - self.internalSpacing;
    frame.size.height = self.radius * 2;
    
    self.frame = frame;

}

#pragma mark - Public Methord

- (void)startAnimation {
    if (!self.isAnimation) {
        [self addCircles];
        self.hidden = NO;
        self.isAnimation = YES;
    }
}

- (void)stopAnimation {
    if (self.isAnimation) {
        [self removeCircles];
        self.hidden = YES;
        self.isAnimation = NO;
    }
}

#pragma mark - Custom Setter

- (void)setNumberOfCircles:(NSInteger)numberOfCircles {
    _numberOfCircles = numberOfCircles;
    [self adjustFrame];
}

- (void)setRadius:(CGFloat)radius {
    _radius = radius;
    [self adjustFrame];
}

- (void)setInternalSpacing:(CGFloat)internalSpacing {
    _internalSpacing = internalSpacing;
    [self adjustFrame];
}





@end
