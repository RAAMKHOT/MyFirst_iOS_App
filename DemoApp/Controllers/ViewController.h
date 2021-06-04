//
//  ViewController.h
//  DemoApp
//
//  Created by Ramagouda Khot on 20/05/21.
//  Copyright © 2021 Ramagouda Khot. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController <UITableViewDelegate,UITableViewDataSource>
@property(strong,nonatomic)IBOutlet UITableView *myTableView;
@property(strong,nonatomic)IBOutlet UILabel *noRecordFound;
@end

