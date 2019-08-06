//
//  UserDTO.m
//  MVPExample
//
//  Created by Evgeny Shishko on 01/08/2019.
//  Copyright © 2019 Evgeny Shishko. All rights reserved.
//

#import "UserDTO.h"
#import "LoginPresenterInput.h"

@interface UserDTO ()

@end

@implementation UserDTO

- (instancetype)initWithUserInfo:(NSDictionary *)userInfo
{
    self = [super init];
    if (self) {
        _userInfo = [userInfo copy];
    }
    return self;
}

- (void)authorization {
    
    NSString *path = [NSString stringWithFormat:@"https://api.github.com/users/%@", self.userInfo[@"login"]];
    NSURL *url = [NSURL URLWithString:path];
    
    NSMutableURLRequest* request = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestReloadIgnoringLocalAndRemoteCacheData timeoutInterval:0];

    NSURLSession *session = [NSURLSession sharedSession];
    
    NSString *authStr = [NSString stringWithFormat:@"%@:%@",self.userInfo[@"login"],self.userInfo[@"password"]];// @"username:password";
    
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
                                                        dispatch_async(dispatch_get_main_queue(), ^{
                                                            [self.output authorizationWithError:error];
                                                        });
                                                        
                                                        return;
                                                    }
                                                    if (responseError) {
                                                        dispatch_async(dispatch_get_main_queue(), ^{
                                                            [self.output authorizationWithError:responseError];
                                                        });
                                                        return;
                                                    }
                                                    if (responseData == nil) {
                                                        NSLog(@"Empty JSON");
                                                        return;
                                                    }
                                                    
                                                    dispatch_sync(dispatch_get_main_queue(), ^{
                                                        [self.output authorizationComplete];
                                                    });
                                                }];
    [dataTask resume];
    
    NSLog(@"Header Fields Request--->> %@",request.allHTTPHeaderFields);
    
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

- (void)searchUser {
    
    NSString *path = [NSString stringWithFormat:@"https://api.github.com/users/%@", self.searchUserName];
    NSURL *url = [NSURL URLWithString:path];
    
    NSMutableURLRequest* request = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestReloadIgnoringLocalAndRemoteCacheData timeoutInterval:0];
    NSURLSession *session = [NSURLSession sharedSession];
    
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request
                                                completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                                                    
                                                    error = nil;
                                                    
                                                    NSDictionary *searchUserInfo = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
                                                    if (error) {
                                                        NSLog(@"Error");
                                                        return;
                                                    } else if (searchUserInfo == nil) {
                                                        NSLog(@"Empty JSON");
                                                        return;
                                                    }
                                                    
                                                    self.userName = searchUserInfo[@"login"];
                                                    self.userImage = searchUserInfo[@"avatar_url"];
                                                    NSLog(@"%@ %@", self.userName, self.userImage);
                                                }];
    [dataTask resume];
}



@end
