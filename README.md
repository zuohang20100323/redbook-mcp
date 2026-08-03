# 小红书 MCP 远程版（云端部署）

## 改造说明

本仓库是对 [chenningling/Redbook-Search-Comment-MCP2.0](https://github.com/chenningling/Redbook-Search-Comment-MCP2.0) 的云端改造版。

### 主要改动
- `transport='stdio'` → `transport='streamable-http'`（暴露 HTTP 端口供远程连接）
- `headless=False` → 云端默认 `headless=True`（无屏幕环境）
- 新增 `XHS_COOKIE` 环境变量支持（云端无法扫码，改为 Cookie 注入登录态）
- 启动命令：`python xiaohongshu_mcp.py`（默认监听 0.0.0.0:8000）

## 部署到 Railway

1. Fork 本仓库到你的 GitHub
2. 在 Railway 中 New → Deploy from GitHub → 选择本仓库
3. 在 Variables 中添加环境变量：
   - `XHS_COOKIE`: 你的小红书 Cookie（见下方获取方法）
   - `XHS_HEADLESS=true`（默认，可不填）
4. Railway 会自动构建并启动

## 获取 XHS_COOKIE

> 云端无法扫码登录，必须通过 Cookie 注入登录态

1. 在电脑浏览器登录 [www.xiaohongshu.com](https://www.xiaohongshu.com)
2. 按 F12 → Application → Cookies → xiaohongshu.com
3. 复制所有 cookie 的 `name=value; name=value` 格式字符串
4. 粘贴到 Railway 环境变量 `XHS_COOKIE` 中

⚠️ Cookie 有时效性（通常几天至几周），失效后需重新配置。

## 环境变量

| 变量名 | 默认值 | 说明 |
|--------|--------|------|
| XHS_COOKIE | (空) | **必填**。浏览器复制的完整 cookie 字符串 |
| XHS_HEADLESS | true | 云端部署填 true；本地调试可填 false |
| PORT | 8000 | HTTP 服务端口 |
| XHS_HOST | 0.0.0.0 | 监听地址 |

## Kelivo MCP 配置

在 Kelivo MCP 设置界面填入：
- **URL**: `https://你的railway-app.up.railway.app`（结尾不带 /v1，直接填根路径）
- **API Key**: 任意字符串（如 `xhs-mcp-local-key`）
