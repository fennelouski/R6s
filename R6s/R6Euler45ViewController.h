//
//  R6Euler45ViewController.h
//  R6s
//
//  Created by Developer Nathan on 2/19/15.
//  Copyright (c) 2015 Nathan Fennel. All rights reserved.
//

#import "R6ViewController.h"

@interface R6Euler45ViewController : R6ViewController

@property (nonatomic, strong) UILabel *answerLabel;
@property (nonatomic, strong) NSMutableDictionary *triangularNumbers, *pentagonalNumbers, *hexagonalNumbers;
@property NSInteger startingNumber, interval, currentLimit;
@property (nonatomic, strong) NSMutableArray *winners;

@end
