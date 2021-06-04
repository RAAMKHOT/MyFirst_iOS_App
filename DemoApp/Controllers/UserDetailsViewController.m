//
//  UserDetailsViewController.m
//  DemoApp
//
//  Created by Ramagouda Khot on 22/05/21.
//  Copyright © 2021 Ramagouda Khot. All rights reserved.
//

#import "UserDetailsViewController.h"
#import "UserProfile.h"
#import "UserMoreDetailsController.h"
#import <SDWebImage/SDWebImage.h>
#import "SCLAlertView.h"

@interface UserDetailsViewController ()
    @property (strong, nonatomic) UserProfile *selectedUserProfile;
    @property (strong, nonatomic) NSArray *data;
@property (strong, nonatomic) NSString *selectedGender;
@end

bool isGrantedNotificationAccess;
@implementation UserDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    isGrantedNotificationAccess = false;
    self.selectedGender =@"Male";
    self.data = [[NSArray alloc] initWithObjects:@"Male",@"Female", nil];
    self.selectedUserProfile = self.userProfile;
    
    [self setUserData];
    [self initNotification];
}
-(void) setUserData{
    
    self.userProfileImage.layer.cornerRadius=5;
    self.userProfileImage.layer.borderColor = [[UIColor blackColor] CGColor];
    self.userProfileImage.clipsToBounds=true;
    self.userProfileImage.layer.borderWidth=1;
    
    [self.userProfileImage sd_setImageWithURL:[NSURL URLWithString:self.selectedUserProfile.avatar]
    placeholderImage:[UIImage imageNamed:@"placeholder"]];
    
    self.userName.text = [NSString stringWithFormat:@"%@, %@",self.selectedUserProfile.firstName,self.selectedUserProfile.lastName];
    self.userEmailId.text = [NSString stringWithFormat:@"Email Id: %@",self.selectedUserProfile.email];
}

- (IBAction)moreDetailsAction:(UIButton *)sender {
    NSUserDefaults *preference=[NSUserDefaults standardUserDefaults];
    [preference setObject:self.userName.text forKey:@"UserName"];
    [preference setObject:self.selectedGender forKey:@"Gender"];
    [preference setObject:self.userAge.text forKey:@"Age"];
    [preference setObject:self.userNickName.text forKey:@"NickName"];
    [self goToMoreDetailsScreen];
}

-(void) goToMoreDetailsScreen{
    UserMoreDetailsController *viewController=[self.storyboard instantiateViewControllerWithIdentifier:@"more_details"];
    [self.navigationController pushViewController:viewController animated:YES];
}

-(void) initNotification{
    UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
    UNAuthorizationOptions options= UNAuthorizationOptionSound + UNAuthorizationOptionAlert;
    [center requestAuthorizationWithOptions:options completionHandler:^(BOOL granted, NSError * _Nullable error) {
        isGrantedNotificationAccess = granted;
    }];
}

- (IBAction)showNotification:(id)sender {
    [self showAlertView];
}

- (IBAction)userSegmentValueChangeAction:(id)sender {
    int currentIndex=(int)_userSegmentOutlet.selectedSegmentIndex;
    self.selectedGender=(currentIndex == 0 ? @"Male" : @"Female");
    _userGender.text= [NSString stringWithFormat:@"Gender: %@",self.selectedGender];
}

-(void) showAlertView{
    SCLAlertView *alert = [[SCLAlertView alloc] init];

    //Using Selector
    [alert addButton:@"Show Notification" target:self selector:@selector(firstButton)];
    [alert showSuccess:self title:@"Local Notification" subTitle:@"Want to show the local notification.?" closeButtonTitle:@"Close" duration:0.0f];
}

-(void) firstButton{
    [self createLocalNotification];
}

-(void) createLocalNotification{
    if(isGrantedNotificationAccess){
        UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
        
        UNTimeIntervalNotificationTrigger *trigger= [UNTimeIntervalNotificationTrigger triggerWithTimeInterval:1 repeats:NO];
        
        UNMutableNotificationContent *content = [[UNMutableNotificationContent alloc] init];
        
        content.title = self.userName.text;
        content.subtitle = self.userEmailId.text;
        //content.body = @"This is my first demo application";
        content.sound = [UNNotificationSound defaultSound];
        
        //setting up the request for notification.
        UNNotificationRequest *request = [UNNotificationRequest requestWithIdentifier:@"LocalNotification" content:content trigger:trigger];
        
        [center addNotificationRequest:request withCompletionHandler:nil];
    }
}
@end
