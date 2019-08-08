//
//  NetworkService.m
//  MVPExample
//
//  Created by OUT-Grigorov-KI on 08/08/2019.
//  Copyright © 2019 Evgeny Shishko. All rights reserved.
//

#import "UserDTO.h"
#import "NetworkService.h"

@implementation NetworkService

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
                                                    
                                                    NSLog(@"%@",responseData);
                                                    
                                                    if (error) {
                                                        completionBlock(error);
                                                        return;
                                                    }
                                                    if (responseError) {
                                                        completionBlock(responseError);
                                                        return;
                                                    }
                                                    if (responseData == nil) {
                                                        NSLog(@"Empty JSON");
                                                        return;
                                                    }
                                                    
                                                    completionBlock(nil);
                                                    
                                                    NSLog(@"%@", responseData);
                                                }];
    [dataTask resume];
    
    NSLog(@"Header Fields Request--->> %@",request.allHTTPHeaderFields);
}

- (void)searchUserWithName:(NSString *)name
                completion:(void(^)(UserDTO * _Nullable, NSError * _Nullable))completionBlock {
    
    NSString *path = [NSString stringWithFormat:@"https://api.github.com/users/%@", name];
    NSURL *url = [NSURL URLWithString:path];
    
    NSMutableURLRequest* request = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestReloadIgnoringLocalAndRemoteCacheData timeoutInterval:0];
    NSURLSession *session = [NSURLSession sharedSession];
    
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request
                                                completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                                                    
                                                    NSDictionary *searchUserInfo = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
                                                    
                                                    NSHTTPURLResponse *HTTPResponse = (NSHTTPURLResponse *)response;
                                                    NSInteger statusCode = [HTTPResponse statusCode];
                                                    
                                                    NSError *responseError = [self statusCodeCheck:statusCode];
                                                    
                                                    if (error) {
                                                        completionBlock(nil, error);
                                                        return;
                                                    }
                                                    if (responseError) {
                                                        completionBlock(nil, responseError);
                                                        return;
                                                    }
                                                    
                                                    if (searchUserInfo == nil) {
                                                        NSLog(@"Empty JSON");
                                                        return;
                                                    }
                                      
                                                    NSString *name = searchUserInfo[@"login"];
                                                    [self fetchRepositoriesWithLogin:name completion:^(NSArray *repos, NSError * error) {
                                                        UserDTO *model = [[UserDTO alloc] initWithUser:name repos:repos];
                                                        completionBlock(model, nil);
                                                    }];
                                                    NSLog(@"%@", name);
                                                }];
    [dataTask resume];
}

- (void)fetchRepositoriesWithLogin:(NSString *)name
                        completion:(void(^)(NSArray * _Nullable, NSError * _Nullable))completionBlock {
    
    NSString *path = [NSString stringWithFormat:@"https://api.github.com/users/%@/repos", name];
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
//                                                    if (responseError) {
//                                                        completionBlock(nil, responseError);
//                                                        return;
//                                                    }
                                                    
                                                    if (fetchUserRepos == nil) {
                                                        NSLog(@"Empty JSON");
                                                        return;
                                                    }
                                                    
                                                    NSMutableArray *repos = [NSMutableArray new];
                                                    for (NSDictionary *dict in fetchUserRepos) {
                                                        NSString *value = dict[@"name"];
                                                        [repos addObject:value];
                                                    }
                                                   
                                                    completionBlock([repos copy], nil);
                                                    NSLog(@"%@", repos);
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
    }
    
    return nil;
}

@end
