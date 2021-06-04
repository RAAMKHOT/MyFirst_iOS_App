//
//  ViewController.m
//  DemoApp
//
//  Created by Ramagouda Khot on 20/05/21.
//  Copyright © 2021 Ramagouda Khot. All rights reserved.
//

#import "ViewController.h"
#import "TableViewCell.h"
#import "UserProfile.h"
#import "UserDetailsViewController.h"
#import <SDWebImage/SDWebImage.h>

@interface ViewController ()
@property (strong,nonatomic) NSMutableArray<UserProfile*> *userProfileArray;
@property (strong, nonatomic) NSString *cellId;
@property(nonatomic, assign) int pageCount;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _myTableView.dataSource = self;
    _myTableView.delegate = self;
    _cellId = @"view_cell";
    _pageCount=1;
    
    self.userProfileArray = NSMutableArray.new;
    
    //[self.myTableView registerClass:UITableViewCell.class forCellReuseIdentifier:self.cellId];
    
    //self.myTableView.rowHeight = UITableViewAutomaticDimension;
    //self.myTableView.estimatedRowHeight = 44.0;

    [self isRecordsFound:NO];
    
    [self fetchUserData:_pageCount];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.userProfileArray.count;
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath{
    //UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"view_cell"];
    //cell.textLabel.text=[NSString stringWithFormat:@"Index of Row %li",(long)indexPath.row];
    
    TableViewCell* cell = (TableViewCell*) [tableView dequeueReusableCellWithIdentifier:self.cellId forIndexPath:indexPath];
    if(cell == nil){
        cell = [[TableViewCell alloc]init];
    }
    
    UserProfile *userProfileObj = self.userProfileArray[indexPath.row];
    
    cell.labelTitle.text = [NSString stringWithFormat:@"%@, %@",userProfileObj.firstName,userProfileObj.lastName];
    cell.labelSubTitle.text = [NSString stringWithFormat:@"%@",userProfileObj.email];
    //cell.imageView.image = [UIImage imageNamed:@"Digital_Signeture"];
    
    cell.imageView.layer.cornerRadius=20;
    cell.imageView.layer.borderColor = [[UIColor blackColor] CGColor];
    cell.imageView.clipsToBounds=true;
    cell.imageView.layer.borderWidth=1;
    
    [cell.imageView sd_setImageWithURL:[NSURL URLWithString:userProfileObj.avatar]
    placeholderImage:[UIImage imageNamed:@"placeholder"]];
    
    
    BOOL lastItemReached = [userProfileObj isEqual:[self.userProfileArray lastObject]];
    if (lastItemReached && indexPath.row == [self.userProfileArray count] - 1)
    {
        _pageCount++;
        [self fetchUserData:_pageCount];
        
        
//        testing code for pagination.
//        if(_pageCount==3)
//            _pageCount-=2;
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self getToDetailsScreen:(int)ceill(indexPath.row)];
}


// API Calling code.
//GEP : https://reqres.in/api/users?page=1
-(void) fetchUserData:(int) pageNumber{
    NSString *urlString = [NSString stringWithFormat:@"https://reqres.in/api/users?page=%i",pageNumber];
    
    NSURL *url = [NSURL URLWithString:urlString];
    
    [[NSURLSession.sharedSession dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        //NSString *jsonData=[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        //NSLog(@"Json data : %@",jsonData);
        
        NSError *err;
        
        NSDictionary *rootObj=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&err];
        NSArray *dataVlaue= rootObj[@"data"];
        if(dataVlaue.count > 0){
            [self isRecordsFound:YES];
            for (NSDictionary *item in dataVlaue) {
                UserProfile *userProfile = UserProfile.new;
                userProfile.firstName = item[@"first_name"];
                userProfile.lastName = item[@"last_name"];
                userProfile.email = item[@"email"];
                userProfile.avatar = item[@"avatar"];
                [self.userProfileArray addObject:userProfile];
            }
        }else{
            [self isRecordsFound:NO];
        }
        
        dispatch_async(dispatch_get_main_queue(),^{
            [self.myTableView reloadData];
        });
    }]resume];
}

-(void) getToDetailsScreen:(int) rowNumber{
    UserProfile *userProfileObj = self.userProfileArray[rowNumber];
    
    UserDetailsViewController *viewController=[self.storyboard instantiateViewControllerWithIdentifier:@"user_detail"];
    viewController.userProfile=userProfileObj;
    [self.navigationController pushViewController:viewController animated:YES];
}

-(void) isRecordsFound:(BOOL) flag{
    if(self.userProfileArray.count>0)
        return;
    dispatch_async(dispatch_get_main_queue(),^{
        [self.myTableView setHidden:!flag];
        [self.noRecordFound setHidden:flag];
    });
}

@end
