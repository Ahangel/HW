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
#import "GHCUserProfileViewController.h"
#import "GHCSearchViewController.h"

@interface GHCLoginViewController ()

@property (nonatomic, strong) GHCLoginPresenter         *presenter;
@property (nonatomic, strong) UITextField               *loginField;
@property (nonatomic, strong) UITextField               *passwordField;
@property (nonatomic, strong) UIButton                  *signInButton;
@property (nonatomic, strong) UILabel                   *loginLabel;
@property (nonatomic, strong) UILabel                   *passwordLabel;
@property (nonatomic, strong) UIImageView               *gitImageView;
@property (nonatomic, strong) UIStackView               *loginStackView;

@end

@implementation GHCLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupStackView];
    
    self.view.backgroundColor = UIColor.whiteColor;
    self.navigationItem.title = @"GitHub Client";
    
    self.presenter = [GHCLoginPresenter new];
    self.presenter.output = self;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.passwordField.text = @"";
    self.loginField.text = @"";
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self updateAxis:self.traitCollection];
}

- (void)traitCollectionDidChange:(UITraitCollection *)previousTraitCollection {
    [super traitCollectionDidChange:previousTraitCollection];
    [self updateAxis:self.traitCollection];
    
}

- (void)updateAxis:(UITraitCollection *)traitCollection {
    switch (traitCollection.horizontalSizeClass) {
        case UIUserInterfaceSizeClassCompact:
            self.loginStackView.axis = UILayoutConstraintAxisVertical;
            break;
        case UIUserInterfaceSizeClassRegular:
            self.loginStackView.axis = UILayoutConstraintAxisHorizontal;
        default:
            break;
    }
}

- (void)setupStackView {
    
    self.loginStackView = [UIStackView new];
    [self setupViews];
    [self.view addSubview:self.loginStackView];
    
    [self.loginStackView setTranslatesAutoresizingMaskIntoConstraints:NO];
    
    self.loginStackView.axis = UILayoutConstraintAxisVertical;
    self.loginStackView.distribution = UIStackViewDistributionEqualSpacing;
    self.loginStackView.alignment = UIStackViewAlignmentCenter;
    self.loginStackView.spacing = 10;
    
    [NSLayoutConstraint activateConstraints:@[
                                              [self.loginStackView.centerXAnchor constraintEqualToAnchor:self.view.centerXAnchor],
                                              [self.loginStackView.centerYAnchor constraintEqualToAnchor:self.view.centerYAnchor],
                                              ]];
    
}

#pragma mark - <LoginPresenterOutput>

- (void)authorizationComplete:(NSDictionary *)userDict {
    //[[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"LoginStatus"];
    
    GHCUserProfileViewController *userProfileVC = [[GHCUserProfileViewController alloc] initWithDictionary:userDict];
    UIBarButtonItem *exitBarButton = [[UIBarButtonItem alloc] initWithTitle:@"Sign Out"
                                                                      style:UIBarButtonItemStylePlain
                                                                     target:self
                                                                     action:@selector(deleteUserAndShowLoginViewController)];
    userProfileVC.navigationItem.leftBarButtonItem = exitBarButton;
    UIBarButtonItem *searchBarButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSearch
                                                                                   target:self
                                                                                   action:@selector(showSearchUserViewController)];
    userProfileVC.navigationItem.rightBarButtonItem = searchBarButton;
    [self.navigationController pushViewController:userProfileVC animated:YES];
}

- (void)showSearchUserViewController {
    GHCSearchViewController *searchUserProfileVC = [GHCSearchViewController new];
    [self.navigationController pushViewController:searchUserProfileVC animated:YES];
}

- (void)deleteUserAndShowLoginViewController {
    [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"LoginStatus"];
    [self.navigationController popToRootViewControllerAnimated:YES];
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
        strongSelf.passwordField.text = @"";
    }]];
    [self presentViewController:alert animated:YES completion:nil];
}

- (void)signInButtonTapped {
    
    [self.presenter loginWithUserName:self.loginField.text password:self.passwordField.text];
}

- (void)setupViews {
    [self setupGitImageView];
    [self setupLoginLabel];
    [self setupLoginField];
    [self setupPasswordLabel];
    [self setupPasswordField];
    [self setupSignInButton];
}

#pragma mark - Setup profileImage

- (void)setupGitImageView {
    self.gitImageView = [UIImageView new];
    [self.loginStackView addArrangedSubview:self.gitImageView];
    [self.gitImageView setImage:[UIImage imageNamed:@"github-logo"]];
    [self.gitImageView setTranslatesAutoresizingMaskIntoConstraints:NO];
    
    [NSLayoutConstraint activateConstraints:@[
                                              //[self.gitImageView.centerXAnchor constraintEqualToAnchor:self.loginStackView.centerXAnchor],
                                              [self.gitImageView.heightAnchor constraintEqualToConstant:180],
                                              [self.gitImageView.widthAnchor constraintEqualToConstant:270]
                                              ]];
    
}

#pragma mark - Setup TextFields

- (void)setupLoginField {
    
    self.loginField = [UITextField new];
    [self.loginStackView addArrangedSubview:self.loginField];
    self.loginField.text = @"";
    self.loginField.textAlignment = NSTextAlignmentCenter;
    self.loginField.borderStyle = UITextBorderStyleRoundedRect;
    [self.loginField setBackgroundColor:[UIColor clearColor]];
    self.loginField.translatesAutoresizingMaskIntoConstraints = NO;
    
    [NSLayoutConstraint activateConstraints:@[
                                              [self.loginField.heightAnchor     constraintEqualToConstant:50.0f],
                                              //[self.loginField.centerXAnchor    constraintEqualToAnchor:self.loginStackView.centerXAnchor],
                                              [self.loginField.widthAnchor      constraintEqualToConstant:200.0f]
                                              ]];
}

- (void)setupPasswordField {
    
    self.passwordField = [UITextField new];
    [self.loginStackView addArrangedSubview:self.passwordField];
    self.passwordField.text = @"";
    self.passwordField.backgroundColor = UIColor.clearColor;
    self.passwordField.textAlignment = NSTextAlignmentCenter;
    self.passwordField.borderStyle = UITextBorderStyleRoundedRect;
    self.passwordField.secureTextEntry = YES;
    
    self.passwordField.translatesAutoresizingMaskIntoConstraints = NO;
    
    [NSLayoutConstraint activateConstraints:@[
                                              [self.passwordField.heightAnchor  constraintEqualToConstant:50],
                                             // [self.passwordField.centerXAnchor constraintEqualToAnchor:self.loginStackView.centerXAnchor],
                                              [self.passwordField.widthAnchor   constraintEqualToConstant:200]
                                              ]];
}

#pragma mark - Setup Labels

- (void)setupLoginLabel {
    self.loginLabel = [UILabel new];
    [self.loginStackView addArrangedSubview:self.loginLabel];
    self.loginLabel.backgroundColor = UIColor.clearColor;
    self.loginLabel.textAlignment = NSTextAlignmentLeft;
    self.loginLabel.text = @"Login:";
    
    [self.loginLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
    
    [NSLayoutConstraint activateConstraints:@[
                                              //[self.loginLabel.centerXAnchor    constraintEqualToAnchor:self.loginStackView.centerXAnchor],
                                              [self.loginLabel.heightAnchor     constraintEqualToConstant:30],
                                              [self.loginLabel.widthAnchor      constraintEqualToConstant:200]
                                              ]];
    
}

- (void)setupPasswordLabel {
    self.passwordLabel = [UILabel new];
    [self.loginStackView addArrangedSubview:self.passwordLabel];
    self.passwordLabel.backgroundColor = UIColor.clearColor;
    self.passwordLabel.textAlignment = NSTextAlignmentLeft;
    self.passwordLabel.text = @"Password:";
    
    [self.passwordLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
    
    [NSLayoutConstraint activateConstraints:@[
                                              //[self.passwordLabel.centerXAnchor constraintEqualToAnchor:self.loginStackView.centerXAnchor],
                                              [self.passwordLabel.heightAnchor  constraintEqualToConstant:30],
                                              [self.passwordLabel.widthAnchor   constraintEqualToConstant:200]
                                              ]];
}

#pragma mark - Setup Button and Action

- (void)setupSignInButton {
    
    self.signInButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [self.loginStackView addArrangedSubview:self.signInButton];
    [self.signInButton setTitle:@"Sign in" forState:UIControlStateNormal];
    [self.signInButton addTarget:self action:@selector(signInButtonTapped) forControlEvents:UIControlEventTouchUpInside];
    
    self.signInButton.translatesAutoresizingMaskIntoConstraints = NO;
    
    [NSLayoutConstraint activateConstraints:@[
                                              [self.signInButton.heightAnchor constraintEqualToConstant:50],
                                              //[self.signInButton.centerXAnchor constraintEqualToAnchor:self.loginStackView.centerXAnchor],
                                              [self.signInButton.widthAnchor constraintEqualToConstant:150]
                                              ]];
    
}




@end
