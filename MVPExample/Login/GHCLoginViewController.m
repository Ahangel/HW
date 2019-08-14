//
//  LoginViewController.m
//  MVPExample
//
//  Created by Evgeny Shishko on 01/08/2019.
//  Copyright © 2019 Evgeny Shishko. All rights reserved.
//

#import "GHCLoginViewController.h"
#import "GHCLoginPresenter.h"
#import "AppDelegate.h"
#import "GHCUserDTO.h"
#import "GHCSearchUserViewController.h"

@interface GHCLoginViewController ()

@property (nonatomic, strong) GHCLoginPresenter         *presenter;
@property (nonatomic, strong) UITextField               *loginField;
@property (nonatomic, strong) UITextField               *passwordField;
@property (nonatomic, strong) UIButton                  *signInButton;

@end

@implementation GHCLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupViews];
    
    self.view.backgroundColor = UIColor.whiteColor;
    self.navigationItem.title = @"GitHub Client";
    
    self.presenter = [GHCLoginPresenter new];
    self.presenter.output = self;
}

- (void)setupViews {
    [self setupLoginField];
    [self setupPasswordField];
    [self setupSignInButton];
}

#pragma mark - <LoginPresenterOutput>

- (void)authorizationComplete {

    [self showSearchUserViewController];
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
        strongSelf.loginField.text = @"";
        strongSelf.passwordField.text = @"";
    }]];
    [self presentViewController:alert animated:YES completion:nil];
}

- (void)showSearchUserViewController {
    
    GHCSearchUserViewController *searchVC = [GHCSearchUserViewController new];
    [self.navigationController pushViewController:searchVC animated:YES];
}

- (void)signInButtonTapped {
    
    [self.presenter loginWithUserName:self.loginField.text password:self.passwordField.text];
}

#pragma mark - Setup TextFields

- (void)setupLoginField {
    
    self.loginField = [UITextField new];
    [self.view addSubview:self.loginField];
    self.loginField.placeholder = @"Login";
    self.loginField.textAlignment = NSTextAlignmentCenter;
    self.loginField.borderStyle = UITextBorderStyleRoundedRect;
    [self.loginField setBackgroundColor:[UIColor clearColor]];
    self.loginField.translatesAutoresizingMaskIntoConstraints = NO;
    
    [NSLayoutConstraint activateConstraints:@[
                                              [self.loginField.centerYAnchor constraintEqualToAnchor:self.view.centerYAnchor constant: -90],
                                              [self.loginField.heightAnchor constraintEqualToConstant:50.0f],
                                              [self.loginField.centerXAnchor constraintEqualToAnchor:self.view.centerXAnchor],
                                              [self.loginField.widthAnchor constraintEqualToConstant:200.0f]
                                              ]];
}

- (void)setupPasswordField {
    
    self.passwordField = [UITextField new];
    [self.view addSubview:self.passwordField];
    self.passwordField.backgroundColor = UIColor.clearColor;
    self.passwordField.placeholder = @"Password";
    self.passwordField.textAlignment = NSTextAlignmentCenter;
    self.passwordField.borderStyle = UITextBorderStyleRoundedRect;
    self.passwordField.secureTextEntry = YES;
    
    self.passwordField.translatesAutoresizingMaskIntoConstraints = NO;
    
    [NSLayoutConstraint activateConstraints:@[
                                              [self.passwordField.centerYAnchor constraintEqualToAnchor:self.view.centerYAnchor ],
                                              [self.passwordField.heightAnchor constraintEqualToConstant:50],
                                              [self.passwordField.centerXAnchor constraintEqualToAnchor:self.view.centerXAnchor],
                                              [self.passwordField.widthAnchor constraintEqualToConstant:200]
                                              ]];
}

#pragma mark - Setup Button and Action

- (void)setupSignInButton {
    
    self.signInButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [self.view addSubview:self.signInButton];
    [self.signInButton setTitle:@"Sign in" forState:UIControlStateNormal];
    [self.signInButton addTarget:self action:@selector(signInButtonTapped) forControlEvents:UIControlEventTouchUpInside];
    
    self.signInButton.translatesAutoresizingMaskIntoConstraints = NO;
    
    [NSLayoutConstraint activateConstraints:@[
                                              [self.signInButton.centerYAnchor constraintEqualToAnchor:self.view.centerYAnchor constant: 90],
                                              [self.signInButton.heightAnchor constraintEqualToConstant:50],
                                              [self.signInButton.centerXAnchor constraintEqualToAnchor:self.view.centerXAnchor],
                                              [self.signInButton.widthAnchor constraintEqualToConstant:150]
                                              ]];
    
}




@end
