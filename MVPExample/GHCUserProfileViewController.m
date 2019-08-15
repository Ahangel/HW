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

@interface GHCUserProfileViewController ()

@property (nonatomic, strong) GHCUserProfileInfoView    *userProfileInfoStackView;
@property (nonatomic, strong) UITableView               *tableView;

@end

@implementation GHCUserProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColor.whiteColor;
    [self.tableView registerClass:[GHCUserProfileInfoTableViewCell class] forCellReuseIdentifier:NSStringFromClass([GHCUserProfileInfoTableViewCell class])];
    [self createUserProfileInfoStackView];
    [self createTableView];
    
}

- (void)createUserProfileInfoStackView {
    
    self.userProfileInfoStackView = [[GHCUserProfileInfoView alloc] init];
    [self.view addSubview:self.userProfileInfoStackView];
    self.userProfileInfoStackView.backgroundColor = UIColor.clearColor;
    
    self.userProfileInfoStackView.translatesAutoresizingMaskIntoConstraints = NO;
    
    [NSLayoutConstraint activateConstraints:@[
                                              [self.userProfileInfoStackView.centerYAnchor constraintEqualToAnchor:self.view.centerYAnchor constant:-150],
                                              [self.userProfileInfoStackView.leftAnchor constraintEqualToAnchor:self.view.leftAnchor ],
                                              [self.userProfileInfoStackView.rightAnchor constraintEqualToAnchor:self.view.rightAnchor ],
                                              [self.userProfileInfoStackView.heightAnchor constraintEqualToConstant:250]
                                              ]];
}

- (void)createTableView {
    self.tableView = [UITableView new];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    self.tableView.translatesAutoresizingMaskIntoConstraints = NO;
    
    [NSLayoutConstraint activateConstraints:@[
                                              [self.tableView.topAnchor constraintEqualToAnchor:self.userProfileInfoStackView.bottomAnchor constant:40],
                                              [self.tableView.bottomAnchor constraintEqualToAnchor:self.view.bottomAnchor constant:-180],
                                              [self.tableView.leftAnchor constraintEqualToAnchor:self.view.leftAnchor],
                                              [self.tableView.rightAnchor constraintEqualToAnchor:self.view.rightAnchor]
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
        GHCUserProfileInfoTableViewCell *cell = [[GHCUserProfileInfoTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NSStringFromClass([GHCUserProfileInfoTableViewCell class]) forIndexPath:0];
        return cell;
    } else if (indexPath.row == 1) {
        GHCUserProfileInfoTableViewCell *cell = [[GHCUserProfileInfoTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NSStringFromClass([GHCUserProfileInfoTableViewCell class]) forIndexPath:1];
        return cell;
    } else {
        GHCUserProfileInfoTableViewCell *cell = [[GHCUserProfileInfoTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NSStringFromClass([GHCUserProfileInfoTableViewCell class]) forIndexPath:2];
        return cell;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 80;
}

@end
