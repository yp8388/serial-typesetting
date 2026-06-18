# 模板 5：配图 + 图注

**替代旧写法**：`<img style="box-shadow:0 2px 10px rgba(...)">`

## HTML 模板

```html
<table cellspacing="0" cellpadding="0" border="0" width="100%" style="border-collapse:collapse;margin:36px 0">
  <tr>
    <td align="center" style="padding:0">
      <img src="https://s.coze.cn/image/xxx/" alt="配图说明" style="width:100%;max-width:680px;display:block">
    </td>
  </tr>
  <tr>
    <td style="padding:8px 0 0;text-align:center;font-size:12px;color:#999;font-style:italic">—— 图说文字</td>
  </tr>
</table>
```

## 关键点

- **去掉 `box-shadow`**（必丢）
- **不加 `border-radius`**（必丢）
- `display:block` 在微信中部分支持，保留不删
- 图说和图片用 `<table>` 两行布局，不用 `<div>` 嵌套
- `img` 必须用云端绝对 URL（`file_to_url` 转换）

## 配图位置原则

- 每张图嵌入到描述该场景的**正文中段**（紧跟该场景的描写段后）
- 不是节首/节末堆放
- 配图数量 = 节数 + 1（封面）
