//
//  R6ProjectManager.h
//  R6s
//
//  Created by Developer Nathan on 2/19/15.
//  Copyright (c) 2015 Nathan Fennel. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface R6ProjectManager : NSObject

+ (instancetype)sharedProjectManager;
- (NSArray *)projects;
- (NSString *)projectTitleForIndex:(NSInteger)index;
- (UIViewController *)viewControllerForIndex:(NSInteger)index;

@end
