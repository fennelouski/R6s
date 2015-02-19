//
//  R6ViewController.m
//  R6s
//
//  Created by Developer Nathan on 2/19/15.
//  Copyright (c) 2015 Nathan Fennel. All rights reserved.
//

#import "R6ViewController.h"

#define kScreenWidth [UIScreen mainScreen].bounds.size.width
#define kStatusBarHeight (([[UIApplication sharedApplication] statusBarFrame].size.height == 20.0f) ? 20.0f : (([[UIApplication sharedApplication] statusBarFrame].size.height == 40.0f) ? 20.0f : 0.0f))
#define kScreenHeight (([[UIApplication sharedApplication] statusBarFrame].size.height > 20.0f) ? [UIScreen mainScreen].bounds.size.height - 20.0f : [UIScreen mainScreen].bounds.size.height)
#define ANIMATION_DURATION 0.35f

@interface R6ViewController ()

@end

@implementation R6ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.view setBackgroundColor:[UIColor whiteColor]];
    [self.view addSubview:self.headerToolbar];
    [self.view addGestureRecognizer:self.swipeRight];
    
    NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
    [nc addObserver:self selector:@selector(updateHeaderToolbar) name:UIApplicationWillChangeStatusBarFrameNotification object:nil];
}

- (void)updateHeaderToolbar {
    [UIView animateWithDuration:ANIMATION_DURATION animations:^{
        [self.headerToolbar setFrame:CGRectMake(0.0f, 0.0f, kScreenWidth, kStatusBarHeight)];
    }];
}

#pragma mark - Subviews

- (UIToolbar *)headerToolbar {
    if (_headerToolbar) {
        _headerToolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0.0f, 0.0f, kScreenWidth, kStatusBarHeight)];
    }
    
    return _headerToolbar;
}

#pragma mark - Gestures

- (UISwipeGestureRecognizer *)swipeRight {
    if (!_swipeRight) {
        _swipeRight = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipedRight)];
        [_swipeRight setDirection:UISwipeGestureRecognizerDirectionRight];
    }
    
    return _swipeRight;
}

#pragma mark - Gesture Actions

- (void)swipedRight {
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

#pragma mark - Memory Warning

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
