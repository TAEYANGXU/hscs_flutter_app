//
//  UIFaceKeyboardView.h
//  Baseframework
//
//  Created by Zanilia on 16/8/15.
//

#import <UIKit/UIKit.h>
#import <XyWidget/ConstHeader.h>


@protocol UIFaceKeyboardViewDelegate;


@interface UIFaceKeyboardView : UIView

//Need to input to the editor
@property (nonatomic, strong)UITextView *textView;

//The send button at the bottom of the color, the default is blueColor
@property (nonatomic, strong)UIColor *sendColor;

//default nil
@property (nonatomic) id<UIFaceKeyboardViewDelegate> delegate;

//Initialize the need to frame, and the bundle name
- (instancetype)initWithFrame:(CGRect)frame expressionBundle:(NSString *)bundleName;
@end


@protocol UIFaceKeyboardViewDelegate <NSObject>

//Send button click callback method, click the name of the return
- (void)faceViewSendFace:(NSString *)faceName;
@end
