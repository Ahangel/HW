//
//  LoginPresenterInput.h
//  MVPExample
//
//  Created by OUT-Grigorov-KI on 06/08/2019.
//  Copyright © 2019 Evgeny Shishko. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol LoginPresenterInput <NSObject>

- (void)authorizationWithError:(NSError *)error;
- (void)authorizationComplete;

@end

NS_ASSUME_NONNULL_END
