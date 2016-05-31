//
//  ViewController.m
//  Online&Offline
//
//  Created by Yosemite on 5/13/16.
//  Copyright (c) 2016 Yosemite. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController
@synthesize Table_vw;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    Table_vw.dataSource=self;
    Table_vw.delegate=self;
    dictmute=[[NSMutableDictionary alloc]init];
    
    // Do any additional setup after loading the view, typically from a nib.
    
    NSURL *url=[NSURL URLWithString:@"https://gist.githubusercontent.com/mshafrir/2646763/raw/8b0dbb93521f5d6889502305335104218454c2bf/states_hash.json"];
    
    NSData *data=[NSData dataWithContentsOfURL:url];
    
   dictmute=[NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
    

    
    deli=(AppDelegate *)[[UIApplication sharedApplication]delegate];
    NSLog(@"%@",deli.arrmain);
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return dictmute.allKeys.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell=nil;
    
    cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell"];
    
    cell.textLabel.text=[[dictmute allKeys]objectAtIndex:indexPath.row];
    
    cell.detailTextLabel.text=[[dictmute allValues]objectAtIndex:indexPath.row];
    
    return cell;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
