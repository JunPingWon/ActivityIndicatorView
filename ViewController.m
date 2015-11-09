//
//  ViewController.m
//  ActivityIndicatorView
//
//  Created by JunpingWon on 15/10/30.
//  Copyright (c) 2015年 JunpingWon. All rights reserved.
//

#import "ViewController.h"
#import "ActivityIndicatorView.h"
@interface ViewController ()<ActivityIndicatorViewDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    ActivityIndicatorView *activityIndicatorView = [[ActivityIndicatorView alloc]init];
    //设置代理
    activityIndicatorView.delegate = self;
    //圆的个数
    activityIndicatorView.numberOfCircles = 3;
    //圆的半径
    activityIndicatorView.radius = 20;
    //两个圆之间的间距
    activityIndicatorView.internalSpacing = 3;
    
    activityIndicatorView.center = self.view.center;
    
    [activityIndicatorView startAnimation];
    
    [self.view addSubview:activityIndicatorView];
    
    [NSTimer scheduledTimerWithTimeInterval:7 target:activityIndicatorView selector:@selector(stopAnimation) userInfo:nil repeats:NO];
    [NSTimer scheduledTimerWithTimeInterval:9 target:activityIndicatorView selector:@selector(startAnimation) userInfo:nil repeats:NO];
   
}

#pragma mark -
#pragma mark - MONActivityIndicatorViewDelegate Methods

- (UIColor *)activityIndicatorView:(ActivityIndicatorView *)activityIndicatorView
      circleBackgroundColorAtIndex:(NSInteger)index {
    CGFloat red   = (arc4random() % 256)/255.0;
    CGFloat green = (arc4random() % 256)/255.0;
    CGFloat blue  = (arc4random() % 256)/255.0;
    CGFloat alpha = 1.0f;
    return [UIColor colorWithRed:red green:green blue:blue alpha:alpha];
}


@end
