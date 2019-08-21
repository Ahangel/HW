//
//  GHCSearchViewController.m
//  MVPExample
//
//  Created by Кирилл Григоров on 18/08/2019.
//  Copyright © 2019 Evgeny Shishko. All rights reserved.
//

#import "GHCSearchViewController.h"
#import "GHCSearchPresenter.h"
#import "GHCUserDTO.h"
#import "GHCUserProfileViewController.h"

@interface GHCSearchViewController ()

@property (nonatomic, strong) GHCSearchPresenter                *presenter;
@property (nonatomic, strong) UITableView                       *tableView;
@property (nonatomic, strong) UISearchBar                       *searchBar;
@property (nonatomic, strong) NSMutableArray<NSString *>        *searchResult;
@property (nonatomic, strong) NSMutableArray<NSString *>        *tableDataResult;
@property (nonatomic, assign) NSUInteger                        pageCounter;
@property (nonatomic, assign) NSUInteger                        totalCounter;
@property (nonatomic, assign) NSUInteger                        searchBarTextLength;

@end

@implementation GHCSearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupViews];
    self.view.backgroundColor = UIColor.grayColor;
    
    self.searchResult = [NSMutableArray array];
    self.pageCounter = 1;
    self.searchBarTextLength = 0;
    
    self.presenter = [GHCSearchPresenter new];
    self.presenter.output = self;
}

#pragma mark - TableView Data Source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.searchResult.count;
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {

    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([UITableViewCell class])];

    if (!cell) {
        UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NSStringFromClass([UITableViewCell class])];

        cell.textLabel.text = [self.searchResult objectAtIndex:indexPath.row];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        return cell;
    }

    cell.textLabel.text = self.searchResult[indexPath.row];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == self.searchResult.count - 1 && self.totalCounter >= 19 && indexPath.row != self.totalCounter - 1) {
        NSLog(@"%lu", indexPath.row);
        self.pageCounter++;
        [self.presenter addUserToSearchArrayWithLogin:self.searchBar.text page:self.pageCounter];
    }
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    
    return @"Results:";
}

- (void) tableView: (UITableView *) tableView didSelectRowAtIndexPath: (NSIndexPath *) indexPath {
    [self.presenter fetchUserWithLogin:self.searchResult[indexPath.row]];
}

#pragma mark - SearchBar Delegate

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    if (searchBar.text.length == 0) {
        self.searchResult = nil;
        [self.tableView reloadData];
        return;
    }
    else {
        self.searchBarTextLength = searchBar.text.length;
        [self.presenter searchUserWithLogin:self.searchBar.text page:self.pageCounter];
    }
}

//-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
//{
//    [searchBar resignFirstResponder];
//    self.searchEnabled = YES;
//    [self.presenter searchUserWithLogin:self.searchBar.text page:1];
//}
//
//-(void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
//{
//    [searchBar resignFirstResponder];
//    [searchBar setText:@""];
//    self.searchEnabled = NO;
//    [self.tableView reloadData];
//}

#pragma mark - <GHCSearchViewPresenterOutput>

- (void)searchComplete:(nonnull NSArray *)users {
    
    @autoreleasepool {
        self.searchResult = [users mutableCopy];
        self.totalCounter = [[self.searchResult objectAtIndex:self.searchResult.count - 1] integerValue];
        [self.searchResult removeLastObject];
    }
    [self.tableView reloadData];
}

- (void)addingToSearchResult:(NSArray *)users {
    
    [self.searchResult addObjectsFromArray:users];
    [self.searchResult removeLastObject];
    [self.tableView reloadData];
}

- (void)showErrorWith:(NSString *)title message:(NSString *)message {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title
                                                                   message:message
                                                            preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"OK"
                                              style:UIAlertActionStyleDefault
                                            handler:^(UIAlertAction * _Nonnull action) {
                                            }]];
    [self presentViewController:alert animated:YES completion:nil];
}

- (void)fetchComplete:(NSDictionary *)user {
    GHCUserProfileViewController *userProfile = [[GHCUserProfileViewController alloc] initWithDictionary:user];
    userProfile.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(goBackToSearchVC)];
    [self.navigationController pushViewController:userProfile animated:YES];
}

- (void)goBackToSearchVC {
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - Setup Views

- (void)setupViews {
    [self setupTableView];
    [self setupSearchBar];
}

- (void)setupTableView {
    self.tableView = [[UITableView alloc] init];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.tableFooterView = [[UIView alloc] init];

    [self.view addSubview:self.tableView];
    
    self.tableView.translatesAutoresizingMaskIntoConstraints = NO;
    [NSLayoutConstraint activateConstraints:@[
                                              [self.tableView.leftAnchor constraintEqualToAnchor:self.view.leftAnchor],
                                              [self.tableView.rightAnchor constraintEqualToAnchor:self.view.rightAnchor],
                                              [self.tableView.centerXAnchor constraintEqualToAnchor:self.view.centerXAnchor],
                                              [self.tableView.centerYAnchor constraintEqualToAnchor:self.view.centerYAnchor constant:70],
                                              //[self.tableView.heightAnchor constraintEqualToConstant:700],
                                              [self.tableView.bottomAnchor constraintEqualToAnchor:self.view.bottomAnchor]
                                              ]];
}

- (void)setupSearchBar {
    
    self.searchBar = [UISearchBar new];
    self.searchBar.delegate = self;
    [self.view addSubview:self.searchBar];
    
    self.searchBar.placeholder = @"Search with login";
    self.searchBar.translatesAutoresizingMaskIntoConstraints = NO;
    
    [NSLayoutConstraint activateConstraints:@[
                                              [self.searchBar.centerYAnchor constraintEqualToAnchor:self.view.centerYAnchor constant:-332],
                                              [self.searchBar.centerXAnchor constraintEqualToAnchor:self.view.centerXAnchor],
                                              [self.searchBar.leftAnchor constraintEqualToAnchor:self.view.leftAnchor],
                                              [self.searchBar.rightAnchor constraintEqualToAnchor:self.view.rightAnchor]
                                              ]];
}


@end
