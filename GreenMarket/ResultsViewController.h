//
//  ResultsViewController.h
//  GreenMarket
//
//  Created by Andrea Cerra on 27/11/16.
//  Copyright © 2016 Hyperion. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <TagListView_ObjC/TagListView.h>
#import <TagListView_ObjC/TagView.h>
#import <MRProgress/MRProgress.h>
#import "Helper.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import <MBCircularProgressBar/MBCircularProgressBarView.h>
#import "IngredientDetailViewController.h"

@interface ResultsViewController : UIViewController

@property (nonatomic, retain) NSString *barcode;


@property (weak, nonatomic) IBOutlet UILabel *productlabel;
@property (weak, nonatomic) IBOutlet UILabel *brandLabel;
@property (weak, nonatomic) IBOutlet UILabel *categoryLabel;
@property (weak, nonatomic) IBOutlet TagListView *tagListView;
@property (weak, nonatomic) IBOutlet UIImageView *imageProduct;
@property (weak, nonatomic) IBOutlet MBCircularProgressBarView *spinnerCompatibility;

@end
