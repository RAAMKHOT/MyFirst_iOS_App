//
//  UserDetailsViewController.h
//  DemoApp
//
//  Created by Ramagouda Khot on 22/05/21.
//  Copyright © 2021 Ramagouda Khot. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UserProfile.h"
#import <UserNotifications/UserNotifications.h>

NS_ASSUME_NONNULL_BEGIN

@interface UserDetailsViewController : UIViewController
@property (strong,nonatomic) UserProfile *userProfile;
@property (strong, nonatomic) IBOutlet UIImageView *userProfileImage;
@property (strong, nonatomic) IBOutlet UILabel *userName;
@property (strong, nonatomic) IBOutlet UILabel *userEmailId;
@property (strong, nonatomic) IBOutlet UITextField *userAge;
@property (strong, nonatomic) IBOutlet UITextField *userNickName;
@property (strong, nonatomic) IBOutlet UILabel *userGender;
- (IBAction)moreDetailsAction:(UIButton *)sender;

@property (strong, nonatomic) IBOutlet UISegmentedControl *userSegmentOutlet;
- (IBAction)userSegmentValueChangeAction:(id)sender;
- (IBAction)showNotification:(id)sender;
@end

NS_ASSUME_NONNULL_END
