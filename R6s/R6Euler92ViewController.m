//
//  R6Euler92ViewController.m
//  R6s
//
//  Created by HAI on 3/6/16.
//  Copyright © 2016 Nathan Fennel. All rights reserved.
//

#import "R6Euler92ViewController.h"

static NSInteger const target = 89;

static NSInteger const falseTarget = 1;

static NSInteger const limit = 10000000;

@implementation R6Euler92ViewController {
    NSInteger totalLoopsAt89;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self calculate];
}

- (void)calculate {
    totalLoopsAt89 = 0;
    
    for (int i = 1; i < limit; i++) {
        int squaredDigits = [self squaredDigits:i];
        while (squaredDigits != target && squaredDigits != falseTarget) {
            squaredDigits = [self squaredDigits:squaredDigits];
        }
        
        if (squaredDigits == target) {
            totalLoopsAt89++;
        }
    }
    
    self.answerLabel.text = [NSString stringWithFormat:@"%zd", totalLoopsAt89];
    NSLog(@"%@", self.answerLabel.text);
}

- (int)squaredDigits:(int)input {
    int sum = 0;
    
    int modifiedInput = input;
    
    while (modifiedInput > 0) {
        int lastDigit = modifiedInput%10;
        sum += lastDigit * lastDigit;
        modifiedInput /= 10;
    }
    
    return sum;
}

@end
