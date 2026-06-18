# 模板 3：题词区

**替代旧写法**：`<div style="border-top:2px double;border-bottom:2px double;background:...">`

## HTML 模板

```html
<table cellspacing="0" cellpadding="0" border="0" width="100%" style="border-collapse:collapse;margin:32px 0;background-color:#FAFCFC">
  <tr>
    <td style="border-top:2px solid #00897B;border-bottom:2px solid #00897B;padding:24px 16px;text-align:center;color:#666;font-size:13.5px;line-height:1.9;font-style:italic">
      <p style="margin:6px 0;text-indent:0">第一行题词</p>
      <p style="margin:6px 0;text-indent:0">第二行题词</p>
    </td>
  </tr>
</table>
```

## 关键点

- 上下双线从 `double` 改为 `solid`（`double` 微信会简化或丢失）
- `background-color` 放在 `<table>` 上而不是 `<div>` 上（保留率更高）
- 题词内容用 `<p style="text-indent:0">` 避免首行缩进

## 数量要求

- 5-10 行
- 少于 5 行或多于 10 行均不合规
