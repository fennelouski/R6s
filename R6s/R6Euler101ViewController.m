//
//  R6Euler101ViewController.m
//  R6s
//
//  Created by Developer Nathan on 2/20/15.
//  Copyright (c) 2015 Nathan Fennel. All rights reserved.
//

#import "R6Euler101ViewController.h"

@interface R6Euler101ViewController ()

@end

@implementation R6Euler101ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.correctSequence = [[NSMutableArray alloc] init];
    self.derivatives = [[NSMutableDictionary alloc] init];
    [self calculate];
}

#pragma mark - Calculate

- (void)calculate {
    for (int i = 0; i < 20; i++) {
        NSInteger term = [self calculateTerm:i];
        [self.correctSequence addObject:[NSNumber numberWithInteger:term]];
    }
    
    NSMutableArray *zeroethDerivative = [NSMutableArray arrayWithArray:self.correctSequence];
    [self.derivatives setObject:zeroethDerivative forKey:[NSNumber numberWithInteger:0]];
    
    [self calculateDerivatives];
}

- (void)calculateDerivatives {
    for (int i = 0; i <= 10; i++) {
        NSMutableArray *currentDerivative = [self.derivatives objectForKey:[NSNumber numberWithInteger:i]];
//        NSLog(@"%d derivative", i);
        [self.derivatives setObject:[self calculateDerivativesOf:currentDerivative] forKey:[NSNumber numberWithInteger:i + 1]];
    }
    
    NSLog(@"Correct: \n%@", self.correctSequence);
    
    // the trivial sequence is 1 which will have a false negative at the second term which is also the first term
    long sumOfFITs = 1;
    
    for (int iteration = 0; iteration < 12; iteration++) {
        NSMutableString *answerString = [[NSMutableString alloc] init];
        BOOL noFit = YES;
        for (int n = 1; n < iteration + 3 && noFit; n++) {
            NSInteger nextTerm = [self calculateFalseTerm:iteration n:n];
            [answerString appendFormat:@" \t%ld", (long)nextTerm];
            
            if (![self.correctSequence containsObject:[NSNumber numberWithInteger:nextTerm]]) {
                sumOfFITs += nextTerm;
//                NSLog(@"FIT: %ld\t\t\t%d", (long)nextTerm, iteration);
                noFit = NO;
            }
        }
        
//        NSLog(@"%d\t%@", iteration, answerString);
    }
    
    NSLog(@"Winner? %ld", (long)sumOfFITs);
    [self.answerLabel setText:[NSString stringWithFormat:@"%ld", sumOfFITs]];
}

- (NSMutableArray *)calculateDerivativesOf:(NSArray *)inputList {
    NSMutableArray *outputList = [[NSMutableArray alloc] init];
    for (int currentTermIndex = 0, nextTermIndex = 1; nextTermIndex < [inputList count]; currentTermIndex++, nextTermIndex++) {
        NSInteger currentTerm = [[inputList objectAtIndex:currentTermIndex] integerValue];
        NSInteger nextTerm = [[inputList objectAtIndex:nextTermIndex] integerValue];
        NSInteger difference = nextTerm - currentTerm;
//        NSLog(@"%ld \t- %ld \t= \t%ld", (long)nextTerm, (long)currentTerm, (long)difference);
        
        [outputList addObject:[NSNumber numberWithInteger:difference]];
    }
    
//    NSLog(@"output: %@", outputList);
    
    return outputList;
}

- (NSInteger)calculateTerm:(NSInteger)n {
    return (1 - n + [self base:n toPower:2] - [self base:n toPower:3] + [self base:n toPower:4] - [self base:n toPower:5] + [self base:n toPower:6] - [self base:n toPower:7] + [self base:n toPower:8] - [self base:n toPower:9] + [self base:n toPower:10]);
}

- (NSInteger)calculateFalseTerm:(NSInteger)falseTerm n:(NSInteger)n {
    NSInteger answer = 0;
    
    switch (falseTerm) {
        case 0:
            answer = 1;
            break;
            
        case 1:
            answer = 1 +
            (n-1)*682;
            break;
            
        case 2:
            answer = 1 +
            (n-1)*682 +
            (n - 1)*(n - 2)*21461;
            break;
            
        case 3:
            answer = 1 +
            (n-1)*682 +
            (n - 1)*(n - 2)*21461 +
            (n - 1)*(n - 2)*(n - 3)*118008;
            break;
            
        case 4:
            answer = 1 +
            (n-1)*682 +
            (n - 1)*(n - 2)*21461 +
            (n - 1)*(n - 2)*(n - 3)*118008 +
            (n - 1)*(n - 2)*(n - 3)*(n - 4) * 210232;
            break;
            
        case 5:
            answer = 1 +
            (n-1)*682 +
            (n - 1)*(n - 2)*21461 +
            (n - 1)*(n - 2)*(n - 3)*118008 +
            (n - 1)*(n - 2)*(n - 3)*(n - 4) * 210232 +
            (n - 1)*(n - 2)*(n - 3)*(n - 4)*(n - 5)*159060;
            break;
            
        case 6:
            answer = 1 +
            (n-1)*682 +
            (n - 1)*(n - 2)*21461 +
            (n - 1)*(n - 2)*(n - 3)*118008 +
            (n - 1)*(n - 2)*(n - 3)*(n - 4) * 210232 +
            (n - 1)*(n - 2)*(n - 3)*(n - 4)*(n - 5)*159060 +
            (n - 1)*(n - 2)*(n - 3)*(n - 4)*(n - 5)*(n - 6)*42150240/720;
            break;
            
        case 7:
            answer = 1 +
            (n-1)*682 +
            (n - 1)*(n - 2)*21461 +
            (n - 1)*(n - 2)*(n - 3)*118008 +
            (n - 1)*(n - 2)*(n - 3)*(n - 4) * 210232 +
            (n - 1)*(n - 2)*(n - 3)*(n - 4)*(n - 5)*159060 +
            (n - 1)*(n - 2)*(n - 3)*(n - 4)*(n - 5)*(n - 6)*42150240/720 +
            (n - 1)*(n - 2)*(n - 3)*(n - 4)*(n - 5)*(n - 6)*(n - 7)*56271600/5040;
            break;
            
        case 8:
            answer = 1 +
            (n-1)*682 +
            (n - 1)*(n - 2)*21461 +
            (n - 1)*(n - 2)*(n - 3)*118008 +
            (n - 1)*(n - 2)*(n - 3)*(n - 4) * 210232 +
            (n - 1)*(n - 2)*(n - 3)*(n - 4)*(n - 5)*159060 +
            (n - 1)*(n - 2)*(n - 3)*(n - 4)*(n - 5)*(n - 6)*42150240/720 +
            (n - 1)*(n - 2)*(n - 3)*(n - 4)*(n - 5)*(n - 6)*(n - 7)*56271600/5040 +
            (n - 1)*(n - 2)*(n - 3)*(n - 4)*(n - 5)*(n - 6)*(n - 7)*(n-8)*44795520/40320;
            break;
            
        case 9:
            answer = 1 +
            (n-1)*682 +
            (n - 1)*(n - 2)*21461 +
            (n - 1)*(n - 2)*(n - 3)*118008 +
            (n - 1)*(n - 2)*(n - 3)*(n - 4) * 210232 +
            (n - 1)*(n - 2)*(n - 3)*(n - 4)*(n - 5)*159060 +
            (n - 1)*(n - 2)*(n - 3)*(n - 4)*(n - 5)*(n - 6)*42150240/720 +
            (n - 1)*(n - 2)*(n - 3)*(n - 4)*(n - 5)*(n - 6)*(n - 7)*56271600/5040 +
            (n - 1)*(n - 2)*(n - 3)*(n - 4)*(n - 5)*(n - 6)*(n - 7)*(n-8)*44795520/40320 +
            (n - 1)*(n - 2)*(n - 3)*(n - 4)*(n - 5)*(n - 6)*(n - 7)*(n-8)*(n-9)*19595520/362880;
            break;
            
        case 10:
            answer = 1 +
            (n-1)*682 +
            (n - 1)*(n - 2)*21461 +
            (n - 1)*(n - 2)*(n - 3)*118008 +
            (n - 1)*(n - 2)*(n - 3)*(n - 4) * 210232 +
            (n - 1)*(n - 2)*(n - 3)*(n - 4)*(n - 5)*159060 +
            (n - 1)*(n - 2)*(n - 3)*(n - 4)*(n - 5)*(n - 6)*42150240/720 +
            (n - 1)*(n - 2)*(n - 3)*(n - 4)*(n - 5)*(n - 6)*(n - 7)*56271600/5040 +
            (n - 1)*(n - 2)*(n - 3)*(n - 4)*(n - 5)*(n - 6)*(n - 7)*(n-8)*44795520/40320 +
            (n - 1)*(n - 2)*(n - 3)*(n - 4)*(n - 5)*(n - 6)*(n - 7)*(n-8)*(n-9)*19595520/362880 +
            (n - 1)*(n - 2)*(n - 3)*(n - 4)*(n - 5)*(n - 6)*(n - 7)*(n-8)*(n-9)*(n - 10)*3628800/3628800;
            break;
            
        case 11:
            answer = [self calculateTerm:n];
            break;
            
        default:
            break;
    }
    
    return answer;
}

- (NSInteger)coefficient:(NSInteger)n iteration:(NSInteger)iteration {
    NSInteger coefficient = 1;
    int i = (int)iteration;
    do {
        coefficient *= (n - iteration);
        iteration--;
    } while (iteration > 0);
    
    if (i > 3) {
//        NSLog(@"(%d | %d) = %d", (int)n, i, (int)coefficient);
    }
    
    return coefficient;
}

- (NSInteger)base:(NSInteger)base toPower:(NSInteger)power {
    NSInteger answer = 1;
    if (power < 0) {
        return 0;
    }
    
    while (power > 0) {
        answer *= base;
        power--;
    }
    
    return answer;
}

#pragma mark - Memeory Warning

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
