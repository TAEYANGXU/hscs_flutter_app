//
//  UIPlaceHolderTextView.h
//  iFans
//
//  Created by Zanilia on 16/8/11.
//

#import <UIKit/UIKit.h>
#import <XyWidget/ConstHeader.h>

@interface UIPlaceHolderTextView : UITextView

//Prompt information
@property(nonatomic, strong) NSString *placeholder;

//placeholder Prompt information color, The default is lightGrayColor
@property(nonatomic, strong) UIColor *placeHolderColor;

//Returns the current all text takes up the number of rows
- (NSUInteger)numberOfLinesOfText;
@end
