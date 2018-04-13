# cocos2dx 引擎游戏API使用说明

感谢CocosCreator插件开发者 `许彦峰(xu_yanfeng@qq.com)` 提供帮助。

当前案例使用的是CocosCreator v1.9.0版本进行开发。

#### 目录结构描述

	|--cocos2dx                       //Construct 2案例
	   |--js-sample                      //API使用案例
	   |--plugin-4399-h5api              //4399插件库
	   |--README.md                      //本说明文档

## API添加步骤

### 1、安装API插件

> 在CocosCreator编辑器内选择 `扩展\扩展商店` ，选择 `4399原创平台H5API插件` 并下载安装。

### 2、构建项目与添加API

> 首先对你游戏的项目进行构建。
> 
> 完成构建后，选择 `扩展\plugin-4399-h5api` ，打开API插件面板，选择添加4399SDK。
>
> 生成结果通过控制层输出提示，如生成失败请根据提示调整。
>
> 此插件本质上只是处理执行文本添加步骤，在发布后的index.html模板里增加了原创平台H5API的地址。
> 
> ![添加4399SDK](https://i.imgur.com/qaMb8LK.png)

### 3、使用API

> API使用上与原生JS一致，具体使用方法请参照官方文档 [http://www.4399api.com/res/api/html5](http://www.4399api.com/res/api/html5 "H5API文档") 。
>
> 如图所示：
>  
> ![提交分数](https://i.imgur.com/LwGfthL.png)