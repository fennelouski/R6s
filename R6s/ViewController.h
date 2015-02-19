//
//  ViewController.h
//  R6s
//
//  Created by Developer Nathan on 2/19/15.
//  Copyright (c) 2015 Nathan Fennel. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController <UITextViewDelegate>

@property (nonatomic, strong) UITextView *inputTextView, *outputTextView;
@property (nonatomic, strong) UIToolbar *inputAccessoryView;
@property (nonatomic, strong) UIButton *processButton;
@property (nonatomic, strong) NSMutableCharacterSet *validCharacters;
@property (nonatomic, strong) UIColor *tintColor;
@property (nonatomic, strong) NSString *lastText;
@property float keyboardHeight;

@end

