//
//  UIImage+Compress.m
//  StoreCheck
//
//  Created by skunk  on 15/11/23.
//  Copyright (c) 2015年 linlizhi. All rights reserved.
//

#import "UIImage+Compress.h"

@implementation UIImage (Compress)

/** 颜色变化 */
void ProviderReleaseData (void *info, const void *data, size_t size)
{
    free((void*)data);
}

+ (UIImage*)imageWithImageSimple:(UIImage*)image{
    
    NSData *data1 = UIImageJPEGRepresentation(image, 0.5);
    NSUInteger dataLength1 = [data1 length];
    
    //CGFloat MAX_IMAGEPIX = 320.0;
    //CGFloat width = image.size.width;
    //    CGFloat height = image.size.height;
    
    //    if (width <= MAX_IMAGEPIX) {
    //        return image;
    //    }
    
    //缩放比例
    //    CGFloat scaleFactor = MAX_IMAGEPIX / width;
    
    CGSize newSize = CGSizeMake(240, 320);
    //    CGSize newSize = CGSizeMake(width*scaleFactor, height*scaleFactor);
    
    // Create a graphics image context
    UIGraphicsBeginImageContext(newSize);
    // Tell the old image to draw in this new context, with the desired
    // new size
    [image drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
    // Get the new image from the context
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    // End the context
    UIGraphicsEndImageContext();
    // Return the new image.
    
    UIImagePNGRepresentation(image);
    
    //获取压缩后的大小
    NSData *data = UIImageJPEGRepresentation(newImage, 1.0);
    NSUInteger dataLength = [data length];
    
    //如果压缩后还要大于1M 质量上在压缩
    //    if (dataLength > 1204 * 1204) {
    //        newImage = [UIImage imageWithData:UIImageJPEGRepresentation(newImage, 0.6)];
    //    }
    
    
    
    
    newImage = [UIImage imageWithData:UIImageJPEGRepresentation(newImage, 0.6)];
    NSLog(@"==图片压缩========后：%lu===前：%lu=========",(unsigned long)dataLength,(unsigned long)dataLength1);
    
    return newImage;
}

+ (UIImage *)imageToTransparent:(UIImage *)image
{
    //分配内存
    const int imageWidth = image.size.width;
    const int imageHeight = image.size.height;
    size_t bytesPerRow = imageWidth * 4;
    uint32_t *rgbImageBuf = (uint32_t *)malloc(bytesPerRow * imageHeight);
    //创建context
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGContextRef context = CGBitmapContextCreate(rgbImageBuf, imageWidth, imageHeight, 8, bytesPerRow, colorSpace, kCGBitmapByteOrder32Little|kCGImageAlphaNoneSkipFirst);
    CGContextDrawImage(context, CGRectMake(0, 0, imageWidth, imageHeight), image.CGImage);
    
    //遍历像素
    int pixelNum = imageWidth * imageHeight;
    uint32_t *pCurPtr = rgbImageBuf;
    for (int i = 0; i < pixelNum; i++, pCurPtr++) {
        //把绿色变成黑色，把背景色变成透明
        if ((*pCurPtr & 0x65815A00) == 0x65815a00) {
            uint8_t *ptr = (uint8_t *)pCurPtr;
            ptr[0] = 0;
        }else if ((*pCurPtr & 0x00FF0000) == 0x00ff0000)//将绿色变为黑色
        {
            uint8_t *ptr = (uint8_t *)pCurPtr;
            ptr[3] = 0; //0-255
            ptr[2] = 0;
            ptr[1] = 0;
        }else if ((*pCurPtr & 0xFFFFFF00) == 0xffffff00) //白色变成透明色
        {
            uint8_t *ptr = (uint8_t *)pCurPtr;
            ptr[0] = 0;
        }else{
            //改成下面的代码，会将图片转成想要的颜色
            uint8_t *ptr = (uint8_t *)pCurPtr;
            ptr[3] = 0;
            ptr[2] = 0;
            ptr[1] = 0;
        }
    }
    
    //将内存转成image
    CGDataProviderRef dataProvider = CGDataProviderCreateWithData(NULL, rgbImageBuf, bytesPerRow * imageHeight, ProviderReleaseData);
    CGImageRef imageRef = CGImageCreate(imageWidth, imageHeight, 8, 32, bytesPerRow, colorSpace, kCGImageAlphaLast|kCGBitmapByteOrder32Little, dataProvider, NULL, true, kCGRenderingIntentDefault);
    
    CGDataProviderRelease(dataProvider);
    UIImage *resultUIImage = [UIImage imageWithCGImage:imageRef];
    //释放
    CGImageRelease(imageRef);
    CGContextRelease(context);
    CGColorSpaceRelease(colorSpace);
    return resultUIImage;
}



@end
