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
//		File Name:		HSCSDefinitionListView.m
//		Product Name:    HSCSApp
//		Author:			xuyanzhang@利事果
//		Swift Version:	4.0
//		Created Date:	2019/3/11 3:21 PM
//		
//		Copyright © 2019 利事果.
//		All rights reserved.
// )                                                                  (
//'--------------------------------------------------------------------'
	

#import "HSCSDefinitionListView.h"
#import "HSCSDefinitionListCell.h"
#import "Masonry.h"
#import "AppConst.h"
#import <XyWidget/UIView+Frame.h>
static NSString *cellID = @"HSCSDefinitionListViewCell";
@interface HSCSDefinitionListView()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,copy) UIImageView *bgImageView;

@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,assign)NSInteger selectIndex;//当前选中清晰度

@property(nonatomic,strong)NSDictionary *titleDict;
@end

@implementation HSCSDefinitionListView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.selectIndex = 0;//默认标清
        self.minDefinition = 0;//默认有原画 0
        [self makeUpUI];
        [self makeLayout];
        
    }
    return self;
}

- (void)makeUpUI{
    
    [self addSubview:self.bgImageView];
    [self addSubview:self.tableView];
}

- (void)makeLayout{
    
    [self.bgImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsMake(0, 0, -4, 0));
    }];
}
//MARK: - tableView
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return kVHMovieDefinitionCount-self.minDefinition;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    HSCSDefinitionListCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    cell.titleColor = self.selectIndex == indexPath.row + self.minDefinition ? HEX(@"#BD7F5C"):HEX(@"#1C1E23");
    cell.title = self.titleDict[@(indexPath.row + self.minDefinition)];
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    //4-self.minDefinition 为要显示的清晰度个数
    [self layoutIfNeeded];
    return (self.height-4)/(kVHMovieDefinitionCount-self.minDefinition);
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    self.selectIndex = indexPath.row + self.minDefinition;
    [self.tableView reloadData];
    //选中的清晰度 indexPath.row+self.minDefinition
    if ([self.delegate respondsToSelector:@selector(didDefinitionListView:definition:title:)]) {
        [self.delegate didDefinitionListView:self definition:indexPath.row+self.minDefinition title:self.titleDict[@(self.selectIndex)]];
    }
}

#pragma mark - events respone

- (void)selectWith:(NSInteger)index{
    self.selectIndex = index;
    [self.tableView reloadData];
}

-(void)setMinDefinition:(NSInteger)minDefinition{
    if (minDefinition >= kVHMovieDefinitionCount) {//防止微吼只给清晰度4
        return;
    }
    _minDefinition = minDefinition;
    [self.tableView reloadData];
}

#pragma mark - getters and setters

-(UIImageView *)bgImageView{
    if (_bgImageView == nil) {
        _bgImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
        _bgImageView.image = [UIImage imageNamed:@"watch_live_definition_bg_icon"];
        _bgImageView.alpha = 0.9;
        _bgImageView.userInteractionEnabled = YES;
    }
    return _bgImageView;
}

-(UITableView *)tableView{
    if (!_tableView) {
        _tableView=[[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _tableView.delegate=self;
        _tableView.dataSource=self;
        _tableView.backgroundColor=[UIColor clearColor];
        _tableView.showsVerticalScrollIndicator=NO;
        _tableView.tableHeaderView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 0, CGFLOAT_MIN)];
        _tableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 0, CGFLOAT_MIN)];
        [_tableView registerClass:[HSCSDefinitionListCell class] forCellReuseIdentifier:cellID];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.scrollEnabled = NO;
    }
    return _tableView;
}

-(NSDictionary *)titleDict{
    if (!_titleDict) {
        _titleDict = @{@(0):@"原画",@(1):@"超清",@(2):@"高清",@(3):@"标清"};
    }
    return _titleDict;
}

@end
