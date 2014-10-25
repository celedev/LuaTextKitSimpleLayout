//
//  PathImageView.h
//  TextKitLayout
//
//  Created by Jean-Luc on 14/04/2014.
//
//

#import <UIKit/UIKit.h>

@interface PathImageView : UIView

- (id) initWithFrame:(CGRect)frame  shape:(UIBezierPath*)shape image:(UIImage*)image;

@property (nonatomic) UIBezierPath* viewShape;
@property (nonatomic) UIImage* viewImage;

@end
