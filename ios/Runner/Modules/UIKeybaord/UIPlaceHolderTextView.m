//
//  UIPlaceHolderTextView.m
//  iFans
//
//  Created by Zanilia on 16/8/11.
//  Copyright © 2016年 王宾. All rights reserved.
//

#import "UIPlaceHolderTextView.h"



@implementation UIPlaceHolderTextView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setParams];
    }
    return self;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self setParams];
    }
    return self;
}

- (void)setParams{
    self.font = [UIFont systemFontOfSize:16.f];
    self.textColor = [UIColor blackColor];
//    self.contentMode = UIViewContentModeRedraw;
//    self.dataDetectorTypes = UIDataDetectorTypeNone;
    self.returnKeyType = UIReturnKeySend;
    
    _placeholder = nil;
    _placeHolderColor = [UIColor colorWithRed:199.0/255.0 green:199.0/255.0 blue:205.0/255.0 alpha:1.0];
    
    [self _addTextViewNotificationObservers];
}

- (void)dealloc
{
    [self _removeTextViewNotificationObservers];
}

//- (void)deleteBackward
//{
//    if ([self.text containsString:@"["] &&  [self.text containsString:@"]"] && [[self.text substringFromIndex:self.text.length - 1] isEqualToString:@"]"]) { // 如果text中有表情
//        
//    }else {
//        
//        [super deleteBackward];
//    }
//}

#pragma mark -UIPlaceHolderTextView 方法
- (NSUInteger)numberOfLinesOfText{
    return [UIPlaceHolderTextView numberOfLinesForMessage:self.text];
}

+ (NSUInteger)maxCharactersPerLine{
    return ([UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPhone)? 33:109;
}

+ (NSUInteger)numberOfLinesForMessage:(NSString *)text{
    return (text.length / [UIPlaceHolderTextView maxCharactersPerLine]) + 1;
}

#pragma mark -- Setters
- (void)setPlaceHolder:(NSString *)placeHolder
{
    if ([placeHolder isEqualToString:_placeholder]) {
        return;
    }
    
    _placeholder = [placeHolder copy];
    [self setNeedsDisplay];
}

- (void)setPlaceHolderTextColor:(UIColor *)placeHolderTextColor
{
    if ([placeHolderTextColor isEqual:_placeHolderColor]) {
        return;
    }
    
    _placeHolderColor = placeHolderTextColor;
    [self setNeedsDisplay];
}

#pragma mark -- UITextView overrides
- (void)setText:(NSString *)text
{
    [super setText:text];
    [self setNeedsDisplay];
}

- (void)setAttributedText:(NSAttributedString *)attributedText
{
    [super setAttributedText:attributedText];
    [self setNeedsDisplay];
}

- (void)setFont:(UIFont *)font
{
    [super setFont:font];
    [self setNeedsDisplay];
}

- (void)setTextAlignment:(NSTextAlignment)textAlignment
{
    [super setTextAlignment:textAlignment];
    [self setNeedsDisplay];
}

#pragma mark -- Drawing
- (void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    
    if ([self.text length] == 0 && self.placeholder) {
        [self.placeHolderColor set];
        [self.placeholder drawInRect:CGRectInset(rect, 7.0f, 7.5f) withAttributes:[self _placeholderTextAttributes]];
    }
}

#pragma mark -- Notifications
- (void)_addTextViewNotificationObservers
{
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(_didReceiveTextViewNotification:)
                                                 name:UITextViewTextDidChangeNotification
                                               object:self];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(_didReceiveTextViewNotification:)
                                                 name:UITextViewTextDidBeginEditingNotification
                                               object:self];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(_didReceiveTextViewNotification:)
                                                 name:UITextViewTextDidEndEditingNotification
                                               object:self];
}

- (void)_didReceiveTextViewNotification:(NSNotification *)notification
{
    [self setNeedsDisplay];
}

- (void)_removeTextViewNotificationObservers
{
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UITextViewTextDidChangeNotification
                                                  object:self];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UITextViewTextDidBeginEditingNotification
                                                  object:self];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UITextViewTextDidEndEditingNotification
                                                  object:self];
    
}

- (NSDictionary *)_placeholderTextAttributes
{
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineBreakMode = NSLineBreakByTruncatingTail;
    paragraphStyle.alignment = self.textAlignment;
    UIFont *font = self.font;
    NSDictionary *params = @{ NSFontAttributeName : font,
                              NSForegroundColorAttributeName : _placeHolderColor,
                              NSParagraphStyleAttributeName : paragraphStyle };
    return params;
}

@end
