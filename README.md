# FYLUtility
常用类扩展以及工具类


/*

**
**
**
**
**
FYLUtility:(单例)工具类,包含常用工具,以及包含其他类头文件
+:  1.创建label
2.创建btn
3.数据存取(NSUserdefault)
4.加密(md5)
5.时间戳转字符串(@"YYYY-MM-dd HH:mm")
6.获取最上层vc
7.弹出提示框或进度指示(借助其他第三方MB等)
8.检查手机号格式(正则)
9.通过类名字符串创建类(只作用于UIViewController)
-:  1.选择照片或拍照

*****
    *
*****
*
*****
UIView+FYLExt:UIView扩展,增加快速访问属性,以及对象方法

属性:    x,y,w,h,right,bottom,centenX,centerY,size,origin
圆角(fyl_cornerRadius)
边框颜色(fyl_bordColor)
边框宽度(fyl_borderWidth)
方法:    1.移动
2.缩放
3.添加阴影
4.获取view所在的vc
5.删除所有子视图
6.从xib初始化
约束    1.填充父视图
2.参照参考视图内部对齐
3.参照参考视图垂直对齐
4.参照参考视图水平对齐
5.当前视图内,水平平铺控件
6.当前视图内,垂直平铺控件
7.从约束数组中查找指定 attribute 的约束

*****
    *
*****
    *
*****
UIColor+FYLExt:UIColor扩展,增加通过十六进制字符串创建color方法

+:     1.通过十六进制字符串创建color(eg:@"0xffffff")
2.颜色转换为十六进制字符串
3.通过颜色生成UIImage

*   *
*   *
*****
    *
    *
UIButton+FYLExt:UIButton扩展,增加设置btn背景色和字体大小方法

方法:   1.设置字体大小
2.通过UIColor设置背景图片

*****
*
*****
    *
*****
NSString+FYL:NSString扩展,增加快速获取沙盒目录方法

方法:   1.将当前字符串拼接到cache目录后面
2.将当前字符串拼接到doc目录后面
3.将当前字符串拼接到temp目录后面

*****
*
*****
*   *
*****
NSDictionary+FYLLog:NSDictionary扩展,解决控制台打印JSON格式不对的问题


*/
#import "FYLUtility.h"

/*常用宏定义,以后添加*/
