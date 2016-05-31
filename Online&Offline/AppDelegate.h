//
//  AppDelegate.h
//  Online&Offline
//
//  Created by Yosemite on 5/13/16.
//  Copyright (c) 2016 Yosemite. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Reachability.h"
#import "Dboperation.h"
#import <sqlite3.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (retain,nonatomic)NSMutableArray *arrmain;

@property(retain,nonatomic)NSString *dbpath;
@end

