# 模板 2：章节大标题 + 数字徽章（v3.3 方案 A）

**替代旧写法**：`<h2 style="display:inline-block;border:1px solid #00897B;box-shadow:...">`

## v3.3 方案 A

数字徽章与章节名一体，单 `p` 容器：

```html
<p style="margin:48px 0 0;line-height:1.4;border-left:5px solid #00897B;padding:6px 0 6px 12px">
  <span style="font-size:18px;color:#00897B;font-weight:700;margin-right:10px;vertical-align:middle">一</span>
  <span style="font-size:22px;color:#263238;font-weight:700;vertical-align:middle">老赵头敲钟</span>
</p>
```

## 关键点

- 一条竖线、视觉连贯（v3.2 是两条独立竖线，v3.3 合并）
- 数字 18px 青绿 + 章节名 22px 黑色加粗
- `vertical-align:middle` 对齐数字和文字
- p 容器 `margin-top:48px` 控制章节间距
- **不依赖 `display:inline-block` 和 `<table>`**（公众号环境两者都过滤/拉满）

## 与 v3.2 旧版对比

| 写法 | 视觉 | 微信公众号兼容性 |
|------|------|-----------------|
| v3.2 双独立 p | 两条竖线、视觉割裂 | 一般 |
| v3.3 方案 A | 一条竖线、整体连贯 | **优秀** |
