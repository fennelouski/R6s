//
//  R6Euler45ViewController.m
//  R6s
//
//  Created by Developer Nathan on 2/19/15.
//  Copyright (c) 2015 Nathan Fennel. All rights reserved.
//

#import "R6Euler45ViewController.h"

#define kScreenWidth [UIScreen mainScreen].bounds.size.width
#define kStatusBarHeight (([[UIApplication sharedApplication] statusBarFrame].size.height == 20.0f) ? 20.0f : (([[UIApplication sharedApplication] statusBarFrame].size.height == 40.0f) ? 20.0f : 0.0f))
#define kScreenHeight (([[UIApplication sharedApplication] statusBarFrame].size.height > 20.0f) ? [UIScreen mainScreen].bounds.size.height - 20.0f : [UIScreen mainScreen].bounds.size.height)
#define ANIMATION_DURATION 0.35f

@interface R6Euler45ViewController ()

@end

@implementation R6Euler45ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.answerLabel];
    
    NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
    [nc addObserver:self  selector:@selector(updateViews)    name:UIDeviceOrientationDidChangeNotification  object:nil];
    [nc addObserver:self selector:@selector(updateViews) name:UIApplicationWillChangeStatusBarFrameNotification object:nil];
    [self updateViews];
    
    self.triangularNumbers = [[NSMutableDictionary alloc] init];
    self.pentagonalNumbers = [[NSMutableDictionary alloc] init];
    self.hexagonalNumbers = [[NSMutableDictionary alloc] init];
    self.winners = [[NSMutableArray alloc] init];
    
    self.startingNumber = 0;
    self.interval = 1000;
    self.currentLimit = self.startingNumber + self.interval;
    
    [self calculate];
}

- (void)updateViews {
    [UIView animateWithDuration:ANIMATION_DURATION animations:^{
        [self.answerLabel setFrame:CGRectMake(0.0f, kStatusBarHeight, kScreenWidth, kScreenHeight / 3.0f)];
        [self.headerToolbar setFrame:CGRectMake(0.0f, 0.0f, kScreenWidth, kStatusBarHeight)];
    }];
}

#pragma mark - calculate

- (void)calculate {
    [self findTriangularNumbers];
    [self findPentagonalNumbers];
    [self findHexagonalNumbers];
    
    for (NSNumber *triangle in self.triangularNumbers.allKeys) {
        if ([triangle integerValue] == 1533776805) {
            NSInteger source = [[self.triangularNumbers objectForKey:triangle] integerValue];
            NSLog(@"This is sooooo weird %d %ld %ld", (int)source, (long)[self pentagonalNumber:source], (long)[self hexagonalNumber:source]);
            
            
            if ([self.pentagonalNumbers objectForKey:triangle]) {
                NSLog(@"Sooooooo close");
                
                if ([self.hexagonalNumbers objectForKey:triangle]) {
                    NSLog(@"Winner!");
                }
            }
        }
        
        if ([self.pentagonalNumbers.allKeys containsObject:triangle]) {
            if ([self.hexagonalNumbers.allKeys containsObject:triangle]) {
                NSLog(@"We have a winner! %@", triangle);
                [self.winners addObject:triangle];
                break;
            }
        }
    }
    
    if ([self.winners count] > 0) {
        NSLog(@"%@", self.winners);
        [self.answerLabel setText:[NSString stringWithFormat:@"%@", [self.winners firstObject]]];
    }
}

- (void)findTriangularNumbers {
    for (NSInteger i = 40000; i < 56000; i++) {
        NSNumber *triangle = [NSNumber numberWithInteger:[self triangularNumber:i]];
        [self.triangularNumbers setObject:[NSNumber numberWithInteger:i] forKey:triangle];
    }
    
    NSLog(@"Finished Triangles");
}

- (NSInteger)triangularNumber:(NSInteger)n {
    return (n * (n + 1))/2;
}

- (void)findPentagonalNumbers {
    for (NSInteger i = 30000; i < 33000; i++) {
        NSNumber *pentagon = [NSNumber numberWithInteger:[self pentagonalNumber:i]];
        [self.pentagonalNumbers setObject:[NSNumber numberWithInteger:i] forKey:pentagon];
    }
    
    NSLog(@"Finished Pentagons");
}

- (NSInteger)pentagonalNumber:(NSInteger)n {
    return (n * (3 * n - 1)) / 2;
}

- (void)findHexagonalNumbers {
    for (NSInteger i = 27000; i < 30000; i++) {
        NSNumber *hexagon = [NSNumber numberWithInteger:[self hexagonalNumber:i]];
        [self.hexagonalNumbers setObject:[NSNumber numberWithInteger:i] forKey:hexagon];
    }
    
    NSLog(@"Finished Hexagons");
}

- (NSInteger)hexagonalNumber:(NSInteger)n {
    return n * (2 * n - 1);
}

#pragma mark - Memory Warning

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
