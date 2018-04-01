# SGURLSessionTask

   ![language](https://img.shields.io/badge/language-Object--C-orange.svg)[![Support](https://img.shields.io/badge/support-iOS%208.0%2B%20-blue.svg?style=flat)](https://www.apple.com/nl/ios/)&nbsp;![CocoPods](https://img.shields.io/badge/cocopods-v1.0-green.svg)&nbsp;[![License MIT](https://img.shields.io/badge/license-MIT-green.svg?style=flat)](https://github.com/sylphghost/SGURLSessionTask/blob/master/LICENSE)&nbsp;

**An easy-to-use network encapsulation for iOS projects. you can quickly integrate with the project, and most importantly, you can reduce the time it takes to connect to the server interface and save time to do something meaningful.**

```
SGURLSessionTask *task = [SGURLSessionTask new];
task.externalURL(@"/api/xxx").then(^(SGBaseResponse *response) {
        //do something...
    }).catchError(^(NSError *error) {
        //do something...
    }).resum();

```
#### **SGURLSessionTask is based on [AFNetWorking-3.0](https://github.com/AFNetworking/AFNetworking) and [YYModel](https://github.com/ibireme/YYModel), [PromiseKit](https://github.com/mxcl/PromiseKit) but you can easily switch to other corresponding frameworks.**





# Usage
### Configuration
open SGURLTaskConfigure.h file,Fill in the server's default path to the variable **SGDefaultMainURL**。

```
static NSString * const SGDefaultMainURL = @"your server IP ";
```

 and if you want to support HTTPS, fill in the name of the .cer file to the variable **SGHttpsCerFieldName**.

```
static NSString * const SGHttpsCerFieldName = @"your .cer file name";
```
If the format of your backend interface is the same as mine, there is a fixed error code and information field. Congratulations, the network request I encapsulated is perfect for you.
Change the error code and message prompt fields to the fields corresponding to your background interface.

```
static NSString * const SGErrorCodeKey = @"your errorCode field";
static NSString * const SGErrorMsgKey = @"your  message field";
```

### Create a request
If we have a POST request, the server address is https://xxx.xxx.x.x.x, and the subpath is /api/xxx, and the request parameter is {flag:test}. Use SGURLSessionTask to create a request like this.

```
SGURLSessionTask *task = [SGURLSessionTask new];

task.mainURL(@"https://xxx.xxx.x.x.x").externalURL(@"/api/xxx").httpType(POST).parameters(^NSDictionary *{
        return @{flag:test};
    }).progress(^(NSProgress *progress) {
        
    }).then(^(SGBaseResponse *response) {
        // request is successful
    }).catchError(^(NSError *error) {
        // The request failed
    });
```
***The default main path for SGURLTaskSession is the SGDefaultMainURL field definition, and the default is the Get method. So in most cases the mainURL() function is not required.***


### Configure the global request parameters
In the SGURLTaskConfigure.m file, the _intialization() function, you can configure the global Request Request Headers and Request parameters.

```
    self.headerParameters = @{}.mutableCopy;
    self.parameters=@{}.mutableCopy;
```
### Catch the global request error
Monitor the **SGURLSessionTaskErrorNotifaction** notice. You can get all the SGURLSessionTask errors.
### Update or replace [AFNetWorking-3.0](https://github.com/AFNetworking/AFNetworking) and [YYModel](https://github.com/ibireme/YYModel)
To update or replace the other network request framework, you only need to change the **-(PMKPromise *)_resume** function in the **SGURLSessionTask.m** file.
Update or replace [YYModel](https://github.com/ibireme/YYModel), you just need to change the SGURLTaskConfigure.
**- (id)responseFromJsonDic** function. 
# Installation
#### CocoaPods
1. Add pod 'SGURLSessionTask' to your Podfile.
2. Run pod install or pod update.
3. Import \<SGURLSessionTask/SGURLSessionTask.h\>.

# License
SGURLSessionTask is provided under the MIT license. See LICENSE file for details.

# 中文版说明
**这是一个对iOS项目网络请求的中间层封装，可以快速的集成到项目中。使用SGURLSessionTask可以很快的对接后台接口，大大减少对接接口的时间。**

```
SGURLSessionTask *task = [SGURLSessionTask new];
task.externalURL(@"/api/xxx").then(^(SGBaseResponse *response) {
        //do something...
    }).catchError(^(NSError *error) {
        //do something...
    }).resum();

```
#### **SGURLSessionTask 是基于 [AFNetWorking-3.0](https://github.com/AFNetworking/AFNetworking) 、 [YYModel](https://github.com/ibireme/YYModel)、 [PromiseKit](https://github.com/mxcl/PromiseKit)这三个框架，但是如果你不喜欢你也可以轻易的换成其他相对应的框架**
# 使用方法
### 配置
打开 SGURLTaskConfigure.h 文件，填写服务器主地址**SGDefaultMainURL**

```
static NSString * const SGDefaultMainURL = @"服务器地址 ";
```
如果您的服务器支持HTTPS,那就将.cer文件放进工程，然后将.cer文件的名称填写到**SGHttpsCerFieldName**

```
static NSString * const SGHttpsCerFieldName = @".cer的文件名字";
```
如果你的后台基本请求跟我一样，固定有两个errorCode和errorMsg，用于判断请求成败和信息提示，那请填写上您的服务器的对应字段。

```
static NSString * const SGErrorCodeKey = @"错误码名称";
static NSString * const SGErrorMsgKey = @"信息提示名称";
```

### 创建一个请求
现在有一个POST请求,服务器地址为https://xxx.xxx.x.x.x 子路径是/api/xxx,请求参数是{flag:test},用SGURLSessionTask可以这么创建请求。

```
SGURLSessionTask *task = [SGURLSessionTask new];

task.mainURL(@"https://xxx.xxx.x.x.x").externalURL(@"/api/xxx").httpType(POST).parameters(^NSDictionary *{
        return @{flag:test};
    }).progress(^(NSProgress *progress) {
        
    }).then(^(SGBaseResponse *response) {
        // request is successful
    }).catchError(^(NSError *error) {
        // The request failed
    });
```
***SGURLSessionTask的默认路径是SGDefaultMainURL，一般是不用改变的，如果你有多个服务器路径，可以用几个不同Category方法来进行配置。管理接口请求，建议使用SGURLSessionTask的Category进行管理，就像Demo里面一样***


### 配置全局请求参数
通过配置SGURLTaskConfigure.m里面_intialization()方法，你可以设置全局的请求头和请求参数

```
    self.headerParameters = @{}.mutableCopy;
    self.parameters=@{}.mutableCopy;
```
### 捕捉全局请求错误
监听通知**SGURLSessionTaskErrorNotifaction** ,你可以获取到所有请求发生的错误。

### 更新或者替换 [AFNetWorking-3.0](https://github.com/AFNetworking/AFNetworking) 和 [YYModel](https://github.com/ibireme/YYModel)
更新或者替换 [AFNetWorking-3.0](https://github.com/AFNetworking/AFNetworking) 你只需要修改一下SGURLSessionTask.m中的(PMKPromise *)_resume方法。

更新或者替换[YYModel](https://github.com/ibireme/YYModel),你只需要修改一下SGURLTaskConfigure的**- (id)responseFromJsonDic**方法
# 安装
#### CocoaPods

1. Podfile加上pod 'SGURLSessionTask'
2. 运行 pod install 或者 pod update.
3. 在需要使用的文件import \<SGURLSessionTask/SGURLSessionTask.h\>.

