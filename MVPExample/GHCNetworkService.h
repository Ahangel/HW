//
//  NetworkService.h
//  MVPExample
//
//  Created by OUT-Grigorov-KI on 08/08/2019.
//  Copyright © 2019 Evgeny Shishko. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface GHCNetworkService : NSObject

- (void)authorizeWithLogin:(NSString *)login
                  password:(NSString *)password
                completion:(void(^)(NSDictionary * _Nullable, NSError * _Nullable))comletionBlock;

- (void)searchUserWithLogin:(NSString *)login
                 completion:(void(^)(GHCUserDTO * _Nullable, NSError * _Nullable))completionBlock;

@end

NS_ASSUME_NONNULL_END
