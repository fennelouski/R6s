//
//  R6Euler81ViewController.m
//  R6s
//
//  Created by Developer Nathan on 2/20/15.
//  Copyright (c) 2015 Nathan Fennel. All rights reserved.
//

/*
 In the 5 by 5 matrix below, the minimal path sum from the top left to the bottom right, by only moving to the right and down, is indicated in bold red and is equal to 2427.
 
 ⎛⎝⎜⎜⎜⎜⎜⎜131201630537805673968036997322343427464975241039654221213718150111956331⎞⎠⎟⎟⎟⎟⎟⎟
 Find the minimal path sum, in matrix.txt (right click and "Save Link/Target As..."), a 31K text file containing a 80 by 80 matrix, from the top left to the bottom right by only moving right and down.
 

 */

#import "R6Euler81ViewController.h"

@interface R6Euler81ViewController ()

@end

@implementation R6Euler81ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.grid = [[NSMutableDictionary alloc] init];
    
    [self setupGrid];
}

- (void)setupGrid {
    NSString *path = [[NSBundle mainBundle] pathForResource:@"p081_matrix"
                                                     ofType:@"txt"];
    
    NSString *content = [NSString stringWithContentsOfFile:path
                                                  encoding:NSUTF8StringEncoding
                                                     error:NULL];
    
    self.rows = [NSMutableArray arrayWithArray:[content componentsSeparatedByCharactersInSet:[NSCharacterSet newlineCharacterSet]]];
    
    for (int row = 0; row < self.rows.count; row++) {
        self.rows[row] = [[self.rows objectAtIndex:row] componentsSeparatedByString:@","];
        
        for (int column = 0; column < [self.rows[row] count]; column++) {
            NSString *numberString = [self.rows[row] objectAtIndex:column];
            if ([numberString intValue]) {
                [self.grid setObject:[NSNumber numberWithInt:[numberString intValue]] forKey:[NSString stringWithFormat:@"%dx%d", row, column]];
            }
            
            else {
                NSLog(@"It won't work: \"%@\"", numberString);
            }
        }
    }
    
    NSMutableString *gridString = [[NSMutableString alloc] init];
    for (int row = 0; row < 80; row++) {
        for (int column = 0; column < 80; column++) {
            [gridString appendFormat:@" \"%d\" %@", column, [self.grid objectForKey:[NSString stringWithFormat:@"%dx%d", row, column]]];
        }
        
        [gridString appendString:@"\n"];
    }
    
    
    for (int row = 0; row < [self.rows count]; row++) {
        for (int column = 0; column < [self.rows count]; column++) {
            NSNumber *left = [self.grid objectForKey:[NSString stringWithFormat:@"%dx%d", row, column - 1]];
            NSNumber *top = [self.grid objectForKey:[NSString stringWithFormat:@"%dx%d", row - 1, column]];
            NSNumber *current = [self.grid objectForKey:[NSString stringWithFormat:@"%dx%d", row, column]];
            
            if ([left intValue] && [top intValue] && [current intValue]) {
                if ([left intValue] > [top intValue]) {
                    [self.grid setObject:[NSNumber numberWithInt:[top intValue] + [current intValue]] forKey:[NSString stringWithFormat:@"%dx%d", row, column]];
                }
                
                else {
                    [self.grid setObject:[NSNumber numberWithInt:[left intValue] + [current intValue]] forKey:[NSString stringWithFormat:@"%dx%d", row, column]];
                }
            }
            
            else if ([left intValue] && [current intValue]) {
                [self.grid setObject:[NSNumber numberWithInt:[left intValue] + [current intValue]] forKey:[NSString stringWithFormat:@"%dx%d", row, column]];
            }
            
            else if ([top intValue] && [current intValue]) {
                [self.grid setObject:[NSNumber numberWithInt:[top intValue] + [current intValue]] forKey:[NSString stringWithFormat:@"%dx%d", row, column]];
            }
        }
    }
    
    NSNumber *current = [self.grid objectForKey:[NSString stringWithFormat:@"%dx%d", 79, 79]];
    [self.answerLabel setText:[NSString stringWithFormat:@"%@", current]];
    
    
    [self setupMinimumRows];
}

- (void)setupMinimumRows {
    self.minimumRows = [[NSMutableArray alloc] initWithCapacity:[self.rows count]];
    for (NSArray *array in self.rows) {
        [self.minimumRows addObject:[[NSMutableArray alloc] initWithCapacity:[array count]]];
    }
    
    for (NSString *numberString in [self.rows objectAtIndex:0]) {
        [self.minimumRows addObject:[NSNumber numberWithInt:[numberString intValue]]];
    }
    
    for (int row = 0; row < [self.rows count]; row++) {
        NSArray *sourceRow = [self.rows objectAtIndex:row];
        NSMutableArray *destinationRow = [self.minimumRows objectAtIndex:row];
        [destinationRow setObject:[NSNumber numberWithInt:[[sourceRow objectAtIndex:0] intValue]] atIndexedSubscript:0];
    }
}

- (void)traverseGrid {
    for (int destinationRowIndex = 1, sourceRowIndex = 0; destinationRowIndex < [self.minimumRows count] && sourceRowIndex < [self.rows count]; destinationRowIndex++, sourceRowIndex++) {
        NSArray *sourceRow = [self.rows objectAtIndex:sourceRowIndex];
        NSMutableArray *destinationRow = [self.minimumRows objectAtIndex:destinationRowIndex];
        
        for (int sourceColumnIndex = 0, destinationColumnIndex = 1; sourceColumnIndex < [sourceRow count] && destinationColumnIndex < [destinationRow count]; sourceColumnIndex++, destinationColumnIndex++) {
//            int leftNumber
        }
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
