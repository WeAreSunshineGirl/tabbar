//
//  UIImage+SunImage.m
//  MLLabel
//
//  Created by user on 17/3/23.
//  Copyright © 2017年 molon. All rights reserved.
//

#import "UIImage+SunImage.h"

@implementation UIImage (SunImage)
+(UIImage *)subimageInRect:(UIImage *)image rect:(CGRect)rect{
    CGImageRef newImageRef = CGImageCreateWithImageInRect(image.CGImage, rect);
    
    UIImage *img = [UIImage imageWithCGImage:newImageRef];
    
    CGImageRelease(newImageRef);
    return img;
}
@end
