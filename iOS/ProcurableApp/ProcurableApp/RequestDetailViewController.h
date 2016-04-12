//
//  RequestDetailViewController.h
//  ProcurableApp
//
//  Created by Will Turner on 3/28/16.
//  Copyright © 2016 Wilson Turner. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Request.h"

@interface RequestDetailViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>
@property (strong, nonatomic) Request *request;
@property (assign, nonatomic) BOOL isManagerDetail;

@end
