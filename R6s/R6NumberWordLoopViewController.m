//
//  R6NumberWordLoopViewController.m
//  R6s
//
//  Created by Nathan Fennel on 9/14/16.
//  Copyright © 2016 Nathan Fennel. All rights reserved.
//

#import "R6NumberWordLoopViewController.h"

@interface R6NumberWordLoopViewController () <UITextFieldDelegate>

@property (nonatomic, strong) NSNumberFormatter *numberFormatter;

@property (nonatomic, strong) UITextField *textField;

@property (nonatomic, strong) NSCharacterSet *notDigits, *notLetters;

@property (nonatomic, strong) NSMutableDictionary *answers, *loopLengths;

@end

@implementation R6NumberWordLoopViewController {
    BOOL _updateText;
    NSRange _longestLoop;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    [self.view addSubview:self.textField];
    self.answerLabel.numberOfLines = 0;

    for (NSInteger i = 0; i < 100; i++) {
        [self processText:[NSString stringWithFormat:@"%zd", i]];
    }

    _updateText = YES;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];

    [self.textField becomeFirstResponder];
}

- (UITextField *)textField {
    if (!_textField) {
        _textField = [[UITextField alloc] initWithFrame:CGRectMake(0.0f, self.view.bounds.size.height * 0.6f - 44.0f, self.view.bounds.size.width, 44.0f)];
        _textField.textAlignment = NSTextAlignmentCenter;
        _textField.keyboardType = UIKeyboardTypeNumberPad;
        _textField.delegate = self;
    }

    return _textField;
}

- (NSNumberFormatter *)numberFormatter {
    if (!_numberFormatter) {
        _numberFormatter = [NSNumberFormatter new];
        _numberFormatter.numberStyle = NSNumberFormatterSpellOutStyle;
    }

    return _numberFormatter;
}

- (NSCharacterSet *)notDigits {
    if (!_notDigits) {
        _notDigits = [[NSCharacterSet decimalDigitCharacterSet] invertedSet];
    }

    return _notDigits;
}

- (NSCharacterSet *)notLetters {
    if (!_notLetters) {
        _notLetters = [[NSCharacterSet letterCharacterSet] invertedSet];
    }

    return _notLetters;
}

- (NSMutableDictionary *)answers {
    if (!_answers) {
        _answers = NSMutableDictionary.new;
    }

    return _answers;
}

- (NSMutableDictionary *)loopLengths {
    if (!_loopLengths) {
        _loopLengths = NSMutableDictionary.new;
    }

    return _loopLengths;
}



#pragma mark - Text Field Delegate

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    if ([textField isEqual:self.textField]) {
        if ([string rangeOfCharacterFromSet:self.notDigits].location != NSNotFound) {
            return NO;
        } else {
            [self performSelector:@selector(processText)
                       withObject:nil
                       afterDelay:0.01f];
        }
    }

    return YES;
}

- (void)processText {
    [self processText:self.textField.text];
}

- (void)processText:(NSString *)text {
    NSString *input = text;

    if (text.length == 0) {
        input = @"0";
    }

    NSMutableString *output = NSMutableString.new;


    NSInteger nextValue = [input integerValue];

    NSInteger value = nextValue + 1;

    NSString *foundAnswer = self.answers[@(nextValue)];

    NSUInteger loopLength = 0;

    while (value != nextValue && !foundAnswer) {

        loopLength++;

        value = nextValue;
        input = [self.numberFormatter stringFromNumber:@(value)];
        nextValue = [[input componentsSeparatedByCharactersInSet:self.notLetters] componentsJoinedByString:@""].length;

        foundAnswer = self.answers[@(nextValue)];

        [output appendFormat:@"%@ %zd -> ", input, value];
    }

    NSString *modifiedAnswer;
    if (foundAnswer) {
        [output appendString:foundAnswer];
        modifiedAnswer = output;

        NSNumber *foundLoopLength = [self.loopLengths objectForKey:@(nextValue)];
        loopLength += foundLoopLength.integerValue;
    } else {
        modifiedAnswer = [output substringToIndex:output.length - 4];
    }

    if (loopLength > _longestLoop.length) {
        _longestLoop.location = text.integerValue;
        _longestLoop.length = loopLength;
        NSLog(@"%zd, \t%zd", _longestLoop.location, _longestLoop.length);
    }

    self.loopLengths[@(text.integerValue)] = @(loopLength);

    [self.answers setObject:modifiedAnswer
                     forKey:@(text.integerValue)];

    if (_updateText) {
        self.answerLabel.text = modifiedAnswer;
    }
}



#pragma mark - Memory Warning

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
