//
//  TableViewCell.h
//  DemoApp
//
//  Created by Ramagouda Khot on 20/05/21.
//  Copyright © 2021 Ramagouda Khot. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface TableViewCell : UITableViewCell{
    
}

@property (strong, nonatomic) IBOutlet UILabel *labelTitle;
@property (strong, nonatomic) IBOutlet UIImageView *imageView;
@property (strong, nonatomic) IBOutlet UILabel *labelSubTitle;

@end

NS_ASSUME_NONNULL_END
