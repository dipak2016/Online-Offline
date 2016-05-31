//
//  AppDelegate.m
//  Online&Offline
//
//  Created by Yosemite on 5/13/16.
//  Copyright (c) 2016 Yosemite. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate
@synthesize arrmain,dbpath;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    arrmain=[[NSMutableArray alloc]init];
    
    NSArray *arr=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
    NSString *stpath=[arr objectAtIndex:0];
    
    dbpath=[stpath stringByAppendingPathComponent:@"state.tyu"];
    
    NSLog(@"%@",dbpath);
    
    if (![[NSFileManager defaultManager]fileExistsAtPath:dbpath])
    {
        sqlite3 *dbsql;
        
        NSArray *arrque=[NSArray arrayWithObjects:@"create table state(st_id integer primary key autoincrement,st_nm varchar(150),st_cod varchar(150))", nil];
        
        for (int i=0; i<arrque.count; i++)
        {
            if (sqlite3_open([dbpath UTF8String], &dbsql)==SQLITE_OK)
            {
                sqlite3_stmt *ppStmt;
                
                if (sqlite3_prepare_v2(dbsql, [[arrque objectAtIndex:i]UTF8String ], -1, &ppStmt, nil)==SQLITE_OK)
                {
                    sqlite3_step(ppStmt);
                }
                sqlite3_finalize(ppStmt);
            }
            sqlite3_close(dbsql);
        }
    }
    Dboperation *dbop=[[Dboperation alloc]init];
    
    if ([self IsConnectionAvailable]==1)
    {
        NSURL *url=[NSURL URLWithString:@"https://gist.githubusercontent.com/mshafrir/2646763/raw/8b0dbb93521f5d6889502305335104218454c2bf/states_hash.json"];
        
        NSData *data=[NSData dataWithContentsOfURL:url];
        
        NSDictionary *dict=[NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
        
        NSMutableDictionary *dict_mute=[[NSMutableDictionary alloc]init];
        
        for (int i=0; i<dict.allKeys.count; i++)
        {
            [dict_mute setValue:[[dict allKeys]objectAtIndex:i] forKey:@"stcode"];
            
            [dict_mute setValue:[[dict allValues]objectAtIndex:i] forKey:@"stnm"];
            
            [arrmain addObject:[dict_mute copy]];
        }
        
        [dbop Insertbulkdata:arrmain];
    }
    else
    {
        arrmain = [dbop SelectAllData:@"select * from state"];
    }
    
    return YES;
}
-(BOOL)IsConnectionAvailable
{
    Reachability *reachability = [Reachability reachabilityForInternetConnection];
    
    NetworkStatus networkStatus = [reachability currentReachabilityStatus];
    
    return !(networkStatus == NotReachable);
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
