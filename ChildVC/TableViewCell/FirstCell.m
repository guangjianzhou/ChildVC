//
//  FirstCell.m
//  ChildVC
//
//  Created by Mac-Pro on 15-3-5.
//  Copyright (c) 2015年 shy. All rights reserved.
//

#import "FirstCell.h"

@interface FirstCell ()

@property (strong, nonatomic) IBOutlet UIImageView *avatorImageView;
@property (strong, nonatomic) IBOutlet UILabel *nameLabel;


@end

@implementation FirstCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)awakeFromNib
{
    // Initialization code
}

- (void)loadData:(NSIndexPath *)indexPath
{
    self.nameLabel.text = [NSString stringWithFormat:@"%i行",indexPath.row];
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
