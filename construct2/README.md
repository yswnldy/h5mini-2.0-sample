# Construct 2引擎游戏API使用说明

当前案例使用的是Construct 2 r255版本进行开发。

#### 目录结构描述

	|--construct2                       //Construct 2案例
	   |--h5api                            //4399API库
	   |--h5api.c2addon                    //4399API库打包的组件
	   |--h5mini-2.0-construct2-sample     //使用案例
	   |--README.md                        //本说明文档

## API添加步骤

### 1. 安装API组件

> 拖动 `construct2\h5api.c2addon` 组件文件到你的Construct 2编辑器中，并点击 `Install` 进行组件安装。
> 
> 重启Construct 2编辑器。
> 
> ![组件安装示例。](https://i.imgur.com/gb4xKFQ.jpg)

### 2. 添加API组件

> 在你的游戏场景中右键选择 `Insert new object` ，选择Platform specific列表下的 `H5API` 组件，添加到你的游戏场景中。
>
> H5API组件只能添加一次。
>
>![添加4399API组件](https://i.imgur.com/1FHkmWX.png)

### 3. 使用API

> 根据游戏需求，调用相应的API。
>
> ![使用API](https://i.imgur.com/PiS9zZ3.png)