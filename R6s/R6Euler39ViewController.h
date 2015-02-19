//
//  R6Euler39ViewController.h
//  R6s
//
//  Created by Developer Nathan on 2/19/15.
//  Copyright (c) 2015 Nathan Fennel. All rights reserved.
//

#import "R6ViewController.h"

@interface R6Euler39ViewController : R6ViewController

@property (nonatomic, strong) UISlider *pSlider;
@property (nonatomic, strong) UILabel *pLabel;
@property (nonatomic, strong) UILabel *answerLabel;
@property (nonatomic, strong) NSMutableDictionary *resultsDictionary, *referenceDictionary;
@property int p;

@end
