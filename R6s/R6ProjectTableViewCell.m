//
//  R6ProjectTableViewCell.m
//  R6s
//
//  Created by Developer Nathan on 2/19/15.
//  Copyright (c) 2015 Nathan Fennel. All rights reserved.
//

#import "R6ProjectTableViewCell.h"

@implementation R6ProjectTableViewCell

- (void)layoutSubviews {
    [super layoutSubviews];
    
    [self addSubview:self.titleLabel];
    [self.titleLabel setFrame:self.bounds];
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] initWithFrame:self.bounds];
        [_titleLabel setTextAlignment:NSTextAlignmentCenter];
        [_titleLabel setTextColor:[UIColor darkTextColor]];
    }
    
    return _titleLabel;
}

@end
