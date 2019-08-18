//
//  GHCUserProfileViewController.m
//  MVPExample
//
//  Created by OUT-Grigorov-KI on 15/08/2019.
//  Copyright © 2019 Evgeny Shishko. All rights reserved.
//

#import "GHCUserProfileViewController.h"
#import "GHCUserProfileInfoView.h"
#import "GHCUserProfileInfoTableViewCell.h"
#import "GHCLoginViewController.h"
#import "GHCSearchViewController.h"

@interface GHCUserProfileViewController ()

@property (nonatomic, strong)   GHCUserProfileInfoView    *userProfileInfoStackView;
@property (nonatomic, strong)   UITableView               *tableView;
@property (nonatomic, copy)     NSString                  *followersCounter;
@property (nonatomic, copy)     NSString                  *followingCounter;
@property (nonatomic, copy)     NSString                  *userName;
@property (nonatomic, copy)     NSString                  *publicReposCounter;
@property (nonatomic, copy)     NSString                  *userLogin;
@property (nonatomic, strong)   UIImage                   *userImage;
@property (nonatomic, copy)     NSString                  *starredRepositoriesCounter;

@end

@implementation GHCUserProfileViewController

- (instancetype)initWithDictionary:(NSDictionary *)userDict {
    self = [super init];
    if (self) {
        _followersCounter = [NSString stringWithFormat:@"%@", userDict[@"followers"]];
        _followingCounter = [NSString stringWithFormat:@"%@", userDict[@"following"]];
        _userName         = [NSString stringWithFormat:@"%@", userDict[@"name"]];
        _publicReposCounter = [NSString stringWithFormat:@"%@", userDict[@"public_repos"]];
        _userLogin          = [NSString stringWithFormat:@"%@", userDict[@"login"]];
        _userImage = userDict[@"userImage"];
        _starredRepositoriesCounter = userDict[@"starred_repos"];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColor.whiteColor;
    [self.tableView registerClass:[GHCUserProfileInfoTableViewCell class] forCellReuseIdentifier:NSStringFromClass([GHCUserProfileInfoTableViewCell class])];
    [self createUserProfileInfoStackView];
    [self createTableView];
    [self createSearchBarButton];
    [self createExitButton];
}

- (void)createSearchBarButton {
    UIBarButtonItem *searchBarButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSearch
                                                                                target:self
                                                                                action:@selector(showSearchUserViewController)];
    self.navigationItem.rightBarButtonItem = searchBarButton;
}

- (void)createExitButton {
    UIBarButtonItem *exitBarButton = [[UIBarButtonItem alloc] initWithTitle:@"Sign Out"
                                                                      style:UIBarButtonItemStyleDone
                                                                     target:self
                                                                     action:@selector(deleteUserAndShowLoginViewCintroller)];
    self.navigationItem.leftBarButtonItem = exitBarButton;
}

- (void)showSearchUserViewController {
    GHCSearchViewController *searchUserProfileVC = [GHCSearchViewController new];
    [self.navigationController pushViewController:searchUserProfileVC animated:YES];
}

- (void)deleteUserAndShowLoginViewCintroller {
    [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"LoginStatus"];
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (void)createUserProfileInfoStackView {
    
    self.userProfileInfoStackView = [[GHCUserProfileInfoView alloc] initWithUserName:self.userName
                                                                           userLogin:self.userLogin
                                                                           userImage:self.userImage];
    [self.view addSubview:self.userProfileInfoStackView];
    self.userProfileInfoStackView.backgroundColor = UIColor.clearColor;
    
    self.userProfileInfoStackView.translatesAutoresizingMaskIntoConstraints = NO;
    
    [NSLayoutConstraint activateConstraints:@[
                                              [self.userProfileInfoStackView.centerYAnchor  constraintEqualToAnchor:self.view.centerYAnchor constant:-150],
                                              [self.userProfileInfoStackView.leftAnchor     constraintEqualToAnchor:self.view.leftAnchor ],
                                              [self.userProfileInfoStackView.rightAnchor    constraintEqualToAnchor:self.view.rightAnchor ],
                                              [self.userProfileInfoStackView.heightAnchor   constraintEqualToConstant:250]
                                              ]];
}

- (void)createTableView {
    self.tableView = [UITableView new];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    self.tableView.translatesAutoresizingMaskIntoConstraints = NO;
    
    [NSLayoutConstraint activateConstraints:@[
                                              [self.tableView.topAnchor     constraintEqualToAnchor:self.userProfileInfoStackView.bottomAnchor constant:40],
                                              [self.tableView.bottomAnchor  constraintEqualToAnchor:self.view.bottomAnchor constant:-180],
                                              [self.tableView.leftAnchor    constraintEqualToAnchor:self.view.leftAnchor],
                                              [self.tableView.rightAnchor   constraintEqualToAnchor:self.view.rightAnchor]
                                              ]];
}

#pragma mark - TableView Data Source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3;
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    
    if (indexPath.row == 0) {
        GHCUserProfileInfoTableViewCell *cell = [[GHCUserProfileInfoTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                                                                       reuseIdentifier:NSStringFromClass([GHCUserProfileInfoTableViewCell class])
                                                                                      followersCounter:self.followersCounter
                                                                                      followingCounter:self.followingCounter
                                                                                   repositoriesCounter:self.publicReposCounter
                                                                            starredRepositoriesCounter:self.starredRepositoriesCounter
                                                                                          forIndexPath:0];
        return cell;
    } else if (indexPath.row == 1) {
        GHCUserProfileInfoTableViewCell *cell = [[GHCUserProfileInfoTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                                                                       reuseIdentifier:NSStringFromClass([GHCUserProfileInfoTableViewCell class])
                                                                                      followersCounter:self.followersCounter
                                                                                      followingCounter:self.followingCounter
                                                                                   repositoriesCounter:self.publicReposCounter
                                                                            starredRepositoriesCounter:self.starredRepositoriesCounter
                                                                                          forIndexPath:1];
        return cell;
    } else {
        GHCUserProfileInfoTableViewCell *cell = [[GHCUserProfileInfoTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                                                                       reuseIdentifier:NSStringFromClass([GHCUserProfileInfoTableViewCell class])
                                                                                      followersCounter:self.followersCounter
                                                                                      followingCounter:self.followingCounter
                                                                                   repositoriesCounter:self.publicReposCounter
                                                                            starredRepositoriesCounter:self.starredRepositoriesCounter
                                                                                          forIndexPath:2];
        return cell;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 80;
}

@end
