---
name: serial-typesetting
display_name: 连载排版
version: "3.3.2"
description: "长篇连载文章的微信公众号排版技能。用户上传章节或说「排版下一章/继续排版/按之前方式排版」时触发，输出三版本产物：HTML 公众号版、纯内联样式代码版、手机友好版。基于 v3.3 范式（<table>+bgcolor 装饰方案 + 6 项 grep 自检 + 配图 5 元素清单 + 修真词替换表 + 9 个装饰模板），确保同一连载多章节风格一致、微信编辑器粘贴后样式不丢失。"
emoji: "📜"
metadata:
  openclaw:
    requires:
      anyBins:
        - python3
        - python
        - py
    skillKey: serial-typesetting
    homepage: https://github.com/snowles/serial-typesetting
    category: writing
---

# 连载排版（serial-typesetting）

## 1. 触发场景

满足任一即加载：

- 用户上传新章节 .md 并要求排版
- 用户说"排版下一章""继续排版""按之前的方式排版"
- 任何涉及连载/系列文章公众号排版的需求

**不要用于**：学术论文、商业报告、纯图片分享、单次短文排版（无章节一致性需求时直接用通用公众号排版工具）。

## 2. 加载后首先确认（First Ask）

不要机械逐条追问，只问缺失关键信息：

1. **连载上下文**：是首章还是后续章节？如有同连载已发布章节，路径在哪？
2. **章节源文件**：.md 路径与字数？
3. **配图来源**：复用已有云端 URL / 新生成 / 用户提供？
4. **主题配色**：文学 #00897B / 健康 #43A047 / 时政 #1565C0 / 自定义？
5. **拆分决策**：单章 ≤ 5000 字 / 5000-12000 字 / > 12000 字或 > 24k 字？

## 3. 执行 Workflow（7 步）

1. **确认连载上下文** → 读取首章/最近一章 HTML 作为模板
2. **读取源文件** → 识别节号、节名、对话、场景、创作笔记
3. **封面图与配图** → 5 元素清单 + file_to_url 转云端 URL
4. **CSS 体系复用** → 严格复制首章 `<style>` 块，不得自创
5. **内容标注** → 按内容类型套用 8 个模板（见 `references/template_*.md`）
6. **输出三版本** → HTML 公众号版 / 纯内联代码版 / 手机友好版
7. **合集文件管理** → 更新 `{连载名}_前N节_公众号代码.md`

## 4. 硬规则速查（详见 references/）

| 规则 | 引用 |
|------|------|
| 开头 4 元素顺序 | `references/opening_order.md` |
| v3.3 章节大标题方案 A | `references/template_2_section_title.md` |
| 6 项 grep 自检 | `references/grep_self_check.md` |
| 丰富度硬指标 | `references/richness_metrics.md` |
| **9 个 `<table>` 模板** | `references/template_*.md`（模板 1-9） |
| 配图 5 元素清单 | `references/image_5elements.md` |
| 凡途 1960 人物基线 | `references/character_baseline.md` |
| 文字区零文字规则 | `references/zero_text_rule.md` |
| 创作笔记差异化 | `references/notes_handling.md` |
| 修真词替换表 | `references/xiuzhen_replacement.md` |
| 验收清单（31 项） | `references/acceptance_checklist.md` |
| convert_inline.py 坑点 | `references/convert_inline_pitfalls.md` |

## 5. 6 项 grep 自检（交付前必跑）

```bash
grep -ca "box-shadow" file.html         # 应为 0
grep -ca "class=" file.html             # 应为 0
grep -ca "border-radius" file.html      # 应为 0
grep -ca "display:inline-block" file.html  # 应为 0
grep -ca '<div[^>]*border-left' file.html  # 应为 0
grep -ca '<hr' file.html                # 应为 0
grep -ca '<table' file.html             # 应 > 10
```

HTML 含二进制字符时必须加 `-a` 强制当文本处理。前 3 项（box-shadow / border-radius / display:inline-block）全文档不能出现，包括注释与说明文字——用中文描述代替。

## 6. 默认交付策略

仅交付最终 HTML 版，其余产物（手机友好版、公众号代码 `.md`、升级说明）归档到 `<连载名>排版/_archive/`。除非用户明确要求全部交付。

## 7. 内容标注与 9 个装饰模板

### 段落基础样式

所有正文段落统一遵循：

- 字号：`15px`
- 行高：`1.75`（或 `1.85` 用于引用块）
- **字间距：`letter-spacing:0.3px`**（微调可读性，不要省略）
- 文字色：`#3F3F3F`
- 段间距：`margin:18px 0`（≥ 1.3em）
- 对齐：`text-align:justify`（两端对齐）

### 标注映射表

| 内容类型 | 模板 | 背景色 | 特征 |
|----------|------|--------|------|
| **对话段** | 模板 1 | `#F5FBFA`（默认） | 左竖线 + 角色名加粗 |
| 场景/心理描写 | 模板 1 变体 | `#FAFCFC`（仅变体） | 斜体 + 浅底 |
| **关键短语高亮** | **模板 6** | `#E0F2F1` | `<strong>` 青绿底 + 加粗 |
| 创作笔记 | 模板 1 灰色变体 | `#F0F0F0` | 灰色块 + ⚠️ 标注 |
| **卷首引线** | **模板 9** | `#F5FBFA` | 斜体 + 14px + 每 3 节 ≥ 1 |
| 章节大标题 | 模板 2 | 无 | v3.3 方案 A 单 p |
| 题词区 | 模板 3 | `#FAFCFC` | 双线 + 居中斜体 |
| 目录区 | 模板 4 | `#F5FBFA` | 两列 + 数字徽章 |
| 配图 + 图注 | 模板 5 | 无 | 居中 + 12px 灰色图说 |
| 分隔线 | 模板 7 | 无 | 文本符号 + 主色 |
| 场景转换 dinkus | 模板 8 | 无 | `∗ ∗ ∗` + 主色 |

### ⚠️ 必须保留的 v3.1 特色元素

以下 3 个元素是 v3.1 最有视觉特色的组成部分，**执行时不可省略或降级**：

1. **卷首引线（模板 9）**：每 3 节 ≥ 1 个灰底斜体引语块，放在章节大标题之后、正文之前
2. **行内高亮（模板 6）**：每节 ≥ 2 个 `<strong style="color:#00897B;background-color:#E0F2F1">` 关键词标记
3. **对话块浅青绿底（模板 1 默认）**：背景色必须用 `#F5FBFA`，不要用 `#FAFCFC` 近白色替代

### 模板速查索引

| 编号 | 名称 | references 文件 |
|------|------|------------------|
| 1 | 强调竖线 / 对话块 | `template_1_dialogue.md` |
| 2 | 章节大标题 v3.3 方案 A | `template_2_section_title.md` |
| 3 | 题词区 | `template_3_epigraph.md` |
| 4 | 目录区 | `template_4_toc.md` |
| 5 | 配图 + 图注 | `template_5_image.md` |
| 6 | **关键短语高亮** | **`template_6_highlight.md`** |
| 7 | 分隔线 | `template_7_divider.md` |
| 8 | 场景转换 dinkus | `template_8_dinkus.md` |
| **9** | **卷首引线** | **`template_9_section_epigraph.md`** |

## 8. 6 项 grep 自检（交付前必跑）

```bash
grep -ca "box-shadow" file.html         # 应为 0
grep -ca "class=" file.html             # 应为 0
grep -ca "border-radius" file.html      # 应为 0
grep -ca "display:inline-block" file.html  # 应为 0
grep -ca '<div[^>]*border-left' file.html  # 应为 0
grep -ca '<hr' file.html                # 应为 0
grep -ca '<table' file.html             # 应 > 10
```

HTML 含二进制字符时必须加 `-a` 强制当文本处理。前 3 项（box-shadow / border-radius / display:inline-block）全文档不能出现，包括注释与说明文字——用中文描述代替。

## 9. 历史版本

v1 → v2 → v3 → v3.1 → v3.2 → **v3.3（当前）**。演进历史见 `README.md` 附录。

---

执行时请严格以本文件 + `references/` 子文件为唯一标准。历史版本规则请查阅 README.md 版本演进章节。
