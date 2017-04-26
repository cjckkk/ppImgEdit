//
//  ViewController.m
//  PPimgEdit
//
//  Created by jason on 2017/4/25.
//  Copyright © 2017年 jason. All rights reserved.
//

#import "ViewController.h"
#import "Masonry.h"
#import "PPFiltersViewController.h"
#import "KKImageEditorViewController.h"
@interface ViewController ()<UIScrollViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate,KKImageEditorDelegate>{
    UIImagePickerController *imagePicker;

}
@property (nonatomic,strong) IBOutlet UIButton *editBtn;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    
    
    
    
    
}
-(IBAction)editImg:(UIButton *)sender
{
    sender.selected = !sender.selected;
}

-(IBAction)choiceimg:(id)sender
{

        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary])
        {
            imagePicker = [[UIImagePickerController alloc] init];
            
            imagePicker.delegate = self;
            imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            [self presentViewController:imagePicker animated:YES completion:^{
                [[UIApplication sharedApplication] setStatusBarHidden:YES];
                
            }
             ];
        }
}

#pragma mark - UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIImage *selectedImage = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
//   PPFiltersViewController  *beautyVC = [[PPFiltersViewController alloc] initWithImage:selectedImage];
    
    KKImageEditorViewController *editor = [[KKImageEditorViewController alloc] initWithImage:selectedImage delegate:self];

//    [imagePicker pushViewController:beautyVC animated:YES];
    [imagePicker pushViewController:editor animated:YES];

    
}
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [self dismissViewControllerAnimated:imagePicker completion:^{
        
    }];
}


@end
