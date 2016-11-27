//
//  ScannViewController.m
//  GreenMarket
//
//  Created by Andrea Cerra on 26/11/16.
//  Copyright © 2016 Hyperion. All rights reserved.
//

#import "ScannViewController.h"

@interface ScannViewController (){
    MTBBarcodeScanner *scanner;
}

@end

@implementation ScannViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    scanner = [[MTBBarcodeScanner alloc] initWithPreviewView:self.barcodeView];
    
    // title
    self.title = @"Scanner";
}

- (void) viewDidAppear:(BOOL)animated {
    
    NSError *error = nil;
    [scanner startScanningWithResultBlock:^(NSArray *codes) {
        for (AVMetadataMachineReadableCodeObject *code in codes) {
            NSLog(@"Found unique code: %@", code.stringValue);
            
            [scanner stopScanning];
            
            ResultsViewController *controller = [[ResultsViewController alloc] initWithNibName:@"ResultsViewController" bundle:nil];
            [[self navigationController] pushViewController:controller animated:YES];
            
        }
    } error:&error];
    
    if (error) {
        NSLog(@"An error occurred: %@", error.localizedDescription);
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
