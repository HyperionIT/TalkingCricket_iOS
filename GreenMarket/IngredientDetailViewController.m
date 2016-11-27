//
//  IngredientDetailViewController.m
//  GreenMarket
//
//  Created by Andrea Cerra on 27/11/16.
//  Copyright © 2016 Hyperion. All rights reserved.
//

#import "IngredientDetailViewController.h"
#define URL @"https://greenmarket.azurewebsites.net/api/GetIngredientJS?code=thgzj3j9gmlls7sntg8k6gvib77tdqe3yzlhu01oj9aa714iinrm4vm49wq78m7nwahiftj4i"

@interface IngredientDetailViewController (){
    NSMutableData* receivedData;
}

@end

@implementation IngredientDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    // set title
    self.title = @"Ingredient";
}

- (void) viewDidAppear:(BOOL)animated {
    
    [MRProgressOverlayView showOverlayAddedTo:self.view animated:YES];
    
    // make request
    NSMutableDictionary *ricarca_json = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                         self.ingredientCode, @"ingredient", //self.barcode
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
        
        self.refvaleLabel.text = [jsonArray objectForKey:@"reference_value"];
        self.kcalLabel.text = [jsonArray objectForKey:@"calories_kcal"];
        self.kjLabel.text = [jsonArray objectForKey:@"calories_kj"];
        self.avgwtLabel.text = [[jsonArray objectForKey:@"gaw"] stringByReplacingOccurrencesOfString:@" m3/ton" withString:@""];
        self.aegLabel.text = [[jsonArray objectForKey:@"grey_gaw"] stringByReplacingOccurrencesOfString:@" m3/ton" withString:@""];
        self.descriptionLabel.text = [jsonArray objectForKey:@"description"];
        self.productLabel.text = [jsonArray objectForKey:@"name"];
    }
    
    [MRProgressOverlayView dismissOverlayForView:self.view animated:YES];
}

/*****************************************/
//CONNESSIONE END
/*****************************************/

@end
