//
//  LoginViewController.m
//  MVPExample
//
//  Created by Evgeny Shishko on 01/08/2019.
//  Copyright © 2019 Evgeny Shishko. All rights reserved.
//

#import "LoginViewController.h"
#import "LoginPresenter.h"
#import "AppDelegate.h"
#import "UserDTO.h"

@interface LoginViewController ()

@property (nonatomic, strong) UserDTO               *userDTO;
@property (nonatomic, strong) LoginPresenter        *presenter;
@property (nonatomic, strong) UITextField           *loginField;
@property (nonatomic, strong) UITextField           *passwordField;
@property (nonatomic, strong) UIButton              *signInButton;
@property (nonatomic, strong) NSDictionary          *userInfo;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = UIColor.whiteColor;
    self.navigationController.navigationBar.prefersLargeTitles = YES;
    self.navigationItem.title = @"Github Client";
    
    [self setupLoginField];
    [self setupPasswordField];
    [self setupSignInButton];
    
   // [self fetchJSON];
    
    
    self.presenter = [LoginPresenter new];
    self.presenter.output = self;
    
    [self.presenter loginWithUsername:@"lol" password:@"lol"];
}

#pragma mark - <LoginPresenterOutput>

- (void)authorizationComplete {
    //TODO: например, открытие след экрана
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
    [self.signInButton addTarget:self action:@selector(addLoginAndPasswordInDictionary) forControlEvents:UIControlEventTouchUpInside];

    self.signInButton.translatesAutoresizingMaskIntoConstraints = NO;
    
    [NSLayoutConstraint activateConstraints:@[
                                              [self.signInButton.centerYAnchor constraintEqualToAnchor:self.view.centerYAnchor constant: 90],
                                              [self.signInButton.heightAnchor constraintEqualToConstant:50],
                                              [self.signInButton.centerXAnchor constraintEqualToAnchor:self.view.centerXAnchor],
                                              [self.signInButton.widthAnchor constraintEqualToConstant:150]
                                              ]];
    
}

- (void)addLoginAndPasswordInDictionary {
    
    self.userInfo = [[NSDictionary alloc]
                          initWithObjectsAndKeys:
                          self.loginField.text, @"login",
                          self.passwordField.text, @"password", nil];
    
    for (NSString *key in self.userInfo) {
        id value = self.userInfo[key];
        NSLog(@"%@ for key: %@", value, key);
    }
    
    self.userDTO = [[UserDTO alloc] initWithUserInfo:self.userInfo];
    [self.userDTO authorization];
    
    UIViewController *vc = [[UIViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];

}



@end
