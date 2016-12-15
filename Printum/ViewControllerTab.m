//
//  ViewControllerTab.m
//  Printum
//
//  Created by JoyDa on 12/15/16.
//  Copyright © 2016 JoyDa. All rights reserved.
//
#import "ViewControllerTab.h"
#import <RestKit/RestKit.h>
#import <RestKit/CoreData.h>
@interface ViewControllerTab ()
@end
@implementation ViewControllerTab
NSUInteger count1;
NSInteger *i11 = 0;
- (void)viewDidLoad {
    [super viewDidLoad];
    NSError *error1=nil;
    NSManagedObjectContext *context1 = [RKManagedObjectStore defaultStore].mainQueueManagedObjectContext;
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:@"UserList"];
    NSSortDescriptor *descriptor = [NSSortDescriptor sortDescriptorWithKey:@"userName" ascending:YES];
    fetchRequest.sortDescriptors = @[descriptor];
    NSInteger count = [context1 countForFetchRequest:fetchRequest error:&error1];
    NSLog(@"%lu  numero autesyyy... ",(unsigned long)count);
   }
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
