//
//  R6Euler97ViewController.m
//  R6s
//
//  Created by HAI on 3/6/16.
//  Copyright © 2016 Nathan Fennel. All rights reserved.
//

/*
 The first known prime found to exceed one million digits was discovered in 1999, and is a Mersenne prime of the form 26972593−1; it contains exactly 2,098,960 digits. Subsequently other Mersenne primes, of the form 2p−1, have been found which contain more digits.
 
 However, in 2004 there was found a massive non-Mersenne prime which contains 2,357,207 digits: 28433×27830457+1.
 
 Find the last ten digits of this prime number.
 
 8739992577
 */

#import "R6Euler97ViewController.h"

static NSInteger const exponent = 7830457;
static NSInteger const coefficient = 28433;

static long long const limit = 10000000000;

@implementation R6Euler97ViewController {
    long long currentValue;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self calculate];
}

- (void)calculate {
    currentValue = 1;
    
    for (int i = 0; i < exponent; i++) {
        currentValue %= limit;
        currentValue *= 2;
    }
    
    currentValue *= coefficient;
    currentValue += 1;
    currentValue %= limit;
    
    NSLog(@"%lld", currentValue);
    
    self.answerLabel.text = [NSString stringWithFormat:@"%lld", currentValue];
}


@end
