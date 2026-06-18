# 模板 4：目录区

**替代旧写法**：`<div style="background;border:1px solid;border-radius:8px">` + `<ul columns:2>`

## HTML 模板

```html
<table cellspacing="0" cellpadding="0" border="0" width="100%" style="border-collapse:collapse;background-color:#F5FBFA;border:1px solid #C8E6E0;margin:24px 0 32px">
  <tr>
    <td style="padding:20px 24px">
      <p style="margin:0 0 12px;font-size:18px;color:#00897B;font-weight:700">本节目录</p>
      <table cellspacing="0" cellpadding="0" border="0" width="100%">
        <tr>
          <td width="50%" style="padding:5px 0;font-size:14px;color:#3F3F3F">一、老赵头敲钟</td>
          <td width="50%" style="padding:5px 0;font-size:14px;color:#3F3F3F">二、古玉异动</td>
        </tr>
      </table>
    </td>
  </tr>
</table>
```

## 关键点

- 边框 `border:1px solid #C8E6E0` 加在 `<table>` 上（外层）
- 内部再用 `<table>` 做分栏（每行 2 列），避免用 `columns` CSS
- **不加 `border-radius`**
- 必须完整列出每节标题，不能只列"一/二/三/..."

## 数量要求

- 完整列出每节标题
- 2 列布局自动分行
