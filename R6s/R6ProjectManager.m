//
//  R6ProjectManager.m
//  R6s
//
//  Created by Developer Nathan on 2/19/15.
//  Copyright (c) 2015 Nathan Fennel. All rights reserved.
//

#import "R6ProjectManager.h"
#import "R6Raizlabs1ViewController.h"
#import "R6Euler39ViewController.h"
#import "R6Euler45ViewController.h"
#import "R6Euler81ViewController.h"
#import "R6Euler92ViewController.h"
#import "R6Euler97ViewController.h"
#import "R6Euler101ViewController.h"
#import "R6NumberWordLoopViewController.h"

@implementation R6ProjectManager {
    NSArray *_projects;
}

+ (instancetype)sharedProjectManager {
    static R6ProjectManager *sharedProjectManager;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedProjectManager = [[R6ProjectManager alloc] init];
    });
    
    return sharedProjectManager;
}

- (instancetype)init {
    self = [super init];
    
    if (self) {
        _projects = @[@"R6s",
                      @"Euler 39",
                      @"Euler 45",
                      @"Euler 81",
                      @"Euler 92",
                      @"Euler 97",
                      @"Euler 101",
                      @"Word Loop"
                     ];
    }
    
    return self;
}

- (NSArray *)projects {
    return _projects;
}

- (NSString *)projectTitleForIndex:(NSInteger)index {
    if ([_projects count] > index) {
        return [_projects objectAtIndex:index];
    }
    
    return @"";
}

- (UIViewController *)viewControllerForIndex:(NSInteger)index {
    UIViewController *individualProjectView;
    if ([_projects count] > index) {
        switch (index) {
            case 0:
                individualProjectView = [R6Raizlabs1ViewController new];
                break;
                
            case 1:
                individualProjectView = [R6Euler39ViewController new];
                break;
                
            case 2:
                individualProjectView = [R6Euler45ViewController new];
                break;
                
            case 3:
                individualProjectView = [R6Euler81ViewController new];
                break;
                
            case 4:
                individualProjectView = [R6Euler92ViewController new];
                break;
                
            case 5:
                individualProjectView = [R6Euler97ViewController new];
                break;
                
            case 6:
                individualProjectView = [R6Euler101ViewController new];
                break;

            case 7:
                individualProjectView = [R6NumberWordLoopViewController new];
                break;

            default:
                break;
        }
    }
    
    return individualProjectView;
}

@end
