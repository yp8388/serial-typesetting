# 模板 1：强调竖线 / 对话块

**替代旧写法**：`<div style="border-left:4px solid #00897B;background:#F5FBFA">`

## HTML 模板

```html
<table cellspacing="0" cellpadding="0" border="0" width="100%" style="border-collapse:collapse;margin:20px 0">
  <tr>
    <td width="4" bgcolor="#00897B" style="width:4px;font-size:0;line-height:0">&nbsp;</td>
    <td style="padding:14px 18px;background-color:#F5FBFA;color:#3F3F3F;font-size:15px;line-height:1.9">
      <p style="margin:8px 0;text-indent:0;text-align:justify;color:#3F3F3F;font-size:15px">
        <strong>角色名：</strong>对话内容...
      </p>
    </td>
  </tr>
</table>
```

## 关键点

- 第一列 `width="4" bgcolor="#00897B"` 模拟左侧 4px 主色竖线
- 用 `font-size:0;line-height:0` 避免空隙
- 第二列用 `background-color:#F5FBFA` 模拟浅色背景
- **不加 `border-radius`**（保留方角）
- 整体用 `border-collapse:collapse` 避免表格内缝隙

## 变体

### ⚠️ 默认样式（对话块 / 卷首引线）

- **背景色 `#F5FBFA`**（浅青绿底，视觉对比度足够）
- **文字色 `#3F3F3F`**
- **这是默认值，不要用变体替代**

### 场景/心理描写（仅用于非对话的纯叙述段）

- 背景色调整为更浅的 `#FAFCFC`
- 内容用 `<em>` 斜体
- **注意：这是变体，不是默认。大多数块应使用 #F5FBFA**

### 创作笔记（灰色块）

- 竖线色改为 `#999`
- 背景色改为 `#F0F0F0`
- 顶部加 ⚠️ 标注"以下内容为创作笔记，不用于公众号发布"
