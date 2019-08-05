//
//  LoginPresenterOutput.h
//  MVPExample
//
//  Created by Evgeny Shishko on 01/08/2019.
//  Copyright © 2019 Evgeny Shishko. All rights reserved.
//

#import <Foundation/Foundation.h>


NS_ASSUME_NONNULL_BEGIN

@protocol LoginPresenterOutput <NSObject>

- (void)authorizationComplete;

@end

NS_ASSUME_NONNULL_END
