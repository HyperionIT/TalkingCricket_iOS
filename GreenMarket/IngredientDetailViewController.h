//
//  IngredientDetailViewController.h
//  GreenMarket
//
//  Created by Andrea Cerra on 27/11/16.
//  Copyright © 2016 Hyperion. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MRProgress/MRProgress.h>
#import "Helper.h"

@interface IngredientDetailViewController : UIViewController

@property (nonatomic, retain) NSString *ingredientCode;

@property (weak, nonatomic) IBOutlet UILabel *refvaleLabel;
@property (weak, nonatomic) IBOutlet UILabel *kcalLabel;
@property (weak, nonatomic) IBOutlet UILabel *kjLabel;
@property (weak, nonatomic) IBOutlet UILabel *avgwtLabel;
@property (weak, nonatomic) IBOutlet UILabel *aegLabel;
@property (weak, nonatomic) IBOutlet UITextView *descriptionLabel;
@property (weak, nonatomic) IBOutlet UILabel *productLabel;
@end
