//
//  ItemDetailViewController.h
//  ProcurableApp
//
//  Created by Will Turner on 4/12/16.
//  Copyright © 2016 Wilson Turner. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Item.h"

@interface ItemDetailViewController : UIViewController
@property (strong, nonatomic) Item *item;
@property (assign, nonatomic) BOOL isRequestItem;

@end
