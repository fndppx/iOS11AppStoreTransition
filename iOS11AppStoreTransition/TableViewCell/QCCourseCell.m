//
//  QCCourseCell.m
//  QingClassSaas
//
//  Created by weikeyan on 2017/10/10.
//  Copyright © 2017年 QingClass. All rights reserved.
//

#import "QCCourseCell.h"
#import "UIImageView+WebCache.h"
@interface QCCourseCell()
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;

@end
@implementation QCCourseCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    //点击手势
    UITapGestureRecognizer *tapImage = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapImage)];
    [self.imageContentView addGestureRecognizer:tapImage];
    self.headImageView.contentMode = UIViewContentModeScaleAspectFill;
    self.imageContentView.layer.cornerRadius = 5.f;
    self.imageContentView.layer.masksToBounds = YES;
    self.tempView.layer.cornerRadius = 5.f;
    self.tempView.layer.masksToBounds = YES;
    self.priceView.layer.cornerRadius = self.priceView.frame.size.height*0.5;
    self.priceView.layer.masksToBounds = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)layoutSubviews{
    [super layoutSubviews];
   
    [self.headImageView sd_setImageWithURL:[NSURL URLWithString:@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1508999472&di=e8aa5d62d2b19bec67519f7d3071d724&imgtype=jpg&er=1&src=http%3A%2F%2Fimages.17173.com%2F2012%2Fnews%2F2012%2F04%2F27%2Fy0427fc01s.jpg"] placeholderImage:nil];

}
- (void)tapImage {
    if (self.tapCoverImageBlock) {
        self.tapCoverImageBlock(self.indexRow);
    }
}
@end
