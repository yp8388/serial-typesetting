# 6 项 grep 自检

交付前必跑，目标：前 6 项 = 0，第 7 项 > 10。

## 命令

```bash
grep -ca "box-shadow" file.html         # 应为 0
grep -ca "class=" file.html             # 应为 0
grep -ca "border-radius" file.html      # 应为 0
grep -ca "display:inline-block" file.html  # 应为 0
grep -ca '<div[^>]*border-left' file.html  # 应为 0
grep -ca '<hr' file.html                # 应为 0
grep -ca '<table' file.html             # 应 > 10
```

## 关键规则

### 1. 加 `-a` 强制文本处理

HTML 含二进制字符时必须加 `-a`，否则 grep 会报"二进制文件匹配"。

### 2. 全文档覆盖（前 3 项）

`box-shadow` / `border-radius` / `display:inline-block` 的命中检查是全文档搜索——**注释、说明文字、创作笔记中也绝对不能出现**这三个字符串，否则计数 > 0 不通过。

**解决方案**：用中文描述代替。

- ❌ `box-shadow` → ✅ "阴影属性"
- ❌ `border-radius` → ✅ "圆角属性"
- ❌ `display:inline-block` → ✅ "分栏属性"

### 3. 公众号代码文件末尾不放自检块

6 项 grep 自检命令**不得放在公众号代码 `.md` 文件末尾**，会触发误判（命令本身的字符串被计入）。应写在升级说明 `.md` 中。

## 自检流程

1. 交付前跑 6 项命令，记录结果。
2. 任意一项不达标 → 立即修复并重新自检。
3. 自检命令应同步记录到 `升级说明_{章节}_{版本}.md` 中，便于审计。
