//
//  UserMoreDetailsController.m
//  DemoApp
//
//  Created by Ramagouda Khot on 23/05/21.
//  Copyright © 2021 Ramagouda Khot. All rights reserved.
//

#import "UserMoreDetailsController.h"

@interface UserMoreDetailsController ()

@end

@implementation UserMoreDetailsController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSUserDefaults *preference=[NSUserDefaults standardUserDefaults];
    NSString *userName = [preference stringForKey:@"UserName"];
    
    NSString *Gender = [preference stringForKey:@"Gender"];
    NSString *Age = [preference stringForKey:@"Age"];
    NSString *NickName = [preference stringForKey:@"NickName"];
    
    
    self.navigationItem.title = [NSString stringWithFormat:@"%@ (%@)",userName,Age];
    
    NSLog(@"User NAme: %@, %@, %@, %@",userName,Gender,Age,NickName);
    
    _headingLabel.text = [NSString stringWithFormat:@"Nick Name: %@,\nGender: %@",([NickName isEqualToString:@""]?@"No nick name":NickName),Gender];
}

@end
