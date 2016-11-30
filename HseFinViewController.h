//
//  HseFinViewController.h
//  Printum
//
//  Created by JoyDa on 11/29/16.
//  Copyright © 2016 JoyDa. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HseFinViewController : UIViewController

@property (nonatomic,strong) IBOutlet UITextField *labelJa;
@property (weak, nonatomic) IBOutlet UILabel *label;
@property ( nonatomic,weak) IBOutlet UIButton *findButton;

- (IBAction)find:(id)sender;

@end
