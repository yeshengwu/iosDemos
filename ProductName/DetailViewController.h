//
//  DetailViewController.h
//  ProductName
//
//  Created by evan on 15/11/6.
//  Copyright (c) 2015年 evan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailViewController : UIViewController

@property (strong, nonatomic) id detailItem;
@property (weak, nonatomic) IBOutlet UILabel *detailDescriptionLabel;

@end

@interface DetailViewController (Cate1)
@property (strong, nonatomic) NSString  *cate1String;
@end

