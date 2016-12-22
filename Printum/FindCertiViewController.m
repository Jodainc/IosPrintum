//
//  FindCertiViewController.m
//  Printum
//
//  Created by JoyDa on 12/7/16.
//  Copyright © 2016 JoyDa. All rights reserved.
//
#import <RestKit/RestKit.h>
#import <RestKit/CoreData.h>
#import "FindCertiViewController.h"
#import "ViewController.h"
#import "AFNetworking.h"
#import "TrollToken+CoreDataClass.h"
@interface FindCertiViewController ()

@end

@implementation FindCertiViewController
@synthesize jText;
@synthesize noRef;
@synthesize tableView;
@synthesize finBut;
- (void)viewDidLoad {
    self.finishedGooglePlacesArray = [[NSMutableArray  alloc] init];
    NSString *text1;
    text1 = @"http://printumsaa.zapto.org:8080/Api/Pro_Certificados/212-1-3480";
    [self makeRestuarantsRequests:text1];
    [tableView reloadData];
}
- (IBAction)pushButto:(id)sender {
     [tableView reloadData];
    NSString *text1;
    NSString *text = jText.text;
            text1 = [NSString stringWithFormat:@"http://printumsaa.zapto.org:8080/Api/Pro_Certificados/%@", text];
    self.finishedGooglePlacesArray = [[NSMutableArray  alloc] init];
    [self makeRestuarantsRequests:text1];
    [tableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}
-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{

    
}
-(void)makeRestuarantsRequests :(NSString *) a{
    NSURL *url = [NSURL URLWithString:a];
    NSManagedObjectContext *context = [RKManagedObjectStore defaultStore].mainQueueManagedObjectContext;
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"UserList"];
    NSSortDescriptor *descriptor = [NSSortDescriptor sortDescriptorWithKey:@"userName" ascending:YES];
    fetchRequest.sortDescriptors = @[descriptor];
    NSError *error = nil;
    
    NSArray *fetchedObjects = [context executeFetchRequest:fetchRequest error:&error];
    TrollToken *trolll = [fetchedObjects firstObject];
    NSString *a164 = trolll.token_type;
    a164 = [a164 stringByAppendingString:@" "];
    NSString *a165 = trolll.trollTokens;
    NSString *textoRetorno = [a164 stringByAppendingString:a165];
        NSLog(@"Request Failed with Error: %@, %@", error, textoRetorno);
    //NSURLRequest *request = [NSURLRequest requestWithURL:url];
    NSMutableURLRequest* request = [[NSMutableURLRequest alloc] initWithURL:url];
    [request setValue: textoRetorno  forHTTPHeaderField:@"Authorization"];
    AFJSONRequestOperation *operation = [AFJSONRequestOperation
                                         JSONRequestOperationWithRequest:request
                                         success:^(NSURLRequest *request, NSHTTPURLResponse *response, id responseObject)
                                         {
                                             
                                             self.googlePlacesArrayFromAFNetworking = [NSArray array];
                                        
                                             self.googlePlacesArrayFromAFNetworking = responseObject;
                                             NSMutableArray *_names = [NSMutableArray array];
                                             for (id item in _googlePlacesArrayFromAFNetworking){
                                                 NSString *a =[NSString stringWithFormat:@"%@", item[@"C8pROTECCION"]];
                                                 if (![a isEqualToString:@"<null>"]) {
                                                     [_names addObject:[NSString stringWithFormat:@"%@", item[@"C8pROTECCION"]]];
                                                 }
                                                 
                                             }
                                             self.googlePlacesArrayFromAFNetworking = _names;

                                             
                                         }
                                         failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id responseObject)
                                         {
                                             NSLog(@"Request Failed with Error: %@, %@", error, error.userInfo);
                                         }];
    [operation start];
     [tableView reloadData];
}
- (void)passDataForward
{

}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.googlePlacesArrayFromAFNetworking count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:  (NSIndexPath *)indexPath
{
    NSString *CellIdentifier = @"CellIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell==nil) {
        cell= [[UITableViewCell alloc] initWithStyle:UITableViewCellStateDefaultMask reuseIdentifier:CellIdentifier];
    }
    NSDictionary *obj =[_googlePlacesArrayFromAFNetworking objectAtIndex:indexPath.row];
    cell.textLabel.text = self.googlePlacesArrayFromAFNetworking[indexPath.row];
    return cell;
}
-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    UIStoryboard *sb = self.storyboard;
    ViewController *vc = [sb instantiateViewControllerWithIdentifier:@"ViewController"];
       vc.datas = self.googlePlacesArrayFromAFNetworking[indexPath.row];
    [self.navigationController pushViewController:vc animated:YES];

    
}

@end
