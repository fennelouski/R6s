//
//  R6Raizlabs1ViewController.m
//  R6s
//
//  Created by Developer Nathan on 2/19/15.
//  Copyright (c) 2015 Nathan Fennel. All rights reserved.
//

#import "R6Raizlabs1ViewController.h"
#import "NSCharacterSet+AppFunctions.h"

#define kScreenWidth [UIScreen mainScreen].bounds.size.width
#define kStatusBarHeight (([[UIApplication sharedApplication] statusBarFrame].size.height == 20.0f) ? 20.0f : (([[UIApplication sharedApplication] statusBarFrame].size.height == 40.0f) ? 20.0f : 0.0f))
#define kScreenHeight (([[UIApplication sharedApplication] statusBarFrame].size.height > 20.0f) ? [UIScreen mainScreen].bounds.size.height - 20.0f : [UIScreen mainScreen].bounds.size.height)
#define AVAILABLE_HEIGHT (kScreenHeight-kStatusBarHeight)
#define TOOLBAR_HEIGHT 44.0f
#define ANIMATION_DURATION 0.35f

#define LAST_STRING_KEY @"lastStringKey"

#define ANIK_ADD_THE_STRING_TO_TEST_HERE @"REPLACE THIS TEXT"
#define LOG_OUTPUT NO

@interface R6Raizlabs1ViewController ()

@end

@implementation R6Raizlabs1ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.tintColor = [UIColor colorWithRed:39.0f/100.0f green:58.0f/100.0f blue:93.0f/100.0f alpha:1.0f];
    [self.view addSubview:self.inputTextView];
    [self.view addSubview:self.outputTextView];
    
    NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
    [nc addObserver:self  selector:@selector(updateViews)    name:UIDeviceOrientationDidChangeNotification  object:nil];
    [nc addObserver:self selector:@selector(updateViews) name:UIApplicationWillChangeStatusBarFrameNotification object:nil];
    [nc addObserver:self selector:@selector(keyboardDidShow:) name:UIKeyboardWillShowNotification object:nil];
    [nc addObserver:self selector:@selector(keyboardDidShow:) name:UIKeyboardDidChangeFrameNotification object:nil];
    [nc addObserver:self selector:@selector(keyboardDidHide:) name:UIKeyboardDidHideNotification object:nil];
    
    [self performSelector:@selector(checkForInstructions) withObject:self afterDelay:0.5f];
}

#pragma mark - Adjusting and Setting up Views

- (void)updateViews {
    [UIView animateWithDuration:ANIMATION_DURATION animations:^{
        [self.inputTextView setFrame:CGRectMake(0.0f, kStatusBarHeight, kScreenWidth, AVAILABLE_HEIGHT/2.0f)];
        [self.outputTextView setFrame:CGRectMake(0.0f, kStatusBarHeight + AVAILABLE_HEIGHT/2.0f, kScreenWidth, AVAILABLE_HEIGHT/2.0f)];
        [self.inputAccessoryView setFrame:CGRectMake(0.0, 0.0f, kScreenWidth, TOOLBAR_HEIGHT)];
        [self.processButton setFrame:self.inputAccessoryView.bounds];
    }];
    
    [self processText];
}

- (void)checkForInstructions {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSDate *lastDateOfInstructions = [defaults objectForKey:@"lastDateOfInstructions"];
    if (!lastDateOfInstructions || (lastDateOfInstructions && abs((int)[lastDateOfInstructions timeIntervalSinceNow]) > 3600)) {
        [self showInstructions];
    }
}

- (void)showInstructions {
    NSString *title = @"Welcome to R6s!";
    NSString *message = [NSString stringWithFormat:@"Add text to the top text view and then press process to take the text in that text view and abbreviate it by replacing the middle of each word with the number of letters that were removed.\n\nReplace the text on line 21 in ViewController.m to programmatically test different strings.\n\nI hope R6s leads to Our Success"];
    
    NSString *deviceType = [[UIDevice currentDevice] model];
    if ([[deviceType lowercaseString] rangeOfString:@"simulator"].location == NSNotFound) {
        deviceType = [[deviceType componentsSeparatedByString:@" "] firstObject];
        
        // making sure there's a name of the device model
        if ([deviceType length] == 0) {
            deviceType = @"device";
        }
        
        message = [NSString stringWithFormat:@"Add text to the top text view and then press process to take the text in that text view and abbreviate it by replacing the middle of each word with the number of letters that were removed. \n\nShake your %@ to clear the text view. Shake again to put the text back.\n\nI hope R6s leads to Our Success", deviceType];
    }
    
    UIAlertController *instructionsAlertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    NSString *actionTitle = @"Thanks!";
    
    UIAlertAction *thanksAction = [UIAlertAction actionWithTitle:actionTitle style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        [defaults setObject:[NSDate date] forKey:@"lastDateOfInstructions"];
    }];
    
    [instructionsAlertController addAction:thanksAction];
    
    [self presentViewController:instructionsAlertController animated:YES completion:^{
        
    }];
}

#pragma mark - Subviews

- (UITextView *)inputTextView {
    if (!_inputTextView) {
        _inputTextView = [[UITextView alloc] initWithFrame:CGRectMake(0.0f, kStatusBarHeight, kScreenWidth, AVAILABLE_HEIGHT/2.0f)];
        [_inputTextView setDelegate:self];
        [_inputTextView setInputAccessoryView:self.inputAccessoryView];
        [_inputTextView setText:@"Watson come here."];
        [_inputTextView setFont:[UIFont systemFontOfSize:16.0f]];
        [_inputTextView setTintColor:self.tintColor];
        
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        NSString *lastString = [defaults objectForKey:LAST_STRING_KEY];
        
        if (![ANIK_ADD_THE_STRING_TO_TEST_HERE isEqualToString:@"REPLACE THIS TEXT"] && [ANIK_ADD_THE_STRING_TO_TEST_HERE length] > 0) {
            [_inputTextView setText:ANIK_ADD_THE_STRING_TO_TEST_HERE];
        }
        
        else if (lastString) {
            [_inputTextView setText:lastString];
        }
    }
    
    return _inputTextView;
}

- (UITextView *)outputTextView {
    if (!_outputTextView) {
        _outputTextView = [[UITextView alloc] initWithFrame:CGRectMake(0.0f, kStatusBarHeight + AVAILABLE_HEIGHT/2.0f, kScreenWidth, AVAILABLE_HEIGHT/2.0f)];
        [_outputTextView setUserInteractionEnabled:NO];
        [_outputTextView setEditable:NO];
        [_outputTextView setFont:[UIFont systemFontOfSize:16.0f]];
        [_outputTextView setBackgroundColor:[UIColor colorWithWhite:0.95f alpha:1.0f]];
        [_outputTextView setTintColor:self.tintColor];
    }
    
    return _outputTextView;
}

- (UIToolbar *)inputAccessoryView {
    if (!_inputAccessoryView) {
        _inputAccessoryView = [[UIToolbar alloc] initWithFrame:CGRectMake(0.0, 0.0f, kScreenWidth, TOOLBAR_HEIGHT)];
        [_inputAccessoryView addSubview:self.processButton];
        [_inputAccessoryView setTintColor:self.tintColor];
    }
    
    return _inputAccessoryView;
}

- (UIButton *)processButton {
    if (!_processButton) {
        _processButton = [[UIButton alloc] initWithFrame:self.inputAccessoryView.bounds];
        [_processButton setTitle:@"Process Text" forState:UIControlStateNormal];
        [_processButton setTitleColor:self.tintColor forState:UIControlStateNormal];
        [_processButton addTarget:self action:@selector(processButtonTouched:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _processButton;
}

#pragma mark - Character Set

- (NSCharacterSet *)validCharacters {
    if (!_validCharacters) {
        NSString *charactersToIncludeAsValid = @"0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz";
        _validCharacters = [NSMutableCharacterSet characterSetWithCharactersInString:charactersToIncludeAsValid];
        
        // extra character sets that would unnecessarily increase the size of the character set
        //        [validCharacters formUnionWithCharacterSet:[NSCharacterSet decimalDigitCharacterSet]];
        //        [validCharacters formUnionWithCharacterSet:[NSCharacterSet letterCharacterSet]];
        //        [validCharacters formUnionWithCharacterSet:[NSCharacterSet alphanumericCharacterSet]];
        
        NSString *charactersToExcludeAsInvalid = @"?!/\\"; // just precautionary
        [_validCharacters removeCharactersInString:charactersToExcludeAsInvalid];
        //        [_validCharacters logCharacterSet]; // this logs out the characters that are considered valid
    }
    
    return _validCharacters;
}

#pragma mark - Button Actions

- (void)processButtonTouched:(UIButton *)button {
    [self.inputTextView resignFirstResponder]; // when the inputTextView ends editing, the text is processed
}

#pragma mark - Text VIEW delegate Methods

- (BOOL)textViewShouldBeginEditing:(UITextView *)textView {
    if ([textView isEqual:self.inputTextView]) {
        // hide the output while editing the input
        [UIView animateWithDuration:ANIMATION_DURATION animations:^{
            [self.outputTextView setAlpha:0.0f];
        }];
        return YES;
    }
    
    else if ([textView isEqual:self.outputTextView]) {
        return NO;
    }
    
    return YES;
}

- (BOOL)textViewShouldEndEditing:(UITextView *)textView {
    if ([textView isEqual:self.inputTextView]) {
        // show the output after editing the input
        [UIView animateWithDuration:ANIMATION_DURATION animations:^{
            [self.outputTextView setAlpha:1.0f];
        } completion:^(BOOL finished){
            NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
            [defaults setObject:self.inputTextView.text forKey:LAST_STRING_KEY];
        }];
        
        [self processText];
    }
    
    else if ([textView isEqual:self.outputTextView]) {
        NSLog(@"Something went wrong, the outputTextView should never be able to be edited");
        return YES;
    }
    
    return YES;
}

#pragma mark - String Processing

- (void)processText {
    [self.outputTextView setText:[self replaceMiddleCharacters:self.inputTextView.text]];
    
    if (self.outputTextView.text.length == 0) {
        [self.outputTextView setText:@"No text to process"];
        [self.outputTextView setTextColor:[UIColor grayColor]];
    }
    
    else {
        [self.outputTextView setTextColor:[UIColor darkTextColor]];
        
        if (LOG_OUTPUT) {
            NSLog(@"\n\nInput:\t%@\nOutput:\t%@", self.inputTextView.text, self.outputTextView.text);
        }
    }
}

- (NSString *)replaceMiddleCharacters:(NSString *)input {
    NSArray *words = [input componentsSeparatedByString:@" "];
    
    if ([words count] == 0) {
        return input;
    }
    
    NSMutableArray *processedWords = [NSMutableArray arrayWithCapacity:[words count]];
    
    for (int i = 0; i < [words count]; i++) {
        NSString *word = [words objectAtIndex:i];
        
        if ([word length] > 2) {
            NSMutableString *newWord = [[NSMutableString alloc] init];
            
            BOOL foundValidCharacter = NO;
            char lastCharacter;
            int characterCount = 0;
            
            for (int j = 0; j < [word length]; j++) {
                char currentCharacter = [word characterAtIndex:j];
                
                // last character
                if (j + 1 >= [word length]) {
                    if (characterCount > 0) {
                        [newWord appendFormat:@"%d%c", characterCount, currentCharacter];
                    }
                    
                    else {
                        [newWord appendFormat:@"%c", currentCharacter];
                    }
                    
                    // just in case...reset here
                    foundValidCharacter = NO;
                    characterCount = 0;
                }
                
                // not the last character
                else {
                    char nextCharacter = [word characterAtIndex:j+1];
                    
                    // current character and next character are valid, so we're in the middle of a word
                    if ([self.validCharacters characterIsMember:currentCharacter] &&
                        [self.validCharacters characterIsMember:nextCharacter]) {
                        if (foundValidCharacter) {
                            characterCount++;
                        }
                        
                        else {
                            [newWord appendFormat:@"%c", currentCharacter];
                            foundValidCharacter = YES;
                        }
                        
                        lastCharacter = currentCharacter;
                    }
                    
                    // last valid character in a string
                    // restart the counting over again
                    else if ([self.validCharacters characterIsMember:currentCharacter]) {
                        if (characterCount > 0) {
                            [newWord appendFormat:@"%d%c", characterCount, currentCharacter];
                        }
                        
                        else {
                            [newWord appendFormat:@"%c", currentCharacter];
                        }
                        
                        characterCount = 0;
                        foundValidCharacter = NO;
                    }
                    
                    // current character is not valid but the next character is
                    else if ([self.validCharacters characterIsMember:nextCharacter]) {
                        [newWord appendFormat:@"%c", currentCharacter];
                    }
                    
                    // neither the next character nor the current character are valid, so don't do anything with it
                    else {
                        [newWord appendFormat:@"%c", currentCharacter];
                    }
                }
            }
            
            [processedWords addObject:newWord];
        }
        
        // the word is too short to do anything with it
        else {
            [processedWords addObject:word];
        }
    }
    
    NSMutableString *output = [NSMutableString stringWithString:[processedWords firstObject]];
    // start with the second word and add a space before each new word
    for (int i = 1; i < [processedWords count]; i++) {
        NSString *word = [processedWords objectAtIndex:i];
        [output appendFormat:@" %@", word];
    }
    
    return output;
}

#pragma mark - Keyboard Notification Methods

- (void)keyboardDidShow:(NSNotification *)notification {
    self.keyboardHeight = [[[notification userInfo] objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue].size.height;
    
    [self updateViews];
}

- (void)keyboardDidHide:(NSNotification *)notification {
    self.keyboardHeight = 0.0f;
    
    [self updateViews];
}

#pragma mark Motion Gesture Methods

- (BOOL)canBecomeFirstResponder {
    return YES;
}

- (void)motionBegan:(UIEventSubtype)motion withEvent:(UIEvent *)event {
    if (motion == UIEventSubtypeMotionShake ) {
        if ([self.inputTextView.text length] > 0) {
            self.lastText = self.inputTextView.text;
            self.inputTextView.text = @"";
        }
        
        else {
            [self.inputTextView setText:self.lastText];
        }
        
        [self updateViews];
    }
}

#pragma mark - Memory Warning

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
