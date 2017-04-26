
//
//  PPFilterTool.m
//  PPimgEdit
//
//  Created by jason on 2017/4/26.
//  Copyright © 2017年 jason. All rights reserved.
//

#import "PPFilterTool.h"
#import "FWApplyFilter.h"
#import "FWEffectBar.h"
#import "Masonry.h"
#import "UIImage+ImageScale.h"
#define kWidth 50
#define kHeight 70
#define kSpace 22

@interface PPFilterTool ()<FWEffectBarDelegate>

@property (nonatomic, strong) FWEffectBar *filterStyleBar;
/*
 * origin img source
 */
@property (nonatomic, strong) UIImage  *image;
/*
 *  image  after  process
 */
@property (nonatomic, strong) UIImage  *currentImage;


@end


@implementation PPFilterTool
{
    UIImage *originImg ;
    UIButton *rotateBtn;
}

+ (NSString*)defaultTitle
{
    return @"filter";
}

+ (UIImage*)defaultIconImage
{
    return [UIImage imageNamed:@"ToolMasaic"];
}

+ (NSUInteger)orderNum{
    return 6;
}

- (void)cleanup
{
    [self.filterStyleBar removeFromSuperview];
}

- (void)executeWithCompletionBlock:(void (^)(UIImage *, NSError *, NSDictionary *))completionBlock
{
    
    dispatch_async(dispatch_get_main_queue(), ^{
        completionBlock(self.currentImage, nil, nil);
        
    });
    
}
/*
 * btn  action
 */
-(void)btnTapped:(UIButton *)btn
{
    

}

/*
 *   init  subview
 */
-(void)setup
{
    self.currentImage = self.image  = self.editor.imageView.image;
    self.filterStyleBar = [[FWEffectBar alloc] init];
    self.filterStyleBar.effectBarDelegate = self;
    self.filterStyleBar.itemBeginX = 15.0;
    self.filterStyleBar.itemWidth = 50.0;
    self.filterStyleBar.margin = 10.0;
    [self.editor.view addSubview:self.filterStyleBar];
    
    [self.filterStyleBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.editor.view);
        make.bottom.equalTo(self.editor.view).with.offset(-10);
        make.right.equalTo(self.editor.view);
        make.height.equalTo(@(70));

    }];
    
    [self setupLOMOFilter];
    
}
- (void)setupFilterWithNormalImages:(NSArray *)normalImages HighlightImages:(NSArray *)highlightImages titles:(NSArray *)titles
{
    FWEffectBarItem *item = nil;
    NSMutableArray *items = [[NSMutableArray alloc] initWithCapacity:0];
    
    for (int i = 0; i < [titles count]; i++)
    {
        item = [[FWEffectBarItem alloc] initWithFrame:CGRectMake((kWidth + kSpace) * i + 10, 0, kWidth, kHeight)];
        item.titleOverlay = YES;
        item.backgroundColor = [UIColor blackColor];
        UIImage *img = [UIImage scaleImage:self.image targetHeight:70];
        
        [item setFinishedSelectedImage:img withFinishedUnselectedImage:img];
        item.title = [NSString stringWithFormat:@"%i",i];
        item.title = titles[i];
        
        [items addObject:item];
    }
    
    self.filterStyleBar.items = items;
}

//简单边框视图
- (void)setupLOMOFilter
{
    [self setupFilterWithNormalImages:nil HighlightImages:nil titles:[NSArray arrayWithObjects:@"原图", @"经典LOMO", @"流年", @"HDR", @"碧波", @"上野", @"优格", @"彩虹瀑", @"云端", @"淡雅", @"粉红佳人", @"复古", @"候鸟", @"黑白", @"一九〇〇", @"古铜色", @"哥特风", @"移轴", @"TEST1", @"TEST2", @"TEST3", nil]];
}



#pragma mark - FWEffectBarDelegate
- (void)effectBar:(FWEffectBar *)bar didSelectItemAtIndex:(NSInteger)index
{
    FWEffectBarItem *item = (FWEffectBarItem *)[bar.items objectAtIndex:index];
    item.ShowBorder = YES;
    [self.filterStyleBar scrollRectToVisible:item.frame  animated:YES];
    
    switch (index) {
        case 0:
            self.currentImage = self.image;
            break;
            
        case 1:
            self.currentImage= [FWApplyFilter applySketchFilter:self.image];
            break;
            
        case 2:
            self.currentImage = [FWApplyFilter applySoftEleganceFilter:self.image];
            break;
            
        case 3:
            self.currentImage =[FWApplyFilter applyMissetikateFilter:self.image];
            break;
            
        case 4:
            self.currentImage =[FWApplyFilter applyNashvilleFilter:self.image];
            break;
            
        case 5:
            self.currentImage =[FWApplyFilter applyLordKelvinFilter:self.image];
            break;
            
        case 6:
            self.currentImage = [FWApplyFilter applyAmatorkaFilter:self.image];
            break;
            
        case 7:
            self.currentImage = [FWApplyFilter applyRiseFilter:self.image];
            break;
            
        case 8:
            self.currentImage= [FWApplyFilter applyHudsonFilter:self.image];
            break;
            
        case 9:
            self.currentImage = [FWApplyFilter applyXproIIFilter:self.image];
            break;
            
        case 10:
            self.currentImage =[FWApplyFilter apply1977Filter:self.image];
            break;
            
        case 11:
            self.currentImage =[FWApplyFilter applyValenciaFilter:self.image];
            break;
            
        case 12:
            self.currentImage =[FWApplyFilter applyWaldenFilter:self.image];
            break;
            
        case 13:
            self.currentImage = [FWApplyFilter applyLomofiFilter:self.image];
            break;
            
        case 14:
            self.currentImage = [FWApplyFilter applyInkwellFilter:self.image];
            break;
            
        case 15:
            self.currentImage= [FWApplyFilter applySierraFilter:self.image];
            break;
            
        case 16:
            self.currentImage = [FWApplyFilter applyEarlybirdFilter:self.image];
            break;
            
        case 17:
            self.currentImage =[FWApplyFilter applySutroFilter:self.image];
            break;
            
        case 18:
            self.currentImage =[FWApplyFilter applyToasterFilter:self.image];
    
            break;
            
        case 19:
            self.currentImage =[FWApplyFilter applyBrannanFilter:self.image];
            break;
            
        case 20:
            self.currentImage = [FWApplyFilter applyHefeFilter:self.image];
            break;
    }
    
    self.editor.imageView.image = self.currentImage;
    
}

@end
