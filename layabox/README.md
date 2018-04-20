# layabox引擎游戏API使用说明

当前案例使用的是LayaAir 1.7.17版本进行开发。

#### 目录结构描述

	|--layabox                            //layabox案例
	   |--h5mini-2.0-layabox-as-sample       //as案例
	   |--h5mini-2.0-layabox-js-sample       //js案例
	   |--h5mini-2.0-layabox-ts-sample       //ts案例
	   |--README.md                          //本说明文档

## API添加步骤

### 1. 添加H5API的地址

> 在你游戏项目下，打开 `bin\index.html` 页面模板，将H5API的地址 `http://stat.api.4399.com/h5api/h5api.php` 加入到 `<head></head>` 标签内。
> 
    <script src="http://stat.api.4399.com/h5api/h5api.php"></script> 
> 
> 如下图
> 
![添加H5API地址](https://i.imgur.com/uvxW7G7.png)

### 2、使用API

#### AS/JS/TS

> H5API通过js与layabox引擎交互， 使用上可根据各语言不同，参考官方调用第三方JS的文档，调用layabox提供的js通用代码。
> 
> 如以下为AS案例：
> 
> ![使用API](https://i.imgur.com/YJuwqn9.png)