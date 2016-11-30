//
//  ProhseViewController.h
//  Printum
//
//  Created by JoyDa on 11/29/16.
//  Copyright © 2016 JoyDa. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface ProhseViewController : UIViewController
@property (nonatomic, retain) NSString *data;
@property (nonatomic, retain) NSString *person;
@property (weak, nonatomic) IBOutlet UIWebView *webView;

@end
