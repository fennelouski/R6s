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
                     @"Euler 39"
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
                
            default:
                break;
        }
    }
    
    return individualProjectView;
}

@end
