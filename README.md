# asp-playground-sample
AscentStream Platform playground 样例数据构建

## 编译
```mvn clean package```

## 功能
### 样例程序
- 启动命令
  ```
    cd bin/
    sh runserver.sh com.ascentstream.playground.SampleStart
  ```
- 配置
   ```yaml
    clusters:
      - serviceUrl: "broker访问地址"
        serviceHttpUrl: "pulsar admin访问地址"
        token: "token"
        sample.pulsar.namespace: "pulsar样例的命名空间，默认为public/demo"
        # 支持四种CASE，其中ActivityCase为延迟消息（3分钟），BuriedCase为kafka协议。
        case: "OrderCase,NotifyCase,ActivityCase"
  ```
