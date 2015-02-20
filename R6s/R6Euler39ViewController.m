//
//  R6Euler39ViewController.m
//  R6s
//
//  Created by Developer Nathan on 2/19/15.
//  Copyright (c) 2015 Nathan Fennel. All rights reserved.
//

/*
 If p is the perimeter of a right angle triangle with integral length sides, {a,b,c}, there are exactly three solutions for p = 120.
 
 {20,48,52}, {24,45,51}, {30,40,50}
 
 For which value of p ≤ 1000, is the number of solutions maximised?
 */

#import "R6Euler39ViewController.h"

#define kScreenWidth [UIScreen mainScreen].bounds.size.width
#define kStatusBarHeight (([[UIApplication sharedApplication] statusBarFrame].size.height == 20.0f) ? 20.0f : (([[UIApplication sharedApplication] statusBarFrame].size.height == 40.0f) ? 20.0f : 0.0f))
#define kScreenHeight (([[UIApplication sharedApplication] statusBarFrame].size.height > 20.0f) ? [UIScreen mainScreen].bounds.size.height - 20.0f : [UIScreen mainScreen].bounds.size.height)
#define ANIMATION_DURATION 0.35f


@interface R6Euler39ViewController ()

@end

@implementation R6Euler39ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.view addSubview:self.pLabel];
    [self.view addSubview:self.pSlider];
    [self.view addSubview:self.answerLabel];
    self.p = self.pSlider.value;
    self.resultsDictionary = [[NSMutableDictionary alloc] init];
    self.referenceDictionary = [[NSMutableDictionary alloc] init];
    
    [self calculate];
    
    NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
    [nc addObserver:self  selector:@selector(updateViews)    name:UIDeviceOrientationDidChangeNotification  object:nil];
    [nc addObserver:self selector:@selector(updateViews) name:UIApplicationWillChangeStatusBarFrameNotification object:nil];
    [self updateViews];
}

- (void)updateViews {
    [UIView animateWithDuration:ANIMATION_DURATION animations:^{
        [self.pSlider setFrame:CGRectMake(20.0f, kScreenHeight / 2.0f, kScreenWidth - 40.0f, kScreenHeight/3.0f)];
        [self.pLabel setFrame:CGRectMake(0.0f, kScreenHeight / 3.0f, kScreenWidth, kScreenHeight/6.0f)];
        [self.headerToolbar setFrame:CGRectMake(0.0f, 0.0f, kScreenWidth, kStatusBarHeight)];
    }];
}

#pragma mark - Subviews

- (UILabel *)pLabel {
    if (!_pLabel) {
        _pLabel = [[UILabel alloc] initWithFrame:CGRectMake(0.0f, kScreenHeight / 3.0f, kScreenWidth, kScreenHeight/6.0f)];
        [_pLabel setTextAlignment:NSTextAlignmentCenter];
        [_pLabel setTextColor:[UIColor darkTextColor]];
    }
    
    return _pLabel;
}

- (UISlider *)pSlider {
    if (!_pSlider) {
        _pSlider = [[UISlider alloc] initWithFrame:CGRectMake(0.0f, kScreenHeight / 2.0f, kScreenWidth, kScreenHeight/4.0f)];
        [_pSlider setMinimumValue:12.0f];
        [_pSlider setMaximumValue:1000.0f];
        [_pSlider setValue:10.0f];
        [_pSlider addTarget:self action:@selector(sliderTouched) forControlEvents:UIControlEventTouchUpInside];
        [_pSlider addTarget:self action:@selector(sliderDragged) forControlEvents:UIControlEventTouchDragInside];
    }
    
    return _pSlider;
}

#pragma mark - Slider Action

- (void)sliderTouched {
    self.p = self.pSlider.value;
    [self.pLabel setText:[NSString stringWithFormat:@"p = %d", self.p]];
    [self calculate];
}

- (void)sliderDragged {
    self.p = self.pSlider.value;
    [self.pLabel setText:[NSString stringWithFormat:@"p = %d", self.p]];
}

#pragma mark - Logic!

- (void)calculate {
    for (int i = 1; i < self.p; i++) {
        NSNumber *currentCheck = [NSNumber numberWithInt:i];
        
        if (![self.resultsDictionary objectForKey:currentCheck]) {
            int numberOfSolutions = 0;
            
            for (int lowerBound = 1; lowerBound * lowerBound * 2 < i*i; lowerBound++) {
                int a = lowerBound;
                for (int b = a + 1; a * a + b * b <= i * i; b++) {
                    if (a*a+b*b == i*i) {
                        int total = a + b + i;
                        NSNumber *key = [NSNumber numberWithInt:total];
                        NSNumber *oldValue = [self.referenceDictionary objectForKey:key];
                        if (!oldValue) {
                            oldValue = [NSNumber numberWithInt:1];
                        }
                        
                        else {
                            oldValue = [NSNumber numberWithInt:[oldValue intValue] + 1];
                        }
                        
                        [self.referenceDictionary setObject:oldValue forKey:key];
                        
                        numberOfSolutions++;
                    }
                }
            }
            
            [self.resultsDictionary setObject:[NSNumber numberWithInt:numberOfSolutions] forKey:currentCheck];
        }
    }
    
    NSNumber *highScore = [NSNumber numberWithInt:0];
    NSNumber *highScoreKey = [NSNumber numberWithInt:0];
    for (NSNumber *key in self.referenceDictionary.allKeys) {
        NSNumber *currentScore = [self.referenceDictionary objectForKey:key];
        
        if ([key intValue] > self.p) {
            
        }
        
        else if ([currentScore intValue] > [highScore intValue]) {
            highScore = currentScore;
            highScoreKey = key;
        }
    }
    
    [self.answerLabel setText:[NSString stringWithFormat:@"%@\t--\t%@", highScoreKey, highScore]];
}

#pragma mark - Memory Warning

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
