//
//  UserDTO.m
//  MVPExample
//
//  Created by Evgeny Shishko on 01/08/2019.
//  Copyright © 2019 Evgeny Shishko. All rights reserved.
//

#import "UserDTO.h"

@interface UserDTO ()

@property (nonatomic, strong) NSDictionary *userInfo;

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
    NSURLSessionConfiguration *defaultConfigObject = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session = [NSURLSession sharedSession];//sessionWithConfiguration:defaultConfigObject delegate:self delegateQueue:[NSOperationQueue mainQueue]];
    NSURLCredential *creds = [NSURLCredential credentialWithUser:self.userInfo[@"login"] password:self.userInfo[@"password"] persistence:NSURLCredentialPersistenceForSession];
    
    NSString *authStr = [NSString stringWithFormat:@"%@:%@",self.userInfo[@"login"],self.userInfo[@"password"]];// @"username:password";
    
    NSData *authData = [authStr dataUsingEncoding:NSUTF8StringEncoding];
    
    NSString *authValue = [NSString stringWithFormat: @"Basic %@",[authData base64EncodedStringWithOptions:0]];
    NSString *postLength = [NSString stringWithFormat:@"application/json"];
    
    [request setValue:authValue forHTTPHeaderField:@"Authorization"];
    [request setValue:postLength forHTTPHeaderField:@"Content-Type"];
    [request setValue:postLength forHTTPHeaderField:@"Accept"];
    
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request
                                                completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                                                    NSMutableData *receivedData = [NSMutableData data];
                                                    NSString* responseData = [[NSString alloc] initWithData:data encoding: NSUTF8StringEncoding];
                                                    NSLog(@"%@",responseData);
                                                    if (error) {
                                                        NSLog(@"Error");
                                                        return;
                                                    }
                                                }];
    [dataTask resume];
//    dispatch_async(dispatch_get_main_queue(), comletionBlock());
    
    NSLog(@"Header Fields Request--->> %@",request.allHTTPHeaderFields);
    
}

@end
