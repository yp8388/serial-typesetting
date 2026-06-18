# convert_inline.py v4 坑点

`convert_inline.py` 是将 `<style>` 块转换为全内联样式 HTML 的核心脚本，云端版本实际为 v4（"v5 修复版"指 v4，无需升级），已含 `@media` 块 bug 修复。

## 坑点 1：CSS 注释 bug

**问题**：`/* 改进X：... */` 注释紧跟选择器时，`split('}')` 后注释会与选择器合并。

**解决**：**必须删除 `<style>` 块内所有 `/* 改进X */` 注释**。

## 坑点 2：后代选择器不支持 `tag .class` 形式

**问题**：只支持 `.ancestor .descendant` 全 class 形式，不识别 `h2 .num`。

**解决**：改为 `.num`（避免使用标签+类名的后代选择器）。

## 坑点 3：max-width 替换仅作用于 `<body>`

**问题**：容器 `720px` → `677px` 替换仅作用于 `<body>` 元素。

**影响**：公众号代码版（内联版）无 `<body>` 时不受影响，可忽略。

## 实战流程

```bash
# 1. 准备源 HTML（含 <style> 块 + class）
# 2. 手动删除 <style> 块内所有 /* 注释 */
# 3. 检查后代选择器是否用了 tag .class 形式
# 4. 运行 convert_inline.py
python convert_inline.py source.html output_inline.html
# 5. 6 项 grep 自检
grep -ca "class=" output_inline.html  # 应为 0
```

## v3.3 阶段补充

- 实际使用中，**v3.3 已直接采用全内联写法**，不再依赖 convert_inline.py 的批量转换。
- 写 HTML 时直接给每个标签写 `style="..."` 即可。
- 此工具仅作为历史经验保留，供旧版本升级时参考。
