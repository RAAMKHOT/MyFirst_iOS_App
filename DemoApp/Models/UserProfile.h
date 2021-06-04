//
//  UserProfile.h
//  DemoApp
//
//  Created by Ramagouda Khot on 21/05/21.
//  Copyright © 2021 Ramagouda Khot. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface UserProfile : NSObject <NSCoding>

@property(strong,nonatomic) NSString *firstName;
@property(strong,nonatomic) NSString *lastName;
@property(strong,nonatomic) NSString *email;
@property(strong,nonatomic) NSString *avatar;

@end

NS_ASSUME_NONNULL_END
