# 验收清单（31 项 · v3.3.2）

交付前逐项确认。

## 基础项（9 项）

- [ ] CSS 体系与首章完全一致（无自创样式）
- [ ] 封面图使用云端 URL（`file_to_url` 转换）
- [ ] 每张配图嵌入到对应情节的中段（非节末堆砌）
- [ ] 对话段用模板 1
- [ ] 场景/心理描写用模板 1 变体
- [ ] 关键句用模板 6 高亮
- [ ] 创作笔记在灰色块并标注"不用于公众号发布"
- [ ] 三版本全部输出（HTML / 纯内联代码 / markdown）
- [ ] 图片 URL 全部为云端绝对路径

## 节奏/视觉（8 项）

- [ ] 单段 ≤ 100 字（理想 30-80 字）
- [ ] 对话独立成段
- [ ] 场景/时间/视角跳转处有 dinkus
- [ ] 段间距 ≥ 1.3em
- [ ] 题词区有双线分隔
- [ ] 图说 12px 灰色居中
- [ ] 数字徽章 v3.3 方案 A
- [ ] 关键段落有左侧主色竖线

## 配图（4 项）

- [ ] 配图内容严格匹配本段情节
- [ ] 配图时代环境贴合小说背景
- [ ] 同章节配图风格统一
- [ ] 配图位置表已填写

## v3.1 严格项（3 项）

- [ ] 开头 4 元素顺序正确
- [ ] 丰富度指标达标（对话/高亮/dinkus/卷首引线）
- [ ] 6 项 grep 自检全通过

## v3.3 特殊项（6 项）

- [ ] 公众号代码文件末尾无 grep 自检块
- [ ] 文字区零文字规则落实
- [ ] 非末节创作笔记三版全保留
- [ ] 合集文件已更新
- [ ] 章节编号连续无跳号（拆分发布除外）
- [ ] 修真题材配图 prompt 已修真替换（正文保留原文，详见 `xiuzhen_replacement.md`）

## v3.1 特色元素保留项（4 项 · v3.3.2 新增）

- [ ] **卷首引线**存在且每 3 节 ≥ 1 个（模板 9，灰底斜体，位于章节标题后正文前）
- [ ] **行内高亮**每节 ≥ 2 个（模板 6，`<strong>` + `#E0F2F1` 底色）
- [ ] **对话块背景色为 #F5FBFA**（非 #FAFCFC 近白色）
- [ ] **段落含 letter-spacing:0.3px**（字间距微调）

## 自检命令

```bash
# 在 HTML 文件上跑
for item in "box-shadow" "class=" "border-radius" "display:inline-block"; do
  count=$(grep -ca "$item" file.html)
  echo "$item: $count (应为 0)"
done
count=$(grep -ca '<div[^>]*border-left' file.html)
echo "<div border-left: $count (应为 0)"
count=$(grep -ca '<hr' file.html)
echo "<hr: $count (应为 0)"
count=$(grep -ca '<table' file.html)
echo "<table: $count (应 > 10)"
```

29 项全过 = 验收通过。
