# 模板 8：场景转换 dinkus

**替代旧写法**：`<div style="text-align:center;letter-spacing:8px">∗ ∗ ∗</div>`

## HTML 模板

```html
<p style="text-align:center;margin:28px 0;color:#00897B;font-size:16px;letter-spacing:8px">∗  ∗  ∗</p>
```

## 关键点

- 从 `<div style="text-align:center">` 改为 `<p style="text-align:center">`（`<p>` 比 `<div>` 微信兼容性更好）
- 用于场景/时间/视角跳转处
- 数量要求：每节 ≥ 1 个
