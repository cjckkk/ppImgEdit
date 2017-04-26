
//
//  PPRotateTool.m
//  WWImageEdit
//
//  Created by jason on 2017/4/25.
//  Copyright © 2017年 kook. All rights reserved.
//

#import "PPRotateTool.h"
#import "Masonry.h"
#import "UIImage+QMUI.h"
@implementation PPRotateTool
{
    
    UIImage *originImg ;
    UIButton *rotateBtn;
}

+ (NSString*)defaultTitle
{
    return @"rotate";
}

+ (UIImage*)defaultIconImage
{
    return [UIImage imageNamed:@"ToolMasaic"];
}

+ (NSUInteger)orderNum{
    return 5;
}

- (void)cleanup
{
    [rotateBtn removeFromSuperview];
}

- (void)executeWithCompletionBlock:(void (^)(UIImage *, NSError *, NSDictionary *))completionBlock
{

            dispatch_async(dispatch_get_main_queue(), ^{
                    completionBlock(self.editor.imageView.image, nil, nil);

            });
    
}
/*
 * btn  action
 */
-(void)btnTapped:(UIButton *)btn
{
    
    UIImage *img =  [self.editor.imageView.image imageWithOrientation:UIImageOrientationRight];
    self.editor.imageView.image = img;
}


-(void)setup
{
    
    originImg = self.editor.imageView.image;
    rotateBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [rotateBtn setBackgroundColor:[UIColor redColor]];
    [self.editor.view addSubview:rotateBtn];
    [rotateBtn setTitle:@"rotate" forState:0];
    [rotateBtn addTarget:self action:@selector(btnTapped:) forControlEvents:UIControlEventTouchUpInside];
    
    
    [rotateBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.editor.view);
        make.right.equalTo(self.editor.view);
        make.bottom.equalTo(self.editor.view);
        make.height.equalTo(@(44));
    }];
}


@end
