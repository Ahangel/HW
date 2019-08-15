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
#import "GHCUserProfileViewController.h"

@interface GHCLoginViewController ()

@property (nonatomic, strong) GHCLoginPresenter         *presenter;
@property (nonatomic, strong) UITextField               *loginField;
@property (nonatomic, strong) UITextField               *passwordField;
@property (nonatomic, strong) UIButton                  *signInButton;
@property (nonatomic, strong) UILabel                   *loginLabel;
@property (nonatomic, strong) UILabel                   *passwordLabel;
@property (nonatomic, strong) UIImageView               *gitImageView;

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
    
    GHCUserProfileViewController *searchVC = [GHCUserProfileViewController new];
    [self.navigationController pushViewController:searchVC animated:YES];
}

- (void)signInButtonTapped {
    
    [self.presenter loginWithUserName:self.loginField.text password:self.passwordField.text];
}

- (void)setupViews {
    [self setupLoginField];
    [self setupPasswordField];
    [self setupSignInButton];
    [self setupLoginLabel];
    [self setupPasswordLabel];
    [self setupGitImageView];
}

#pragma mark - Setup profileImage

- (void)setupGitImageView {
    self.gitImageView = [UIImageView new];
    [self.view addSubview:self.gitImageView];
    [self.gitImageView setImage:[UIImage imageNamed:@"github-logo"]];
    [self.gitImageView setTranslatesAutoresizingMaskIntoConstraints:NO];
    
    [NSLayoutConstraint activateConstraints:@[
                                              [self.gitImageView.centerXAnchor constraintEqualToAnchor:self.view.centerXAnchor],
                                              [self.gitImageView.centerYAnchor constraintEqualToAnchor:self.view.centerYAnchor constant:-210],
                                              [self.gitImageView.heightAnchor constraintEqualToConstant:180],
                                              [self.gitImageView.widthAnchor constraintEqualToConstant:270]
                                              ]];
    
}

#pragma mark - Setup TextFields

- (void)setupLoginField {
    
    self.loginField = [UITextField new];
    [self.view addSubview:self.loginField];
    self.loginField.textAlignment = NSTextAlignmentCenter;
    self.loginField.borderStyle = UITextBorderStyleRoundedRect;
    [self.loginField setBackgroundColor:[UIColor clearColor]];
    self.loginField.translatesAutoresizingMaskIntoConstraints = NO;
    
    [NSLayoutConstraint activateConstraints:@[
                                              [self.loginField.centerYAnchor    constraintEqualToAnchor:self.view.centerYAnchor constant: -20],
                                              [self.loginField.heightAnchor     constraintEqualToConstant:50.0f],
                                              [self.loginField.centerXAnchor    constraintEqualToAnchor:self.view.centerXAnchor],
                                              [self.loginField.widthAnchor      constraintEqualToConstant:200.0f]
                                              ]];
}

- (void)setupPasswordField {
    
    self.passwordField = [UITextField new];
    [self.view addSubview:self.passwordField];
    self.passwordField.backgroundColor = UIColor.clearColor;
    self.passwordField.textAlignment = NSTextAlignmentCenter;
    self.passwordField.borderStyle = UITextBorderStyleRoundedRect;
    self.passwordField.secureTextEntry = YES;
    
    self.passwordField.translatesAutoresizingMaskIntoConstraints = NO;
    
    [NSLayoutConstraint activateConstraints:@[
                                              [self.passwordField.centerYAnchor constraintEqualToAnchor:self.view.centerYAnchor constant:70],
                                              [self.passwordField.heightAnchor  constraintEqualToConstant:50],
                                              [self.passwordField.centerXAnchor constraintEqualToAnchor:self.view.centerXAnchor],
                                              [self.passwordField.widthAnchor   constraintEqualToConstant:200]
                                              ]];
}

#pragma mark - Setup Labels

- (void)setupLoginLabel {
    self.loginLabel = [UILabel new];
    [self.view addSubview:self.loginLabel];
    self.loginLabel.backgroundColor = UIColor.clearColor;
    self.loginLabel.textAlignment = NSTextAlignmentLeft;
    self.loginLabel.text = @"Login:";
    
    [self.loginLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
    
    [NSLayoutConstraint activateConstraints:@[
                                              [self.loginLabel.centerXAnchor    constraintEqualToAnchor:self.view.centerXAnchor],
                                              [self.loginLabel.bottomAnchor     constraintEqualToAnchor:self.loginField.topAnchor],
                                              [self.loginLabel.heightAnchor     constraintEqualToConstant:30],
                                              [self.loginLabel.widthAnchor      constraintEqualToConstant:200]
                                              ]];
    
}

- (void)setupPasswordLabel {
    self.passwordLabel = [UILabel new];
    [self.view addSubview:self.passwordLabel];
    self.passwordLabel.backgroundColor = UIColor.clearColor;
    self.passwordLabel.textAlignment = NSTextAlignmentLeft;
    self.passwordLabel.text = @"Password:";
    
    [self.passwordLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
    
    [NSLayoutConstraint activateConstraints:@[
                                              [self.passwordLabel.centerXAnchor constraintEqualToAnchor:self.view.centerXAnchor],
                                              [self.passwordLabel.bottomAnchor  constraintEqualToAnchor:self.passwordField.topAnchor],
                                              [self.passwordLabel.heightAnchor  constraintEqualToConstant:30],
                                              [self.passwordLabel.widthAnchor   constraintEqualToConstant:200]
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
                                              [self.signInButton.centerYAnchor constraintEqualToAnchor:self.view.centerYAnchor constant: 140],
                                              [self.signInButton.heightAnchor constraintEqualToConstant:50],
                                              [self.signInButton.centerXAnchor constraintEqualToAnchor:self.view.centerXAnchor],
                                              [self.signInButton.widthAnchor constraintEqualToConstant:150]
                                              ]];
    
}




@end
