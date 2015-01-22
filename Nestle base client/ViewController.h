//
//  ViewController.h
//  Nestle base client
//
//  Created by Cesar Jacquet on 20/01/2015.
//  Copyright (c) 2015 c-bleu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import <MessageUI/MFMailComposeViewController.h>


@interface ViewController : UIViewController <MFMailComposeViewControllerDelegate>


- (IBAction)deleteDataBase:(id)sender;

- (IBAction)exportDatabase:(id)sender;


@end

