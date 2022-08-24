//
//                         __   _,--="=--,_   __
//                        /  \."    .-.    "./  \
//                       /  ,/  _   : :   _  \/` \
//                       \  `| /o\  :_:  /o\ |\__/
//                        `-'| :="~` _ `~"=: |
//                           \`     (_)     `/
//                    .-"-.   \      |      /   .-"-.
//.------------------{     }--|  /,.-'-.,\  |--{     }-----------------.
// )                 (_)_)_)  \_/`~-===-~`\_/  (_(_(_)                (
//
//        File Name:       HSCSWatchBackSpeedView.m
//        Product Name:    HSCSApp
//        Author:          xuyanzhang@利事果科技
//        Swift Version:   5.0
//        Created Date:    2021/7/6 5:54 PM
//
//        Copyright © 2021 利事果科技.
//        All rights reserved.
// )                                                                  (
//'--------------------------------------------------------------------'
        

#import "HSCSWatchBackSpeedView.h"
//#import "UIDevice+Mode.h"
#import "Masonry.h"
@interface HSCSWatchBackSpeedView()

@property (nonatomic,strong) NSArray *speedArray;

@end

@implementation HSCSWatchBackSpeedView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self makeUpUI];
//        [self makeLayout];
        self.backgroundColor = HEXA(@"#000000", 0.7);
    }
    return self;
}

- (void)makeUpUI
{
    self.speedArray = @[@"0.5倍速",@"1倍速",@"1.25倍速",@"1.5倍速",@"2倍速"];
}

- (void)makeLayout:(CGFloat)viewHeight
{
    for (UIView *view in self.subviews) {
        if ([view isMemberOfClass:[UILabel class]]) {
            [view removeFromSuperview];
        }
    }
    
    CGFloat height = viewHeight/(self.speedArray.count + 1);
    CGFloat top = height/2;
    CGFloat width = viewHeight > 250 ? 140 : 90;
    CGFloat font = viewHeight > 250 ? 17 : 15;
    CGFloat r = viewHeight > 250 ? 50 : 15;
    for (int i = 0; i<self.speedArray.count; i++) {
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, top + i*height, width - r, height)];
        label.textAlignment = NSTextAlignmentRight;
        label.textColor = [UIColor whiteColor];
        label.font = FONT_PingFang_Regular(font);
        label.text = self.speedArray[i];
        label.tag = 1000 + i;
        label.userInteractionEnabled = YES;
        [self addSubview:label];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
        [label addGestureRecognizer:tap];
    }
}

// MARK: -  events respone

- (void)tapAction:(UITapGestureRecognizer *)ges
{
    NSInteger index = ges.view.tag - 1000;
    !self.speedSelectBlock?:self.self.speedSelectBlock(index);
}

// MARK: -  getters and setters

@end
