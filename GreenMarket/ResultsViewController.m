//
//  ResultsViewController.m
//  GreenMarket
//
//  Created by Andrea Cerra on 27/11/16.
//  Copyright © 2016 Hyperion. All rights reserved.
//

#import "ResultsViewController.h"

#define URL @"https://greenmarket.azurewebsites.net/api/GetProductJS?code=cbVbhsrcDSCDnBrBfsyIFAnoqjnYMvsB0sII8rLJjMQqvoCD6UnJKg=="

@interface ResultsViewController (){
    NSMutableData* receivedData;
}

@end

@implementation ResultsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    // set title
    self.title = @"Results";
}

- (void) viewDidAppear:(BOOL)animated {
    
    [MRProgressOverlayView showOverlayAddedTo:self.view animated:YES];
    
    // make request
    NSMutableDictionary *ricarca_json = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                         @"80052760", @"barcode", //self.barcode
                                         nil];
    
    NSString *json = [Helper jsonFromDictionary:ricarca_json];
    NSLog(@"json input: %@",json);
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL: [NSURL URLWithString:URL]];
    
    // Set the request's content type to application/x-www-form-urlencoded
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    
    [request setHTTPMethod:@"POST"];
    [request setValue:[NSString stringWithFormat:@"%lu", (unsigned long)[json length]] forHTTPHeaderField:@"Content-length"];
    [request setHTTPBody:[json dataUsingEncoding:NSUTF8StringEncoding]];
    
    NSURLConnection *theConnection=[[NSURLConnection alloc] initWithRequest:request delegate:self];
    if (theConnection) {
        receivedData = [NSMutableData data];
    } else {
        // Inform the user that the connection failed.
        UIAlertView *alert;
        alert = [[UIAlertView alloc] initWithTitle:@"Attention"
                                           message:@"Please check the connection and try again."
                                          delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
        [alert show];
    }
}

-(BOOL)hidesBottomBarWhenPushed{
    
    return YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*****************************************/
//CONNESSIONE BEGIN
/*****************************************/

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    // This method is called when the server has determined that it
    // has enough information to create the NSURLResponse.
    
    // It can be called multiple times, for example in the case of a
    // redirect, so each time we reset the data.
    
    // receivedData is an instance variable declared elsewhere.
    [receivedData setLength:0];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    // Append the new data to receivedData.
    // receivedData is an instance variable declared elsewhere.
    [receivedData appendData:data];
}

- (void)connection:(NSURLConnection *)connection
  didFailWithError:(NSError *)error
{
    // inform the user
    NSLog(@"Connection failed! Error - %@ %@",
          [error localizedDescription],
          [[error userInfo] objectForKey:NSURLErrorFailingURLStringErrorKey]);
    
    //Allert view - connessione fallita
    UIAlertView *alert;
    alert = [[UIAlertView alloc] initWithTitle:@"Attention"
                                       message:@"Please check the connection and try again."
                                      delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
    [alert show];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    // do something with the data
    // receivedData is declared as a method instance elsewhere
    //NSLog(@"Succeeded! Received %d bytes of data",[receivedData length]);
    
    NSString* serverResponse = [[NSString alloc] initWithData:receivedData encoding:NSUTF8StringEncoding];
    NSLog(@"%@",serverResponse);
    
    NSError *e = nil;
    NSDictionary *jsonArray = [NSJSONSerialization JSONObjectWithData:receivedData
                                                              options: NSJSONReadingMutableContainers
                                                                error: &e];
    if (!jsonArray) {
        
        NSLog(@"Error parsing JSON: %@", e);
        UIAlertView *alert;
        alert = [[UIAlertView alloc] initWithTitle:@"Attention"
                                           message:@"Please check the connection and try again."
                                          delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
        [alert show];
        
    } else {
        
        self.productlabel.text = [jsonArray objectForKey:@"product"];
        self.brandLabel.text = [jsonArray objectForKey:@"brand"];
        self.categoryLabel.text = [jsonArray objectForKey:@"category"];
        
        [self.imageProduct sd_setImageWithURL:[NSURL URLWithString:[jsonArray objectForKey:@"picture"]]
                     placeholderImage:[UIImage imageNamed:@"placeholder.png"]];
        
        self.tagListView.textFont = [UIFont systemFontOfSize:16];
        [self.tagListView removeAllTags];
        
        float num = 0.0f;
        
        NSArray *ingredients = [jsonArray objectForKey:@"ingredients"];
        for (int i = 0; i < [ingredients count]; i++) {
            
            if(i % 2 == 0) {
                num++;
                self.tagListView.tagBackgroundColor = [UIColor colorWithRed:117.0/255 green:183.0/255 blue:27.0/255 alpha:1.0];
            }else{
                self.tagListView.tagBackgroundColor = [UIColor colorWithRed:196.0/255 green:31.0/255 blue:31.0/255 alpha:1.0];
            }
            
            
            NSDictionary *ingredient = [ingredients objectAtIndex:i];
            [[self.tagListView addTag:[ingredient objectForKey:@"name"]] setOnTap:^(TagView *tagView) {
                
                IngredientDetailViewController *controller = [[IngredientDetailViewController alloc] initWithNibName:@"IngredientDetailViewController" bundle:nil];
                controller.ingredientCode = [ingredient objectForKey:@"code"];
                [[self navigationController] pushViewController:controller animated:YES];
                
            }];
        }
        
        
        float count = [ingredients count];
        
        [UIView animateWithDuration:1.0f animations:^{
            self.spinnerCompatibility.value = (100 - (num/count) * 100);
        }];
        
    }
    
    [MRProgressOverlayView dismissOverlayForView:self.view animated:YES];
}

/*****************************************/
//CONNESSIONE END
/*****************************************/


@end
