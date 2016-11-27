//
//  ScannViewController.h
//  GreenMarket
//
//  Created by Andrea Cerra on 26/11/16.
//  Copyright © 2016 Hyperion. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MTBBarcodeScanner.h"
#import "ResultsViewController.h"

@interface ScannViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIView *barcodeView;
@end
