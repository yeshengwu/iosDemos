//
//  MasterViewController.m
//  ProductName
//
//  Created by evan on 15/11/6.
//  Copyright (c) 2015年 evan. All rights reserved.
//

#import "MasterViewController.h"
#import "DetailViewController.h"

#import "TestLogic.h"
#import "TestVC.h"
#import "Confuse.h"
#import "Config.h"

#import <mach/mach.h>
#import <mach/mach_host.h>
#import <sys/sysctl.h>
#include <AdSupport/AdSupport.h>

#import "GTMBase64.h"
#include "OpenUDID.h"


@interface MasterViewController ()
@property NSMutableArray *objects;
@property (nonatomic, retain) NSNumber *balance;
@end

@implementation MasterViewController

- (void)awakeFromNib {
    NSLog(@"MasterVC awakeFromNib");
    [super awakeFromNib];
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        self.clearsSelectionOnViewWillAppear = NO;
        self.preferredContentSize = CGSizeMake(320.0, 600.0);
    }
}

- (void)viewDidLoad {
    NSLog(@"MasterVC viewDidLoad");
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.navigationItem.leftBarButtonItem = self.editButtonItem;

    UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(insertNewObject:)];
    self.navigationItem.rightBarButtonItem = addButton;
    self.detailViewController = (DetailViewController *)[[self.splitViewController.viewControllers lastObject] topViewController];
    
    int xx= 100;
    NSString *b = [NSString stringWithFormat:@"%d",xx];
    NSLog(@"ib = %@",b);
    
    BOOL isAdvertisingTrackingEnabled = [[ASIdentifierManager sharedManager] isAdvertisingTrackingEnabled];
    NSLog(@"isAdvertisingTrackingEnabled = %d",isAdvertisingTrackingEnabled);
    
    NSString *idfa = [[[ASIdentifierManager sharedManager] advertisingIdentifier] UUIDString];
    NSLog(@"idfa = %@",idfa);
    
    NSString *value1 = @"1";
//    NSString *value2 = @"2";
    NSString *value2 = @"";
//    NSString *value2 = nil;
    NSString *value3 = @"3";
//    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:value1,@"v1",value2,@"v2",value3,@"v3", nil];
    
    NSDictionary *dic = @{@"v1":value1,@"v2":value2,@"v3":value3};
    NSLog(@"init dic = %@",dic);
   
    self.balance = [dic valueForKey:@"balance"];
    NSLog(@"self.balance = %@",self.balance);
    
    NSArray *testArray = nil;
    NSLog(@"check array count= %d",testArray.count);
    
    NSString* openUDID = [OpenUDID value];
    if (openUDID) {
         NSLog(@"openUDID:%@", openUDID);
    }
    
    NSLog(@"MasterVC viewBound width=%f",self.view.bounds.size.width);
    NSLog(@"MasterVC viewFrame width=%f",self.view.frame.size.width);
    
}

/// sysctl no longer works in iOS9
- (NSArray *)runningProcesses {
    
    int mib[4] = {CTL_KERN, KERN_PROC, KERN_PROC_ALL, 0};
    size_t miblen = 4;
    
    size_t size;
    int st = sysctl(mib, miblen, NULL, &size, NULL, 0);
    
    struct kinfo_proc * process = NULL;
    struct kinfo_proc * newprocess = NULL;
    
    do {
        
        size += size / 10;
        newprocess = realloc(process, size);
        
        if (!newprocess){
            
            if (process){
                free(process);
            }
            
            return nil;
        }
        
        process = newprocess;
        st = sysctl(mib, miblen, process, &size, NULL, 0);
        
    } while (st == -1 && errno == ENOMEM);
    
    if (st == 0){
        
        if (size % sizeof(struct kinfo_proc) == 0){
            int nprocess = size / sizeof(struct kinfo_proc);
            
            if (nprocess){
                
                NSMutableArray * array = [[NSMutableArray alloc] init];
                
                for (int i = nprocess - 1; i >= 0; i--){
                    
                    NSString * processID = [[NSString alloc] initWithFormat:@"%d", process[i].kp_proc.p_pid];
                    NSString * processName = [[NSString alloc] initWithFormat:@"%s", process[i].kp_proc.p_comm];
                    
                    NSDictionary * dict = [[NSDictionary alloc] initWithObjects:[NSArray arrayWithObjects:processID, processName, nil]
                                                                        forKeys:[NSArray arrayWithObjects:@"ProcessID", @"ProcessName", nil]];
                    [array addObject:dict];
                }
                
                free(process);
                return array;
            }
        }
    }
    
    return nil;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)insertNewObject:(id)sender {
    if (!self.objects) {
        self.objects = [[NSMutableArray alloc] init];
    }
    [self.objects insertObject:[NSDate date] atIndex:0];
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    [self.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
}

#pragma mark - Segues

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"showDetail"]) {
//        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
//        NSDate *object = self.objects[indexPath.row];
//        DetailViewController *controller = (DetailViewController *)[[segue destinationViewController] topViewController];
//        [controller setDetailItem:object];
//        controller.navigationItem.leftBarButtonItem = self.splitViewController.displayModeButtonItem;
//        controller.navigationItem.leftItemsSupplementBackButton = YES;
        
        DetailViewController *controller = (DetailViewController *)[[segue destinationViewController] topViewController];
        controller.cate1String = @"cate1String";
        
        bool can = [[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"puacg://"]];
         NSLog(@"can open %d",can);
//        if (can) {
            //statement
            NSLog(@"can open puacg");
             [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"puacg://"]];
//        }else{
//            NSLog(@"can not open puacg");
//        }

    }
}

#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.objects.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];

    NSDate *object = self.objects[indexPath.row];
    cell.textLabel.text = [object description];
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [self.objects removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
    }
}

- (BOOL)shouldAutorotate{
    return YES;
}

@end
