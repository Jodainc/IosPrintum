//
//  FindCertiViewController.m
//  Printum
//
//  Created by JoyDa on 12/7/16.
//  Copyright © 2016 JoyDa. All rights reserved.
//

#import "FindCertiViewController.h"
#import "ViewController.h"
#import "AFNetworking.h"

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
    text1 = @"http://192.168.0.98:8080/Api/Pro_Certificados/212-1-3480";
    [self makeRestuarantsRequests:text1];
    [tableView reloadData];
}
- (IBAction)pushButto:(id)sender {
     [tableView reloadData];
    NSString *text1;
    NSString *text = jText.text;
            text1 = [NSString stringWithFormat:@"http://192.168.0.98:8080/Api/Pro_Certificados/%@", text];
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
    
    //NSURLRequest *request = [NSURLRequest requestWithURL:url];
    NSMutableURLRequest* request = [[NSMutableURLRequest alloc] initWithURL:url];
    [request setValue: @"Bearer HwlTHUt-Fn3Em_rXgf6HCgX19ItiQioOWAUcIkEILraHi6O5bDHD57siFhPVWv7ofD_UzmA5pvF4Rwn6WKOV1gDSwSB5ERG-d5D6gty2WG1dT7J7t4h2IzJ4m5a6V_6Q7QnHmJbqzjoKSrTgS4UR0ddTv5xrxpQOxAlSPlT_CnDdTFo-4w1pPfTF7ubLe_HRowCbHsMYJ5hRwI-9PjYKk6jGTo-HaMJkMB8SK7zV_6rJG6pe4Sc-2XXWLgucxO5WdMZt7uQnagP1fmtsgYT3oqcmf4AJoq4BgzrAa8YQa0Muh_9x7uz8JJ1iz5SpPhK2pgiGvEzXbYiaaS18aO08Ds1lbOAdFbAGjVRcpsbfpH5fSm0lyd07037NR0vvulZ9ALoAuGT1Wo5EPjeFIsBoiRkffLr268_uH2IdJWslwZIZ7ZVr1S_4lJujMH0TdmIquvHTcbEmO70S4s8LxKvhfFZQ2j4nmn0Z7ZCmvC2p1oc8R5b-Bnmov133i3Hwu-P8zBxGTlWmwPylTt6N6iEK6NRcv5RCW4X_oe5ufMYyjZ8"  forHTTPHeaderField:@"Authorization"];
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
