//
//  ViewController.h
//  TextKitLayout
//
//  Created by Jean-Luc on 14/04/2014.
//
//

#import <UIKit/UIKit.h>

@class PathImageView;

@interface ViewController : UIViewController

@property (weak, nonatomic) IBOutlet UISlider* firstColumnSizeSlider;
@property (weak, nonatomic) IBOutlet UIView* column1View;
@property (weak, nonatomic) IBOutlet UIView* column2View;

@property PathImageView* panImageView;

@end
