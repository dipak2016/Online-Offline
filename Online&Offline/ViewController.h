//
//  ViewController.h
//  Online&Offline
//
//  Created by Yosemite on 5/13/16.
//  Copyright (c) 2016 Yosemite. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
@interface ViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
{
    NSMutableDictionary *dictmute;
    AppDelegate *deli;
}
@property (weak, nonatomic) IBOutlet UITableView *Table_vw;
@end

