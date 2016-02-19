//
//  ViewController.m
//  MXImageManager
//
//  Created by 牟潇 on 16/2/19.
//  Copyright © 2016年 muxiao. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<UIImagePickerControllerDelegate, UINavigationControllerDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end

@implementation ViewController
- (IBAction)pickPhoto:(UIButton *)sender {
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    [self presentViewController:picker animated:YES completion:nil];
    
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    _imageView.image = image;
    [picker dismissViewControllerAnimated:YES completion:nil];
}
- (IBAction)watermark:(id)sender {
    UIImage *bgImage = _imageView.image;
    UIGraphicsBeginImageContextWithOptions(bgImage.size, NO, 0.0);
    [bgImage drawInRect:CGRectMake(0, 0, bgImage.size.width, bgImage.size.height)];
    
    UIImage *waterImage = [UIImage imageNamed:@"person_icon_vip7@2x"];
    CGFloat scale = 10.0f;
    CGFloat margin = 50.0f;
    CGFloat waterW = waterImage.size.width * scale;
    CGFloat waterH = waterImage.size.height * scale;
    CGFloat waterX = bgImage.size.width - waterW - margin;
    CGFloat waterY = bgImage.size.height - waterH - margin;
    
    [waterImage drawInRect:CGRectMake(waterX, waterY, waterW, waterH)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    self.imageView.image = newImage;
    NSString *filePath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
    NSString *imagePath = [filePath stringByAppendingString:@"/water.png"];
    NSData *data = UIImagePNGRepresentation(newImage);
    [data writeToFile:imagePath atomically:YES];
    

}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
