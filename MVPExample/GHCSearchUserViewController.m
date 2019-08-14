//
//  SearchUserViewController.m
//  MVPExample
//
//  Created by OUT-Grigorov-KI on 06/08/2019.
//  Copyright © 2019 Evgeny Shishko. All rights reserved.
//

#import "GHCSearchUserViewController.h"
#import "GHCUserDTO.h"
#import "GHCSearchUserPresenterOutput.h"
#import "GHCSearchUserPresenter.h"
#import "GHCUserInfoTableViewController.h"

@interface GHCSearchUserViewController ()

@property (nonatomic, strong) GHCSearchUserPresenter   *presenter;
@property (nonatomic, strong) UILabel               *userNameLabel;
@property (nonatomic, strong) UITextField           *nameField;
@property (nonatomic, strong) UIButton              *showUserButton;

@end

@implementation GHCSearchUserViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupViews];
    self.view.backgroundColor = UIColor.whiteColor;
    self.presenter = [GHCSearchUserPresenter new];
    self.presenter.output = self;
}

- (void)searchUserButtonTapped {
    
    [self.presenter searchUserWithName:self.nameField.text];
}

- (void)showErrorWith:(NSString *)title message:(NSString *)message {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title
                                                                   message:message
                                                            preferredStyle:UIAlertControllerStyleAlert];
    __weak typeof(self) weakSelf = self;
    [alert addAction:[UIAlertAction actionWithTitle:@"OK"
                                              style:UIAlertActionStyleDefault
                                            handler:^(UIAlertAction * _Nonnull action) {
                                                __strong typeof(self) strongSelf = weakSelf;
                                                strongSelf.nameField.text = @"";
    }]];
    [self presentViewController:alert animated:YES completion:nil];
}

- (void)searchIsComplete:(GHCUserDTO *)model {
    
    GHCUserInfoTableViewController *userInfoTableVC = [[GHCUserInfoTableViewController alloc] initWithUserName:model.userName userRepo:model.repos];
    [self.navigationController pushViewController:userInfoTableVC animated:YES];
}

#pragma mark - Setup Views

- (void)setupViews {
    [self setupUserNameLabel];
    [self setupNameField];
    [self setupButton];
}

- (void)setupUserNameLabel {
    
    self.userNameLabel = [UILabel new];
    [self.view addSubview:self.userNameLabel];
    self.userNameLabel.text = @"User Name";
    self.userNameLabel.textAlignment = NSTextAlignmentCenter;
    self.userNameLabel.translatesAutoresizingMaskIntoConstraints = NO;
    
    [NSLayoutConstraint activateConstraints:@[
                                              [self.userNameLabel.centerXAnchor constraintEqualToAnchor:self.view.centerXAnchor],
                                              [self.userNameLabel.centerYAnchor constraintEqualToAnchor:self.view.centerYAnchor constant:-90],
                                              [self.userNameLabel.heightAnchor constraintEqualToConstant:50],
                                              [self.userNameLabel.widthAnchor constraintEqualToConstant:200]
                                              ]];
    
}

- (void)setupNameField {
    
    self.nameField = [UITextField new];
    [self.view addSubview:self.nameField];
    self.nameField.backgroundColor = UIColor.clearColor;
    self.nameField.placeholder = @"Print here";
    self.nameField.textAlignment = NSTextAlignmentCenter;
    self.nameField.borderStyle = UITextBorderStyleRoundedRect;
    
    self.nameField.translatesAutoresizingMaskIntoConstraints = NO;
    
    [NSLayoutConstraint activateConstraints:@[
                                              [self.nameField.centerXAnchor constraintEqualToAnchor:self.view.centerXAnchor],
                                              [self.nameField.centerYAnchor constraintEqualToAnchor:self.view.centerYAnchor],
                                              [self.nameField.heightAnchor constraintEqualToConstant:50],
                                              [self.nameField.widthAnchor constraintEqualToConstant:200]
                                              ]];
    
    
    
}

- (void)setupButton {
    
    self.showUserButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [self.view addSubview:self.showUserButton];
    
    [self.showUserButton setTitle:@"Let's find this user!" forState:UIControlStateNormal];
    [self.showUserButton addTarget:self action:@selector(searchUserButtonTapped) forControlEvents:UIControlEventTouchUpInside];
    
    self.showUserButton.translatesAutoresizingMaskIntoConstraints = NO;
    
    [NSLayoutConstraint activateConstraints:@[
                                              [self.showUserButton.centerXAnchor constraintEqualToAnchor:self.view.centerXAnchor],
                                              [self.showUserButton.centerYAnchor constraintEqualToAnchor:self.view.centerYAnchor constant:90],
                                              [self.showUserButton.heightAnchor constraintEqualToConstant:50],
                                              [self.showUserButton.widthAnchor constraintEqualToConstant:150]
                                              ]];
    
}

@end
