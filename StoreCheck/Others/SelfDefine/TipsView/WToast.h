/**
 * @class WToast
 */

#define RGB(a, b, c) [UIColor colorWithRed:(a / 255.0f) green:(b / 255.0f) blue:(c / 255.0f) alpha:1.0f]
#define RGBA(a, b, c, d) [UIColor colorWithRed:(a / 255.0f) green:(b / 255.0f) blue:(c / 255.0f) alpha:d]


typedef enum{
	//以下是枚举成员
    Success = 0,//操作成功
    Error = 1,//操作失败
    Warning = 2//警告操作
}ToastType;

@interface WToast : UIView
+ (void)showWithText:(NSString *)text forToastType:(ToastType)toastType;
+ (void)showWithText:(NSString *)text;
+ (void)showWithImage:(UIImage *)image;

@end
