#  shadowsocks魔改版
https://github.com/gfw-report/shadowsocks-rust

这到底是个啥？请查看 https://github.com/net4people/bbs/issues/136#issuecomment-1279632644

## 服务端部署

### 配置文件 
创建并编辑 `/etc/shadowsocks/server.json`，将下面的配置文件复制粘贴。注意，你需要把里面的`ExamplePassword`替换成一个更强的密码。你可以用以下命令在终端生成一个强密码：`openssl rand -base64 16`。你也应该考虑更改服务器端口`8388`。

```json
{
  "server": "0.0.0.0",
  "server_port": 8388,
  "password": "ExamplePassword",
  "method": "aes-256-gcm"
}
```

### 使用Docker部署
```shell
docker run -d --name ss-gfw-report \
  --restart unless-stopped
  -v /etc/shadowsocks:/etc/shadowsocks \
  liyuanbiao/shadowsocks:gfw-report \
  -c /etc/shadowsocks/server.json 
```

### 使用Docker Compose部署（推荐）
```yaml
version: '3.3'
services:
  shadowsocks:
    image: 'liyuanbiao/shadowsocks:gfw-report'
    container_name: ss-gfw-report
    restart: unless-stopped
    volumes:
      - '/etc/shadowsocks:/etc/shadowsocks'
    command: -c /etc/shadowsocks/server.json
```

### 客户端配置

### 使用Docker部署
```shell
docker run -d --name ss-gfw-report \
  --restart unless-stopped
  --entrypoint=/bin/sslocal
  -v /etc/shadowsocks:/etc/shadowsocks \
  liyuanbiao/shadowsocks:gfw-report \
  -c /etc/shadowsocks/client.json 
```

### 使用Docker Compose部署（推荐）
```yaml
version: '3.3'
services:
  shadowsocks:
    image: 'liyuanbiao/shadowsocks:gfw-report'
    container_name: ss-gfw-report
    restart: unless-stopped
    entrypoint: /bin/sslocal
    volumes:
      - '/etc/shadowsocks:/etc/shadowsocks'
    command: -c /etc/shadowsocks/client.json
```

