## 项目概述
品牌官网单页（樱花动漫），提供 APP 下载入口与动漫内容介绍。纯静态 HTML 单页站，主打 SEO 优化（JSON-LD 结构化数据、Open Graph、关键词布局等）。

## 技术栈
- 纯静态 HTML + 内联 CSS/JS，无框架、无构建工具、无 package.json
- 运行时：Python 3.12（用 `python3 -m http.server` 承载静态文件）
- 外部资源内联于 `index.html`，logo 存于项目根

## 目录结构
- `index.html` —— 唯一页面入口（约 1.9MB，含全部内联资源）
- `logo.png` —— 品牌 Logo
- `robots.txt` / `sitemap.xml` —— SEO 文件
- `scripts/build.sh` —— 预览/部署共用 build（静态站点仅校验入口存在）
- `scripts/run.sh` —— 预览/部署共用 run（`python3 -m http.server` 于 5000 端口）

## 关键入口 / 核心模块
- 页面入口：`index.html`
- 静态服务启动：`python3 -m http.server 5000 --bind 0.0.0.0 --directory <project_root>`

## 运行与预览
- 预览型：是（`preview_enable = "enabled"`）
- `.coze` 单层结构，`[subprojects].path = ["."]`，端口由 `.preview` 的 `expose_port = 5000` 声明
- 使用 `general-deploy` 以 service kind（flavor=web）承载静态站点
- 拉起预览：`bash scripts/run.sh`（后台运行，绑定 0.0.0.0:5000）

## 用户偏好与长期约束
- 单产物单预览，对外只暴露 5000，禁止 hardcode，不碰 9000
- Node 依赖一律 pnpm（本项目无 Node 依赖）

## SEO 要点（当前已配置）
- 下载入口链接固定为 `https://qjj.pxxpxxpxx.com/yg-api/download/r/x3Wz72E2`（Android/iOS 两个下载按钮共用）
- head 已含完整 SEO 标注：meta description/keywords、canonical、Open Graph（含 `og:site_name`/`og:image`/`og:image:alt`）、Twitter Card（含 `twitter:image`）、JSON-LD（SoftwareApplication、Organization、FAQPage）
- `robots.txt` 已配置 `Allow: /` 全开放抓取，并声明 sitemap；`sitemap.xml` 覆盖首页与各锚点区块
- 品牌站域名 `www.yinghuadm.com`，OG 图片指向 `https://www.yinghuadm.com/logo.png`

## 常见问题和预防
- `index.html` 体积大，编辑时注意避免破坏内联资源结构
- 更换下载地址时，同步替换两处 `<a href="...">下载安装</a>` 链接（Android、iOS 卡片各一处）