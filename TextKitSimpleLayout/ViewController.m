//
//  ViewController.m
//  TextKitLayout
//
//  Created by Jean-Luc on 14/04/2014.
//
//

#import "ViewController.h"

#import "PathImageView.h"

#define kColumnMargin 20.0

@interface ViewController ()
{
    UITextView* _textViewColumn1;
    UITextView* _textViewColumn2;
    
    PathImageView* _panImageView;
    CGPoint _gestureStartCenter;
}

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (IBAction)setColumn1Size:(UISlider*)sender
{
    CGFloat colum1Width = (self.view.bounds.size.width - 4 * kColumnMargin) * sender.value;
    
    CGRect col1frame = self.column1View.frame;
    col1frame.size.width = colum1Width;
    self.column1View.frame = col1frame;
    
    CGRect col2Frame = self.column2View.frame;
    col2Frame.origin.x = 3 * kColumnMargin + colum1Width;
    col2Frame.size.width = self.view.bounds.size.width - (kColumnMargin + col2Frame.origin.x);
    self.column2View.frame = col2Frame;
    
    [self updateExclusionPaths];
    
}

- (void)panShapeImage:(UIPanGestureRecognizer *)panGestureRecognizer
{
	if (panGestureRecognizer.state == UIGestureRecognizerStateBegan)
    {
		_gestureStartCenter = _panImageView.center;
    }
    else if (panGestureRecognizer.state == UIGestureRecognizerStateChanged)
    {
        CGPoint currentTranslation = [panGestureRecognizer translationInView:self.view];
        CGPoint currentCenter;
        currentCenter.x = _gestureStartCenter.x + currentTranslation.x;
        currentCenter.y = _gestureStartCenter.y + currentTranslation.y;
        
        _panImageView.center = currentCenter;
        
        [self updateExclusionPaths];
    }
}

- (void)updateExclusionPaths
{
    NSLog(@"Native updateExclusionPaths");
}

@end
