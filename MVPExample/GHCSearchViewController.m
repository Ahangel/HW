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

@interface GHCSearchViewController ()

@property (nonatomic, strong) GHCSearchPresenter    *presenter;
@property (nonatomic, strong) UITableView           *tableView;
@property (nonatomic, strong) UISearchBar           *searchBar;
@property (nonatomic, assign) BOOL                  searchEnabled;
@property (nonatomic, strong) NSMutableArray        *searchResult;
@property (nonatomic, strong) NSMutableArray        *tableDataArray;

@end

@implementation GHCSearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupViews];
    self.view.backgroundColor = UIColor.whiteColor;
    
    self.searchResult = [NSMutableArray array];
    
    self.presenter = [GHCSearchPresenter new];
    self.presenter.output = self;
}

- (void)setupViews {
    [self setupTableView];
    [self setupSearchBar];
}

- (void)setupTableView {
    self.tableView = [[UITableView alloc] init];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    
    self.tableView.translatesAutoresizingMaskIntoConstraints = NO;
    [NSLayoutConstraint activateConstraints:@[
                                              [self.tableView.leftAnchor constraintEqualToAnchor:self.view.leftAnchor],
                                              [self.tableView.rightAnchor constraintEqualToAnchor:self.view.rightAnchor],
                                              [self.tableView.centerXAnchor constraintEqualToAnchor:self.view.centerXAnchor],
                                              [self.tableView.centerYAnchor constraintEqualToAnchor:self.view.centerYAnchor constant:46],
                                              [self.tableView.heightAnchor constraintEqualToConstant:700]
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

#pragma mark - TableView Data Source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([UITableViewCell class])];
    
    if (!cell) {
         UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NSStringFromClass([UITableViewCell class])];
        if (self.searchEnabled) {
            cell.textLabel.text = [self.searchResult objectAtIndex:indexPath.row];
        }
        return cell;
    }
    
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return @"Recent";
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    if (searchBar.text.length == 0) {
        self.searchEnabled = NO;
        [self.tableView reloadData];
    }
    else {
        self.searchEnabled = YES;
        [self.presenter searchUserWithLogin:self.searchBar.text page:1];
    }
}

-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    [searchBar resignFirstResponder];
    self.searchEnabled = YES;
    [self.presenter searchUserWithLogin:self.searchBar.text page:1];
}

-(void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    [searchBar resignFirstResponder];
    [searchBar setText:@""];
    self.searchEnabled = NO;
    [self.tableView reloadData];
}


- (void)searchComplete:(nonnull NSArray *)users {
    
    if (self.searchResult.count == 0) {
        
        for (NSString *user in users) {
            [self.searchResult addObject: user];
        }
        [self.tableView reloadData];
        
    } else if (self.searchResult.count >= 1) {
        
        [self.searchResult enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            [self.searchResult removeObjectAtIndex:idx];
        }];
        for (NSString *user in users) {
            [self.searchResult addObject: user];
        }
        [self.tableView reloadData];
    }
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

@end
