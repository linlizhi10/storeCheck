//
//  ListAdjustCell.m
//  StoreCheck
//
//  Created by skunk  on 15/11/24.
//  Copyright (c) 2015年 linlizhi. All rights reserved.
//

#import "ListAdjustCell.h"
#import "ListAdjustModel.h"

@implementation ListAdjustCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)beforeButtonAction:(id)sender {
    self.beforeBlock();
}

- (IBAction)afterButtonAction:(id)sender {
    self.afterBlock();
}

- (IBAction)compareAction:(id)sender {
    self.compareBlock(_beforeImage.image,_afterImage.image);
}

- (void)fillCellWithPhoto:(ListAdjustModel *)adjust
{
    self.listType.text = adjust.item.title;
    if (adjust.photo) {
        if (adjust.photo) {
            if (adjust.photo.imageFile1) {
                NSString *imageName1 = [NSString stringWithFormat:@"%@.jpg",adjust.photo.imageFile1];
                self.beforeImage.image = [UIImage imageWithContentsOfFile:ImagePath(imageName1)];
            }else{
                NSLog(@"no imagefile1");

            }
            if (adjust.photo.imageFile2) {
                NSString *imageName2 = [NSString stringWithFormat:@"%@.jpg",adjust.photo.imageFile2];
                self.afterImage.image = [UIImage imageWithContentsOfFile:ImagePath(imageName2)];
            }else{
                NSLog(@"no imagefile2");
            }
        }else{
            NSLog(@"no photo");
        }
        
    }else{
        self.beforeImage.image = [UIImage imageNamed:@"clickpicture"];
        self.afterImage.image = [UIImage imageNamed:@"clickpicture"];
    }
}
@end
