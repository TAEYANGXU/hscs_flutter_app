//
//  HSCSDefinitionListCell.m
//  LyCompassForum
//
//  Created by huangjian on 2019/9/9.
//  Copyright © 2019 mlj. All rights reserved.
//

#import "HSCSDefinitionListCell.h"
#import <XyWidget/UIFont+PingFangSC.h>
#import "Masonry.h"

@interface HSCSDefinitionListCell ()
@property(nonatomic,strong)UILabel *titleLabel;
@end
@implementation HSCSDefinitionListCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = [UIColor clearColor];
        [self makeUpUI];
    }
    return self;
}

-(void)setTitle:(NSString *)title{
    _title = title;
    self.titleLabel.text = title;
}
-(void)setTitleColor:(UIColor *)titleColor{
    _titleColor = titleColor;
    self.titleLabel.textColor = titleColor;
}

-(void)makeUpUI{
    UILabel *titleLabel = [[UILabel alloc]init];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.textColor = HEX(@"#1C1E23");
    titleLabel.font = [UIFont PingFangSCMedium:15];
    [self.contentView addSubview:titleLabel];
    self.titleLabel = titleLabel;
    
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(0);
    }];

}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
