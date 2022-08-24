//
//  UIKeyboard.m
//  iFans
//
//  Created by Zanilia on 16/8/14.
//  Copyright © 2016年 王宾. All rights reserved.
//

#import "UIKeyboardBar.h"
#import "UIView+Methods.h"
#import "UIFaceKeyboardView.h"
#import "UIMoreKeyboardView.h"
#import "UIPlaceHolderTextView.h"
#import "UIDevice+Mode.h"
#import <XyWidget/UIView+Frame.h>>

#define UIKeyboardBar_Height        55.0
#define ButtonWidthHeight           40.0
#define KeyboardOtherViewHeight     210.f
#define TextViewHeightNormal        35.0

#define FACE_NAME_HEAD              @"["
#define FACE_NAME_END               @"]"

#define MainScreenWidth             [UIScreen mainScreen].bounds.size.width
#define MainScreenHeight            [UIScreen mainScreen].bounds.size.height

@interface UIKeyboardBar ()<UITextViewDelegate,UIFaceKeyboardViewDelegate,UIMoreKeyboardViewDelegate,UIMoreKeyboardViewDataSource>

@property (strong, nonatomic) UIView *bottomLineView;

@property (strong, nonatomic) UIButton *faceButton;
@property (strong, nonatomic) UIButton *moreButton;
@property (strong, nonatomic) UIFaceKeyboardView *faceView;
@property (strong, nonatomic) UIMoreKeyboardView *moreView;
@property (strong, nonatomic) UIPlaceHolderTextView *textView;

@property (strong, nonatomic) NSString  *inputText;
@property (assign, nonatomic) CGFloat   textViewHeight;
@property (assign, nonatomic) CGRect keyboardFrame;
@property (assign, nonatomic, readonly) CGFloat bottomHeight;
@property (assign, nonatomic) UIKeyboardChatType type;

@property (nonatomic) BOOL showFaceKeyboard;    //表情键盘，Default NO
@property (nonatomic) BOOL showMoreKeyboard;    //更多键盘，Default NO

@property (nonatomic, assign) CGFloat maxY;

@end

@implementation UIKeyboardBar

+ (NSString *)bundleWithFileName:(NSString *)fileName{
    NSString *bundleFilePath= [[NSBundle mainBundle] pathForResource:@"Image" ofType:@"bundle"];
    NSString *filePath = [bundleFilePath stringByAppendingPathComponent:fileName];
    return filePath;
}

#pragma mark --  初始化设置 --
- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
//        self.textViewHeight = [UIDevice isIPhoneXFull] ? 80.0 : 55.0;
        self.textViewHeight = 55.0;
        self.maxY = kNavigationBar_Height;
        [self setFrame:CGRectMake(0, MainScreenHeight - self.textViewHeight - self.maxY ,MainScreenWidth , self.textViewHeight)];
        
        [self setup];
        [self addNotification];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame maxY:(CGFloat)y
{
    if (self = [super initWithFrame:frame]) {
//        self.textViewHeight = [UIDevice isIPhoneXFull] ? 80.0 : 55.0;
        self.textViewHeight = 55.0;
        self.maxY = y;
        [self setFrame:CGRectMake(0, MainScreenHeight - self.textViewHeight - self.maxY ,MainScreenWidth , self.textViewHeight)];
        
        [self setup];
        [self addNotification];
    }
    return self;
}

- (instancetype)init{
    if (self = [super init]) {
//        self.textViewHeight = [UIDevice isIPhoneXFull] ? 80.0 : 55.0;
        self.textViewHeight = 55.0;
        [self setFrame:CGRectMake(0, MainScreenHeight - self.textViewHeight - self.maxY,MainScreenWidth , self.textViewHeight)];
        
        [self setup];
        [self addNotification];
        
    }
    return self;
}

- (void)setup{
    self.faceSendColor = [UIColor colorWithRed:0/255.0f green:122/255.0f blue:255.0/255.0f alpha:1.0];
    
    self.frame = CGRectMake(0, self.frame.origin.y, MainScreenWidth, self.textViewHeight);
    self.backgroundColor = [UIColor whiteColor];
    UIView *topLine = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.width, 1.0)];
    topLine.backgroundColor = HEX(@"#E3E3E3");
    [self addSubview:topLine];
    
    [self addSubview:self.textView];
    [self addSubview:self.faceButton];
    [self addSubview:self.moreButton];
    [self addSubview:self.bottomLineView];
}

- (void)dealloc{
    self.barDelegate = nil;
    [self removeNotification];
}

#pragma mark -- 恢复原始状态 --
- (void)endInput{
    [self showViewWithType:UIKeyboardChatTypeDefault];
}


#pragma mark -- UI --

- (UIView *)bottomLineView{
    if (!_bottomLineView) {
        _bottomLineView = [[UIView alloc]init];
        _bottomLineView.backgroundColor = HEX(@"#E3E3E3");
    }
    return _bottomLineView;
}

- (UIButton *)moreButton{
    if (!_moreButton) {
        _moreButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _moreButton.tag = UIKeyboardChatTypeMore;
        _moreButton.frame = CGRectMake(MainScreenWidth - 10 - ButtonWidthHeight, self.textViewHeight/2 - ButtonWidthHeight/2 , ButtonWidthHeight, ButtonWidthHeight);
        
        [_moreButton setImage:[UIImage imageNamed:@"Keybaord_tool_more_icon"] forState:UIControlStateNormal];
        [_moreButton setImage:[UIImage imageNamed:@"Keybaord_tool_more_icon"] forState:UIControlStateHighlighted];
        [_moreButton setImage:[UIImage imageNamed:@"Keybaord_tool_kb_icon"] forState:UIControlStateSelected];
        [_moreButton addTarget:self action:@selector(_buttonEvent:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _moreButton;
}

- (UIButton *)faceButton{
    if (!_faceButton) {
        _faceButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _faceButton.tag = UIKeyboardChatTypeFace;
//        _faceButton.frame = CGRectMake(MainScreenWidth - 20 - ButtonWidthHeight*2.0, 4.0, ButtonWidthHeight, ButtonWidthHeight);
        _faceButton.frame = CGRectMake(10, self.textViewHeight/2 - ButtonWidthHeight/2, ButtonWidthHeight, ButtonWidthHeight);
        [_faceButton setImage:[UIImage imageNamed:@"Keybaord_tool_emotion_icon"] forState:UIControlStateNormal];
        [_faceButton setImage:[UIImage imageNamed:@"Keybaord_tool_emotion_icon"] forState:UIControlStateHighlighted];
        [_faceButton setImage:[UIImage imageNamed:@"Keybaord_tool_kb_icon"] forState:UIControlStateSelected];
        
        [_faceButton addTarget:self action:@selector(_buttonEvent:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _faceButton;
}


- (UIPlaceHolderTextView *)textView{
    if (!_textView) {
        _textView = [[UIPlaceHolderTextView alloc]initWithFrame:CGRectMake(ButtonWidthHeight+20, self.textViewHeight/2 - TextViewHeightNormal/2,MainScreenWidth - 2*(ButtonWidthHeight+20), TextViewHeightNormal)];
        _textView.backgroundColor = [UIColor whiteColor];
        _textView.placeholder = self.placehoder;
        _textView.placeHolderColor = [UIColor colorWithRed:0.8191 green:0.8191 blue:0.8191 alpha:1.0];
        _textView.placeHolderColor = HEX(@"#A6A9B6");
        _textView.enablesReturnKeyAutomatically = YES;
        _textView.scrollEnabled = NO;
        _textView.layer.cornerRadius = TextViewHeightNormal/2;
//        _textView.layer.borderColor = HEX(@"#D4D5D9").CGColor;;
//        _textView.layer.borderWidth = 0.5;
        _textView.backgroundColor = HEX(@"#F6F6F8");
        _textView.delegate = self;
    }
    return _textView;
}


- (CGFloat)bottomHeight{
    
    if (self.faceView.superview || self.moreView.superview) {
        return MAX(self.keyboardFrame.size.height, MAX(self.faceView.frame.size.height, self.moreView.frame.size.height));
    }else{
        return MAX(self.keyboardFrame.size.height, CGFLOAT_MIN);
    }
}

- (void)setPlacehoder:(NSString *)placehoder{
    _placehoder = placehoder;
    _textView.placeholder = _placehoder;
    self.textView.placeholder = placehoder;
}

- (void)setExpressionBundleName:(NSString *)expressionBundleName{
    _expressionBundleName = expressionBundleName;
    [self setNeedsDisplay];
}

- (void)setTextViewFirstResponder:(BOOL)textViewFirstResponder{
    _textViewFirstResponder = textViewFirstResponder;
    if (_textViewFirstResponder) {
        [self.textView becomeFirstResponder];
        [self showViewWithType:UIKeyboardChatTypeKeyboard];
    }else{
//        [self showViewWithType:UIKeyboardChatTypeDefault];
        [self.textView resignFirstResponder];
//        self.keyboardFrame = CGRectZero;
//        [self textViewDidChange:_textView];
        [UIView animateWithDuration:.3 animations:^{
            [self.faceView setFrame:CGRectMake(0, MainScreenHeight, self.frame.size.width, KeyboardOtherViewHeight)];
            [self.moreView setFrame:CGRectMake(0, MainScreenHeight, self.frame.size.width, KeyboardOtherViewHeight)];
            [self setFrame:CGRectMake(0, MainScreenHeight - self.textViewHeight - self.maxY ,MainScreenWidth , self.textViewHeight)];
        } completion:^(BOOL finished) {
            [self.faceView removeFromSuperview];
            [self.moreView removeFromSuperview];
        }];
    }
}


#pragma mark -- 按钮操作 --

- (UIFaceKeyboardView *)faceView{
    if (self.expressionBundleName && ![self.expressionBundleName isEqualToString:@""]) {
        if (!_faceView) {
            _faceView = [[UIFaceKeyboardView alloc] initWithFrame:CGRectMake(0, MainScreenHeight, self.frame.size.width,KeyboardOtherViewHeight) expressionBundle:self.expressionBundleName];
            _faceView.delegate = self;
            _faceView.sendColor = self.faceSendColor;
        }
    }
    
    return _faceView;
}

- (UIMoreKeyboardView*)moreView{
    if (self.KeyboardMoreImages && self.KeyboardMoreTitles && self.KeyboardMoreTitles.count!=0 && self.KeyboardMoreImages.count!=0) {
        if (!_moreView) {
            _moreView = [[UIMoreKeyboardView alloc] initWithFrame:CGRectMake(0, MainScreenHeight, self.frame.size.width, KeyboardOtherViewHeight)];
            _moreView.delegate = self;
            _moreView.dataSource = self;
        }
    }
    
    return _moreView;
}

- (void)_buttonEvent:(UIButton *)button{
    UIKeyboardChatType showType = button.tag;
    if (button == self.faceButton) {
        !self.keyboardBlock ? : self.keyboardBlock(self.faceButton.selected ? false : true);
        [self.faceButton setSelected:!self.faceButton.selected];
        [self.moreButton setSelected:NO];
    }else if (button == self.moreButton){
        [self.faceButton setSelected:NO];
        [self.moreButton setSelected:!self.moreButton.selected];
    }
    
    if (!button.selected) {
        showType = UIKeyboardChatTypeKeyboard;
        self.textView.text = self.inputText;
        [self.textView becomeFirstResponder];
    }else{
        self.inputText = self.textView.text;
    }
    [self showViewWithType:showType];
    
}

- (void)showViewWithType:(UIKeyboardChatType)showType{
    self.type = showType;
    //显示对应的View
    [self showMoreView:showType == UIKeyboardChatTypeMore && self.moreButton.selected];
    [self showFaceView:showType == UIKeyboardChatTypeFace && self.faceButton.selected];
    if (showType != UIKeyboardChatTypeDefault) {
        _inputing = YES;
    }else{
        _inputing = NO;
        
        self.faceButton.selected = NO;
        self.moreButton.selected = NO;
    }
    switch (showType) {
        case UIKeyboardChatTypeDefault:
            break;
        case UIKeyboardChatTypeMore:
        case UIKeyboardChatTypeFace:
            self.inputText = self.textView.text;
            [self setFrame:CGRectMake(0, MainScreenHeight - KeyboardOtherViewHeight - self.textViewHeight - (self.maxY > 0 ? self.maxY : 0), self.frame.size.width, self.textViewHeight) animated:YES];
            [self.textView resignFirstResponder];
            _inputing = YES;
            [self textViewDidChange:self.textView];
            break;
            
        case UIKeyboardChatTypeKeyboard:
            self.textView.text = self.inputText;
            [self textViewDidChange:self.textView];
            self.inputText = nil;
            break;
        default:
            break;
    }
    
}

#pragma mark -- 显示其他键盘 --
- (void)showFaceView:(BOOL)show{
    if (show) {
        
        [self.superview addSubview:self.faceView];
        [UIView animateWithDuration:.3 animations:^{
            [self.faceView setFrame:CGRectMake(0, MainScreenHeight - KeyboardOtherViewHeight - (self.maxY > 0 ? self.maxY : 0), self.frame.size.width, KeyboardOtherViewHeight)];
        } completion:^(BOOL finished) {
            self.hidden = NO;
        }];
    }else{
        [UIView animateWithDuration:.1 animations:^{
            [self.faceView setFrame:CGRectMake(0, MainScreenHeight, self.frame.size.width, KeyboardOtherViewHeight)];
        } completion:^(BOOL finished) {
            [self.faceView removeFromSuperview];
            [self textViewDidChange:self.textView];
        }];
    }
}

/**
 *  显示moreView
 *  @param show 要显示的moreView
 */
- (void)showMoreView:(BOOL)show{
    if (show) {
        [self.superview addSubview:self.moreView];
        [UIView animateWithDuration:.3 animations:^{
            [self.moreView setFrame:CGRectMake(0, MainScreenHeight - KeyboardOtherViewHeight - (self.maxY > 0 ? self.maxY : 0), self.frame.size.width, KeyboardOtherViewHeight)];
        } completion:nil];
    }else{
        [UIView animateWithDuration:.3 animations:^{
            [self.moreView setFrame:CGRectMake(0, MainScreenHeight, self.frame.size.width, KeyboardOtherViewHeight)];
        } completion:^(BOOL finished) {
            [self.moreView removeFromSuperview];
            [self textViewDidChange:self.textView];
        }];
    }
}

- (void)setFrame:(CGRect)frame animated:(BOOL)animated{
    if (animated) {
        [UIView animateWithDuration:.2 animations:^{
            self.frame = frame;
        }];
    }else{
        self.frame = frame;
    }
    if (self.barDelegate!=nil && [self.barDelegate respondsToSelector:@selector(keyboardBar:didChangeFrame:)]) {
        [self.barDelegate keyboardBar:self didChangeFrame:frame];
    }
}

- (void)textBecomeFirstResponder
{
    [_textView becomeFirstResponder];
}

- (void)resignFirstResponder
{
    if (self.type == UIKeyboardChatTypeFace) {
        [self endInput];
    }
//    [self showFaceView:NO];
    [_textView resignFirstResponder];
}

#pragma mark -- 通知操作 --
- (void)addNotification{
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillChangeFrameNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    
}

- (void)removeNotification{
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillChangeFrameNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
}


- (void)keyboardWillShow:(NSNotification *)notification{
    _inputing = YES;
    self.keyboardFrame = [notification.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    [self textViewDidChange:self.textView];
}


- (void)keyboardWillHide:(NSNotification *)notification{
    _inputing = NO;
    self.keyboardFrame = CGRectZero;
    [self textViewDidChange:_textView];
    
}


- (CGFloat)fontWidth
{
    return 36; //15号字体
}

- (CGFloat)maxLines
{
    CGFloat h = [[UIScreen mainScreen] bounds].size.height;
    CGFloat line = 5;
    if (h == 480.0) {
        line = 3;
    }else if (h == 568.0){
        line = 3.5;
    }else if (h == 667.0){
        line = 4;
    }else if (h == 736.0){
        line = 4.5;
    }
    return line;
}


#pragma mark -- 页面刷新 --
- (void)setKeyboardTypes:(NSArray *)keyboardTypes{
    _keyboardTypes = keyboardTypes;
    if (_keyboardTypes) {
        for (id type in _keyboardTypes) {
            NSInteger typeInt = [type integerValue];
            switch (typeInt) {
                case UIKeyboardChatTypeFace:
                    self.showFaceKeyboard = YES;
                    break;
                case UIKeyboardChatTypeMore:
                    self.showMoreKeyboard = YES;
                    break;
                default:
                    break;
            }
        }
        
        [self setNeedsDisplay];
    }
}

- (void)layoutSubviews{
    [super layoutSubviews];
    _moreButton.hidden = !self.showMoreKeyboard;
//    if (_showMoreKeyboard && self.KeyboardMoreImages && self.KeyboardMoreTitles && self.KeyboardMoreTitles.count!=0 && self.KeyboardMoreImages.count!=0) {
//        _moreButton.frame = CGRectMake(MainScreenWidth - 5 - ButtonWidthHeight, self.frame.size.height-5.0-ButtonWidthHeight, ButtonWidthHeight, ButtonWidthHeight);
//    }else{
//        _moreButton.frame = CGRectMake(MainScreenWidth - 5 , self.frame.size.height-5.0-ButtonWidthHeight, 0, 0);
//    }
    CGFloat offset = self.textViewHeight - TextViewHeightNormal;
    if (_faceButton.width == 0 && _moreButton.width == 0) {
        _textView.frame = CGRectMake(CGRectGetMaxX(_faceButton.frame)+7.5, offset/2,_moreButton.frame.origin.x-7.5 - CGRectGetMaxX(_faceButton.frame) , self.frame.size.height - offset);
        
    }else{
        _textView.frame = CGRectMake(CGRectGetMaxX(_faceButton.frame)+7.5, offset/2,MainScreenWidth - 2*(ButtonWidthHeight+20) , self.frame.size.height - offset);
        
    }
    if (!self.showMoreKeyboard) {
        _textView.width = MainScreenWidth - (ButtonWidthHeight+20) - 20;
    }
    _bottomLineView.hidden = YES;
    _bottomLineView.frame = CGRectMake(0, self.frame.size.height - 1.0, self.width, 1);
}


#pragma mark -- UIMoreKeyboardViewDataSource --

- (NSArray *)keyboardMoreViewTitlesOfMoreView:(UIMoreKeyboardView *)keyboard{
    
    return self.KeyboardMoreTitles;
}

- (NSArray *)keyboardMoreViewImageNamesOfMoreView:(UIMoreKeyboardView *)keyboard{
    
    return self.KeyboardMoreImages;
}

#pragma mark -- UIMoreKeyboardViewDelegate --
- (void)keyboard:(UIMoreKeyboardView *)keyboard selectIndex:(NSInteger)itemIndex title:(NSString *)title{
    if (self.barDelegate && [self.barDelegate respondsToSelector:@selector(keyboardBar:moreHandleAtItemIndex:)]) {
        [self.barDelegate keyboardBar:self moreHandleAtItemIndex:itemIndex];
    }
}

#pragma mark -- UIFaceKeyboardViewDelegate --
- (void)faceViewSendFace:(NSString *)faceName{
    
    if ([faceName isEqualToString:@"[删除]"]) {
        NSString * newStr = @"";
        NSLog(@"%lu",(unsigned long)self.textView.text.length);
        NSString *text = self.textView.text;
        if (text.length>0) {
            
            if (text.length >3) {
                if ([UIKeyboardBar stringContainsEmoji:[text substringFromIndex:text.length-1]]) {
                    newStr=[text substringToIndex:text.length-1];
                }else if ([UIKeyboardBar stringContainsEmoji:[text substringFromIndex:text.length-2]]) {
                    newStr=[text substringToIndex:text.length-2];
                }else if ([UIKeyboardBar stringContainsEmoji:[text substringFromIndex:text.length-3]]) {
                    newStr=[text substringToIndex:text.length-3];
                }else  if ([UIKeyboardBar stringContainsEmoji:[text substringFromIndex:text.length-4]]) {
                    newStr=[text substringToIndex:text.length-4];
                }else{
                    newStr=[text substringToIndex:text.length-1];
                }
                
            }else if (text.length >2) {
                
                if ([UIKeyboardBar stringContainsEmoji:[text substringFromIndex:text.length-1]]) {
                    newStr=[text substringToIndex:text.length-1];
                }else if ([UIKeyboardBar stringContainsEmoji:[text substringFromIndex:text.length-2]]) {
                    newStr=[text substringToIndex:text.length-2];
                }else if ([UIKeyboardBar stringContainsEmoji:[text substringFromIndex:text.length-3]]) {
                    newStr=[text substringToIndex:text.length-3];
                }else{
                    newStr=[text substringToIndex:text.length-1];
                }
            }else   if (text.length >1) {
                if ([UIKeyboardBar stringContainsEmoji:[text substringFromIndex:text.length-1]]) {
                    newStr=[text substringToIndex:text.length-1];
                }else if ([UIKeyboardBar stringContainsEmoji:[text substringFromIndex:text.length-2]]) {
                    newStr=[text substringToIndex:text.length-2];
                }else{
                    newStr=[text substringToIndex:text.length-1];
                }
                
            }else {
                
                
                
            }
            
        }
        self.textView.text = newStr;
        [self textViewDidChange:self.textView];
    }else if ([faceName isEqualToString:@"发送"]){
        NSString *text = self.textView.text;
        if (!text || text.length == 0) {
            return;
        }
        self.inputText = @"";
        self.textView.text = @"";
        [self textViewDidChange:self.textView];
        if (self.barDelegate && [self.barDelegate respondsToSelector:@selector(keyboardBar:sendContent:)]) {
            [self.barDelegate keyboardBar:self sendContent:text];
        }
        
    }else{
        self.textView.text = [self.textView.text stringByAppendingString:faceName];
        [self textViewDidChange:self.textView];
    }
    self.inputText = self.textView.text;
}



- (CGFloat)heightForStringWithWidth:(CGFloat)width{
    CGSize sizeToFit = [self.textView sizeThatFits:CGSizeMake(width, MAXFLOAT)];
    if (sizeToFit.height<TextViewHeightNormal) {
        sizeToFit.height = TextViewHeightNormal;
    }
    return sizeToFit.height;
}

#pragma mark -- UITextViewDelegate --

//UITextView自适应高度
- (BOOL)textViewShouldBeginEditing:(UITextView *)textView{
    self.faceButton.selected = self.moreButton.selected = NO;
    _type = UIKeyboardChatTypeKeyboard;
    [self showFaceView:NO];
    [self showMoreView:NO];
    return YES;
}

- (void)textViewDidChange:(UITextView *)textView{
    CGFloat height = [self heightForStringWithWidth:self.textView.width];
    
    CGRect textViewFrame = self.textView.frame;
    CGFloat offset = self.textViewHeight - TextViewHeightNormal;
    CGFloat maxHeight = [self fontWidth] * [self maxLines];
    textView.scrollEnabled = (height + 0.1 > maxHeight-8);
    textViewFrame.size.height = MAX(TextViewHeightNormal, MIN(maxHeight, height));
    
    CGRect addBarFrame = self.frame;
    addBarFrame.size.height = textViewFrame.size.height+offset;
    if (_inputing) {
        addBarFrame.origin.y = MainScreenHeight - self.bottomHeight - addBarFrame.size.height - (self.maxY > 0 ? self.maxY : 0);
        if (self.maxY  > 0 && [UIDevice isIPhoneXFull]) {
            addBarFrame.origin.y = addBarFrame.origin.y + self.maxY;
        }
    }else{
        addBarFrame.origin.y = MainScreenHeight - self.bottomHeight - addBarFrame.size.height - self.maxY;
    }
    if ((_type == UIKeyboardChatTypeFace || _type == UIKeyboardChatTypeMore) && self.maxY  > 0 && [UIDevice isIPhoneXFull]) {
        addBarFrame.origin.y = addBarFrame.origin.y - self.maxY;
    }
    [self setFrame:addBarFrame animated:YES];
    if (textView.scrollEnabled) {
        [textView scrollRangeToVisible:NSMakeRange(textView.text.length - 2, 1)];
    }
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    if ([text isEqualToString:@"\n"]) {
        [self sendTextMessage:textView.text];
        return NO;
    }
    return YES;
}

- (void)sendTextMessage:(NSString *)text{
    if (text) {
        if (self.barDelegate && [self.barDelegate respondsToSelector:@selector(keyboardBar:sendContent:)]) {
            [self.barDelegate keyboardBar:self sendContent:text];
        }
    }
    self.inputText = @"";
    self.textView.text = @"";
    [self textViewDidChange:self.textView];
}

//判断是否是 emoji表情
+ (BOOL)stringContainsEmoji:(NSString *)string
{
    __block BOOL returnValue = NO;
    [string enumerateSubstringsInRange:NSMakeRange(0, [string length]) options:NSStringEnumerationByComposedCharacterSequences usingBlock:
     ^(NSString *substring, NSRange substringRange, NSRange enclosingRange, BOOL *stop) {
         
         const unichar hs = [substring characterAtIndex:0];
         // surrogate pair
         if (0xd800 <= hs && hs <= 0xdbff) {
             if (substring.length > 1) {
                 const unichar ls = [substring characterAtIndex:1];
                 const int uc = ((hs - 0xd800) * 0x400) + (ls - 0xdc00) + 0x10000;
                 if (0x1d000 <= uc && uc <= 0x1f77f) {
                     returnValue = YES;
                 }
             }
         } else if (substring.length > 1) {
             const unichar ls = [substring characterAtIndex:1];
             if (ls == 0x20e3) {
                 returnValue = YES;
             }
             
         } else {
             // non surrogate
             if (0x2100 <= hs && hs <= 0x27ff) {
                 returnValue = YES;
             } else if (0x2B05 <= hs && hs <= 0x2b07) {
                 returnValue = YES;
             } else if (0x2934 <= hs && hs <= 0x2935) {
                 returnValue = YES;
             } else if (0x3297 <= hs && hs <= 0x3299) {
                 returnValue = YES;
             } else if (hs == 0xa9 || hs == 0xae || hs == 0x303d || hs == 0x3030 || hs == 0x2b55 || hs == 0x2b1c || hs == 0x2b1b || hs == 0x2b50) {
                 returnValue = YES;
             }
         }
     }];
    
    return returnValue;
}
@end
