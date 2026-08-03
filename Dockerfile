FROM python:3.11-slim

WORKDIR /app

# 安装系统依赖
RUN apt-get update && apt-get install -y --no-install-recommends \
    wget gnupg ca-certificates fonts-liberation libasound2 \
    libatk-bridge2.0-0 libatk1.0-0 libatspi2.0-0 libcups2 \
    libdbus-1-3 libdrm2 libgbm1 libgtk-3-0 libnspr4 libnss3 \
    libwayland-client0 libxcomposite1 libxdamage1 libxfixes3 \
    libxkbcommon0 libxrandr2 xdg-utils && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

# 复制依赖并安装
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# 安装 Playwright Chromium（含系统依赖）
RUN playwright install --with-deps chromium

# 复制应用代码
COPY xiaohongshu_mcp.py .

# 创建数据目录
RUN mkdir -p browser_data data

# 暴露 MCP HTTP 端口
EXPOSE 8000

# 启动服务
CMD ["python", "xiaohongshu_mcp.py"]
