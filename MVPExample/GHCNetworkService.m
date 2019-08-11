//
//  NetworkService.m
//  MVPExample
//
//  Created by OUT-Grigorov-KI on 08/08/2019.
//  Copyright © 2019 Evgeny Shishko. All rights reserved.
//

#import "GHCUserDTO.h"
#import "GHCNetworkService.h"
#import "GHCRepoDTO.h"

@implementation GHCNetworkService

- (void)authorizeWithLogin:(NSString *)login
                  password:(NSString *)password
                completion:(void(^)(NSError * _Nullable))completionBlock {
    
    NSString *path = [NSString stringWithFormat:@"https://api.github.com/users/%@", login];
    NSURL *url = [NSURL URLWithString:path];
    
    NSMutableURLRequest* request = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestReloadIgnoringLocalAndRemoteCacheData timeoutInterval:0];
    
    NSURLSession *session = [NSURLSession sharedSession];
    
    NSString *authStr = [NSString stringWithFormat:@"%@:%@",login, password];// @"username:password";
    
    NSData *authData = [authStr dataUsingEncoding:NSUTF8StringEncoding];
    
    NSString *authValue = [NSString stringWithFormat: @"Basic %@",[authData base64EncodedStringWithOptions:0]];
    NSString *postLength = [NSString stringWithFormat:@"application/json"];
    
    [request setValue:authValue forHTTPHeaderField:@"Authorization"];
    [request setValue:postLength forHTTPHeaderField:@"Content-Type"];
    [request setValue:postLength forHTTPHeaderField:@"Accept"];
    
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request
                                                completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                                                    
                                                    
                                                    NSDictionary* responseData = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
                                                    
                                                    NSHTTPURLResponse *HTTPResponse = (NSHTTPURLResponse *)response;
                                                    NSInteger statusCode = [HTTPResponse statusCode];
                                                    
                                                    NSError *responseError = [self statusCodeCheck:statusCode];
                                                    
//                                                    NSLog(@"%@",responseData);
                                                    
                                                    if (error) {
                                                        completionBlock(error);
                                                        return;
                                                    }
                                                    if (responseError) {
                                                        completionBlock(responseError);
                                                        return;
                                                    }
                                                    if (responseData == nil) {
                                                        completionBlock(0);
                                                        return;
                                                    }
                                                    
                                                    completionBlock(nil);
                                                    
//                                                    NSLog(@"%@", responseData);
                                                }];
    [dataTask resume];
    
//    NSLog(@"Header Fields Request--->> %@",request.allHTTPHeaderFields);
}

- (void)searchUserWithName:(NSString *)name
                completion:(void(^)(GHCUserDTO * _Nullable, NSError * _Nullable))completionBlock {
    
    NSString *path = [NSString stringWithFormat:@"https://api.github.com/users/%@", name];
    NSURL *url = [NSURL URLWithString:path];
    
    NSMutableURLRequest* request = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestReloadIgnoringLocalAndRemoteCacheData timeoutInterval:0];
    NSURLSession *session = [NSURLSession sharedSession];
    
    __weak typeof(self) weakSelf = self;
    
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request
                                                completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                                                    
                                                    __strong typeof(self) strongSelf = weakSelf;
                                                    
                                                    NSDictionary *searchUserInfo = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
                                                    
                                                    NSHTTPURLResponse *HTTPResponse = (NSHTTPURLResponse *)response;
                                                    NSInteger statusCode = [HTTPResponse statusCode];
                                                    
                                                    NSError *responseError = [strongSelf statusCodeCheck:statusCode];
                                                    
                                                    if (error) {
                                                        completionBlock(nil, error);
                                                        return;
                                                    }
                                                    if (responseError) {
                                                        completionBlock(nil, responseError);
                                                        return;
                                                    }
                                                    
                                                    if (searchUserInfo == nil) {
                                                        completionBlock(nil, 0);
                                                        return;
                                                    }
                                      
                                                    NSString *userName = searchUserInfo[@"login"];
                                                    [strongSelf fetchRepositoriesWithLogin:userName completion:^(NSArray<GHCRepoDTO *> *repos, NSError * error) {
                                                        GHCUserDTO *model = [[GHCUserDTO alloc] initWithUser:userName repos:repos];
                                                        completionBlock(model, nil);
                                                    }];
                                                }];
    [dataTask resume];
}

- (void)fetchRepositoriesWithLogin:(NSString *)userName
                        completion:(void(^)(NSArray * _Nullable, NSError * _Nullable))completionBlock {
    
    NSString *path = [NSString stringWithFormat:@"https://api.github.com/users/%@/repos", userName];
    NSURL *url = [NSURL URLWithString:path];
    
    NSMutableURLRequest* request = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestReloadIgnoringLocalAndRemoteCacheData timeoutInterval:0];
    NSURLSession *session = [NSURLSession sharedSession];
    
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request
                                                completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                                                    
                                                    NSArray *fetchUserRepos = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];

                                                    if (error) {
                                                        completionBlock(nil, error);
                                                        return;
                                                    }
                                                    
                                                    if (fetchUserRepos == nil) {
                                                        completionBlock(nil, 0);
                                                        return;
                                                    }
                                                    
                                                    NSLog(@"%@", fetchUserRepos);
                                                    
                                                    NSMutableArray<GHCRepoDTO *> *repos = [NSMutableArray new];
                                                    
                                                    for (NSDictionary *repoDict in fetchUserRepos) {
                                                        NSString *repoID = [NSString stringWithFormat:@"%@", repoDict[@"id"]];
                                                        NSString *repoName = [NSString stringWithFormat:@"%@", repoDict[@"name"]];
                                                        NSString *starsCounter = [NSString stringWithFormat:@"%@", repoDict[@"stargazers_count"]];
                                                        NSString *forksCounter = [NSString stringWithFormat:@"%@", repoDict[@"forks_count"]];
                                                        NSString *language = [NSString stringWithFormat:@"%@", repoDict[@"language"]];
                                                        GHCRepoDTO *repo = [[GHCRepoDTO alloc] initWithData:repoID repoName:repoName starsCounter:starsCounter forksCounter:forksCounter language:language];
                                                        [repos addObject:repo];
                                                    }
                                                    completionBlock([repos copy], nil);

                                                    
                                                }];
    [dataTask resume];
}

- (nullable NSError *)statusCodeCheck:(NSInteger)statusCode {
    
    NSError *error = nil;
    if (statusCode == 401) {
        error = [[NSError alloc] initWithDomain:@"UserDTODomain" code:statusCode userInfo:@{NSLocalizedDescriptionKey: @"Wrong password"}];
        return error;
    } else if (statusCode == 404) {
        error = [[NSError alloc] initWithDomain:@"UserDTODomain" code:statusCode userInfo:@{NSLocalizedDescriptionKey: @"Couldn't find this user"}];
        return error;
    } else if (statusCode == 0) {
        error = [[NSError alloc] initWithDomain:@"UserDTODomain" code:statusCode userInfo:@{NSLocalizedDescriptionKey: @"Empty JSON"}];
    }
    
    return nil;
}

@end
