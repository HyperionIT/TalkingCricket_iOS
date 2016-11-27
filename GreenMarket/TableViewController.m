//
//  UITableViewController.m
//  GreenMarket
//
//  Created by Andrea Cerra on 27/11/16.
//  Copyright © 2016 Hyperion. All rights reserved.
//

#import "TableViewController.h"

@interface TableViewController (){
    NSMutableArray *shopList;
}

@end

@implementation TableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"History";
    
    shopList = [[NSMutableArray alloc] init];
    
    NSDictionary *obj1 = [[NSDictionary alloc] initWithObjectsAndKeys:@"Nutella", @"nome",
                          [NSString stringWithFormat:@"sugar, palm oil, hazeinut, sugar, palm oil, hazeinut"], @"ingredienti",
                          @"http://silvermusicradio.it/wp-content/uploads/2016/04/nutella.png", @"picture", nil];
    [shopList addObject:obj1];
    
    NSDictionary *obj2 = [[NSDictionary alloc] initWithObjectsAndKeys:@"Red Bull", @"nome",
                          [NSString stringWithFormat:@"sugar, hazeinut, nuts"], @"ingredienti",
                          @"https://upload.wikimedia.org/wikipedia/commons/0/00/Red_bull_tin.jpeg", @"picture", nil];
    [shopList addObject:obj2];
    
    NSDictionary *obj3 = [[NSDictionary alloc] initWithObjectsAndKeys:@"Oro Ciok", @"nome",
                          [NSString stringWithFormat:@"accenture, digital, hackathon, sugar"], @"ingredienti",
                          @"https://www.orosaiwa.it/wp-content/uploads/2016/01/oro_ciok_nocciola_thumb.jpg", @"picture", nil];
    [shopList addObject:obj3];
    
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [shopList count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    TableViewCell *cell = (TableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"reuse"];
    
    NSDictionary *prod = [shopList objectAtIndex:indexPath.row];
    
    // Configure the cell...
    
    NSLog(@"%@", [prod objectForKey:@"nome"]);
    
    cell.titleLabel.text = [prod objectForKey:@"nome"];
    cell.ingredientLabel.text = [prod objectForKey:@"ingredienti"];
    
    [cell.imgProduct sd_setImageWithURL:[NSURL URLWithString:[prod objectForKey:@"picture"]]
                 placeholderImage:[UIImage imageNamed:@"avatar-placeholder.png"]
                                options:SDWebImageRefreshCached];

    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    ResultsViewController *controller = [[ResultsViewController alloc] initWithNibName:@"ResultsViewController" bundle:nil];
    [[self navigationController] pushViewController:controller animated:YES];
}

@end
