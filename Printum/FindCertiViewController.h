//
//  FindCertiViewController.h
//  Printum
//
//  Created by JoyDa on 12/7/16.
//  Copyright © 2016 JoyDa. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FindCertiViewController : UIViewController <UITableViewDelegate,
UITableViewDataSource>
@property (copy,nonatomic) NSArray *gres;
@property (weak, nonatomic) IBOutlet UITextField *jText;
@property (weak, nonatomic) IBOutlet UIButton *finBut;
@property (weak, nonatomic) IBOutlet UILabel *noRef;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSArray *googlePlacesArrayFromAFNetworking;
@property (strong, nonatomic) NSArray *finishedGooglePlacesArray;
@property (nonatomic, retain) NSString *data12;
@end
