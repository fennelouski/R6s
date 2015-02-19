//
//  ViewController.m
//  R6s
//
//  Created by Developer Nathan on 2/19/15.
//  Copyright (c) 2015 Nathan Fennel. All rights reserved.
//

#import "ViewController.h"
#import "R6ProjectManager.h"
#import "R6ProjectTableViewCell.h"
#import "NSCharacterSet+AppFunctions.h"

#define kScreenWidth [UIScreen mainScreen].bounds.size.width
#define kStatusBarHeight (([[UIApplication sharedApplication] statusBarFrame].size.height == 20.0f) ? 20.0f : (([[UIApplication sharedApplication] statusBarFrame].size.height == 40.0f) ? 20.0f : 0.0f))
#define kScreenHeight (([[UIApplication sharedApplication] statusBarFrame].size.height > 20.0f) ? [UIScreen mainScreen].bounds.size.height - 20.0f : [UIScreen mainScreen].bounds.size.height)
#define TOOLBAR_HEIGHT 44.0f
#define CELL_HEIGHT 44.0f
#define ProjectTableCellIdentifier @"ProjectTableCellIdentifier"
#define ANIMATION_DURATION 0.35f

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.projectTable];
    [self.view addSubview:self.headerToolbar];
    [self setUpTableView];
    
    NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
    [nc addObserver:self  selector:@selector(updateViews)    name:UIDeviceOrientationDidChangeNotification  object:nil];
    [nc addObserver:self selector:@selector(updateViews) name:UIApplicationWillChangeStatusBarFrameNotification object:nil];
}

- (void)updateViews {
    [UIView animateWithDuration:ANIMATION_DURATION animations:^{
        [self.projectTable setFrame:CGRectMake(0.0, 0.0f, kScreenWidth, kScreenHeight)];
        [self.projectTable setContentInset:UIEdgeInsetsMake(kStatusBarHeight, 0.0f, 0.0f, 0.0f)];
        [self.projectTable setScrollIndicatorInsets:self.projectTable.contentInset];
        [self.headerToolbar setFrame:CGRectMake(0.0f, 0.0f, kScreenWidth, kStatusBarHeight)];
    }];
}

- (void)setUpTableView {
    [self.projectTable setSeparatorStyle:UITableViewCellSeparatorStyleSingleLineEtched];
    [self.projectTable registerClass:[R6ProjectTableViewCell class] forCellReuseIdentifier:ProjectTableCellIdentifier];
}

#pragma mark - Subviews

- (UITableView *)projectTable {
    if (!_projectTable) {
        _projectTable = [[UITableView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, kScreenWidth, kScreenHeight) style:UITableViewStylePlain];
        [_projectTable setDataSource:self];
        [_projectTable setDelegate:self];
    }
    
    return _projectTable;
}

- (UIToolbar *)headerToolbar {
    if (!_headerToolbar) {
        _headerToolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0.0f, 0.0f, kScreenWidth, kStatusBarHeight)];
    }
    
    return _headerToolbar;
}

#pragma mark - Table View Delegate and Data Source Methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    NSInteger numberOfSections = 0;
    
    if ([tableView isEqual:self.projectTable]) {
        numberOfSections = 1;
    }
    
    return numberOfSections;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSInteger numberOfRows = 0;
    
    if ([tableView isEqual:self.projectTable]) {
        switch (section) {
            case 0:
                numberOfRows = [[[R6ProjectManager sharedProjectManager] projects] count];
                break;
                
            default:
                break;
        }
    }
    
    return numberOfRows;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat heightForRow = 0.0f;
    
    if ([tableView isEqual:self.projectTable]) {
        heightForRow = CELL_HEIGHT;
    }
    
    return heightForRow;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    R6ProjectTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ProjectTableCellIdentifier forIndexPath:indexPath];
    
    if (!cell) {
        cell = [[R6ProjectTableViewCell alloc] initWithFrame:CGRectMake(0.0f, 0.0f, kScreenWidth, CELL_HEIGHT)];
    }
    
    if ([tableView isEqual:self.projectTable]) {
        switch ([indexPath section]) {
            case 0:
                [cell.titleLabel setText:[[R6ProjectManager sharedProjectManager] projectTitleForIndex:[indexPath row]]];
                break;
                
            default:
                break;
        }
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([tableView isEqual:self.projectTable]) {
        if ([indexPath section] == 0) {
            UIViewController *projectViewController = [[R6ProjectManager sharedProjectManager] viewControllerForIndex:[indexPath row]];
            [self presentViewController:projectViewController animated:YES completion:^{
                
            }];
        }
    }
}

@end
