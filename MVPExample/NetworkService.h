//
//  NetworkService.h
//  MVPExample
//
//  Created by OUT-Grigorov-KI on 08/08/2019.
//  Copyright © 2019 Evgeny Shishko. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NetworkService : NSObject

- (void)authorizeWithLogin:(NSString *)login
                  password:(NSString *)password
                completion:(void(^)(NSError * _Nullable))comletionBlock;

- (void)searchUserWithName:(NSString *)name
                completion:(void(^)(UserDTO * _Nullable, NSError * _Nullable))completionBlock;

@end

NS_ASSUME_NONNULL_END
