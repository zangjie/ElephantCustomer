//
//  FeedbackViewController.m
//  ElephantCustomer
//
//  Created by Bge on 2019/3/8.
//  Copyright © 2019 zj. All rights reserved.
//

#import "FeedbackViewController.h"
#import <Masonry/Masonry.h>
#import "FeedbackTableViewCell.h"
#import "Feedback.h"

@interface FeedbackViewController () <UITableViewDelegate, UITableViewDataSource, UITextViewDelegate>

@property (strong, nonatomic, readonly) NSArray<Feedback *> *feedbackArray;
@property (assign, nonatomic) NSInteger selectFeedbackType;

@property (strong, nonatomic) UITableView *feedbackTableView;
@property (strong, nonatomic) UILabel *placeholderLabel;

@end

@implementation FeedbackViewController

- (NSArray<Feedback *> *)feedbackArray {
    return @[[[Feedback alloc] initWithDictionary:@{@"title":@"订单服务", @"content":@"项目服务过程或结果有问题"} error:nil],
             [[Feedback alloc] initWithDictionary:@{@"title":@"系统异常", @"content":@"无法正常使用现有功能、App闪退"} error:nil],
             [[Feedback alloc] initWithDictionary:@{@"title":@"功能需求", @"content":@"现有功能不能满足"} error:nil],
             [[Feedback alloc] initWithDictionary:@{@"title":@"使用建议", @"content":@"有什么意见和建议都告诉我们"} error:nil]];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"意见反馈";
    
    UIBarButtonItem *commitItem = [[UIBarButtonItem alloc] initWithTitle:@"提交" style:UIBarButtonItemStylePlain target:self action:@selector(commitFeedback:)];
    self.navigationItem.rightBarButtonItem = commitItem;
    
    [self initialFeedbackTableView];
    
    //增加监听，当键盘出现或改变时触发
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    
    //增加监听，当键退出时触发
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
}

- (void)initialFeedbackTableView {
    self.feedbackTableView = [UITableView new];
    [self.feedbackTableView setDelegate:self];
    [self.feedbackTableView setDataSource:self];
    [self.feedbackTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [self.view addSubview:self.feedbackTableView];
    [self.feedbackTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(0);
    }];
    
    self.feedbackTableView.tableHeaderView = [self tableviewHeaderView:@"问题类型"];
    self.feedbackTableView.tableFooterView = [self footerView];
}

- (UIView *)footerView {
    UIView *footerView = [UIView new];
    [footerView setFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 300)];
    
    UIView *detailView = [self tableviewHeaderView:@"详细描述"];
    [footerView addSubview:detailView];
    [detailView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.and.right.mas_equalTo(0);
        make.height.mas_equalTo(50);
    }];
    
    UITextView *textView = [UITextView new];
    [textView setDelegate:self];
    [textView setFont:mFont(15)];
    [footerView addSubview:textView];
    [textView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(20);
        make.top.equalTo(detailView.mas_bottom).mas_equalTo(20);
        make.right.and.bottom.mas_equalTo(-20);
    }];
    
    self.placeholderLabel = [UILabel new];
    [self.placeholderLabel setText:@"具体说一说你的问题"];
    [self.placeholderLabel setTextColor:[UIColor darkGrayColor]];
    [self.placeholderLabel setFont:mFont(15)];
    [footerView addSubview:self.placeholderLabel];
    [self.placeholderLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(textView).mas_equalTo(4);
        make.top.equalTo(textView).mas_equalTo(8);
    }];
    
    return footerView;
}

- (UIView *)tableviewHeaderView:(NSString *)headerString {
    UIView *headerView = [UIView new];
    [headerView setFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 50)];
    [headerView setBackgroundColor:UICOLOR_WITH_HEX(0xeef3fd)];
    
    UILabel *titleLabel = [UILabel new];
    [titleLabel setText:headerString];
    [titleLabel setTextColor:UICOLOR_WITH_HEX(0xa0a6b7)];
    [titleLabel setBackgroundColor:[UIColor clearColor]];
    [headerView addSubview:titleLabel];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(20);
        make.top.right.and.bottom.mas_equalTo(0);
    }];
    
    return headerView;
}

- (void)commitFeedback:(id)sender {
    //TODO 提交反馈意见
    NSLog(@"commit feed back");
}

//当键盘出现或改变时调用
- (void)keyboardWillShow:(NSNotification *)aNotification {
    CGRect keyBoardRect=[aNotification.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    CGFloat keyBoardHeight = keyBoardRect.size.height+30;
    [UIView animateWithDuration:[aNotification.userInfo[UIKeyboardAnimationDurationUserInfoKey] floatValue] animations:^{
        self.feedbackTableView.contentInset = UIEdgeInsetsMake(0, 0, keyBoardHeight, 0);
    }];
}

//当键退出时调用
- (void)keyboardWillHide:(NSNotification *)aNotification {
    [UIView animateWithDuration:[aNotification.userInfo[UIKeyboardAnimationDurationUserInfoKey] floatValue] animations:^{
        self.feedbackTableView.contentInset = UIEdgeInsetsZero;
    }];
}

#pragma mark - UITextView delegate
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    self.placeholderLabel.hidden = textView.text.length == 0 ? NO : YES;
    if ([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
        return NO;
    }
    return YES;
}

- (void)textViewDidChange:(UITextView *)textView {
    self.placeholderLabel.hidden = textView.text.length == 0 ? NO : YES;
    if (textView.text.length >= 150) {
        textView.text = [textView.text substringToIndex:150];
    }
}

#pragma mark - UITableView delegate & data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.feedbackArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *reuseIdentifier = NSStringFromClass([FeedbackTableViewCell class]);
    FeedbackTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
    if (!cell) {
        cell = [[FeedbackTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
    }
    
    [cell.titleLabel setText:self.feedbackArray[indexPath.row].title];
    [cell.detailTitleLabel setText:self.feedbackArray[indexPath.row].content];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    //TODO 这里赋值的是index，要改成对应的问题类型值
    self.selectFeedbackType = indexPath.row;
}

@end
