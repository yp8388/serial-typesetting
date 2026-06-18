<sub>中文</sub>

<div align="center">

# serial-typesetting | 连载排版

> *「给文章内容，出可直接发布的公众号排版。」*

**让长篇连载的每一章排版风格完全一致，微信编辑器粘贴后样式不丢失。**

[看效果](#效果示例) · [安装](#快速开始) · [触发方式](#触发方式) · [它和同类有什么不同](#它和同类有什么不同)

</div>

---

## 它解决什么问题

用 AI 给连载排版的人都知道：写完一章后，要么自己手动调格式半小时，要么让 AI 出一版 HTML 一粘贴到公众号后台，**色块没了、竖线没了、阴影没了、圆角全变方角**——最后还是"不完美但先发了"。

根因是：微信公众号编辑器对粘贴的 HTML 会**过滤或简化**大量 CSS 属性，包括 `box-shadow`、`border-radius`、`display: inline-block`、`border-left`（在 `<div>` 上）、`<hr>` 等。普通排版工具生成的 HTML 一律中招。

serial-typesetting 换了个思路：**不靠 CSS 高级特性，靠 `<table>` + `bgcolor` + `border-collapse` 这种编辑器高保留率的元素**。所有装饰效果（强调竖线、对话块、题词、目录、配图、分隔线、章节大标题）都用 8 个经过微信验证的 `<table>` 模板实现。

写长篇连载还有一个痛点：章节之间风格飘忽——这一章用了某种色，下一章又换；这一章配图在节首，下一章堆在节末；这一章装饰丰富，下一章素到没有。**缺少一套跨章节保持一致性的硬规则。**

serial-typesetting 把"排版风格一致"拆解成 6 项 grep 自检 + 5 元素清单 + 8 级字号梯度 + 5 节统一色板 + 29 项验收清单，AI 照着做就行。

## 效果示例

> 输入：`排版下一章《走出大山》，约 11 节，30k 字。严格复用首章 CSS 体系。`

> 输出：
> - HTML 公众号版（100KB）
> - 公众号代码版（75KB）
> - 手机友好版（30KB）
> - 配图位置表
> - 升级说明（含 6 项 grep 自检结果）
>
> 6 项 grep 自检：前 6 项 = 0，`<table` 数量 > 10 ✅  
> 29 项验收：全部通过 ✅  
> 公众号粘贴后样式保留率：100%

## 快速开始

### 1. 安装到 Trae / Claude Code / Coze

把整个 `serial-typesetting/` 目录复制到技能目录：

- **Trae**: `C:\Users\<你>\.trae-cn\skills\serial-typesetting\`
- **Claude Code**: `~/.claude/skills/serial-typesetting/`
- **Coze**: `./skills/serial-typesetting/`

### 2. 重启 IDE / 新建会话

技能列表出现 `serial-typesetting` 后即可触发。

### 3. 触发方式

满足任一即加载：

- 上传新章节 .md 并要求排版
- "排版下一章""继续排版""按之前的方式排版"
- 任何连载/系列公众号排版需求

## 触发方式（详细）

加载后 AI 会先问 5 个关键信息（不机械逐条，只问缺失的）：

1. **连载上下文**：是首章还是后续章节？如有同连载已发布章节，路径在哪？
2. **章节源文件**：.md 路径与字数？
3. **配图来源**：复用已有云端 URL / 新生成 / 用户提供？
4. **主题配色**：文学 #00897B / 健康 #43A047 / 时政 #1565C0 / 自定义？
5. **拆分决策**：单章 ≤ 5000 字 / 5000-12000 字 / > 12000 字或 > 24k 字？

## 它和同类有什么不同

| 维度 | 普通公众号排版工具 | serial-typesetting |
|------|--------------------|---------------------|
| 微信粘贴兼容性 | 中（box-shadow 等被过滤） | **高（`<table>` + `bgcolor` 模拟）** |
| 章节一致性 | 无 | **强制 6 项 grep 自检 + 复用首章 CSS** |
| 配图规范 | 按模板填 | **5 元素清单 + 5 类 prompt 关键词 + 零文字规则** |
| 装饰密度 | 自由发挥 | **每节对话 ≥ 1 / 高亮 ≥ 2 / dinkus ≥ 1** |
| 验收清单 | 无 | **29 项 + 6 项 grep 命令** |
| 创作笔记处理 | 经常泄露 | **末节 HTML 注释包裹 + 非末节三版全保留** |

## 版本演进

| 版本 | 时间 | 核心变更 |
|------|------|----------|
| v1 | 2026-06-14 | 首版 Skill；复用首章 CSS；三版本输出；基础配图规则 |
| v2 | 2026-06-15 | 7 条版式改进、4 条配图精准匹配硬规则、配图位置表 |
| v3 | 2026-06-15 | 8 级字号梯度、5 节统一色板、5 元素清单 |
| v3.1 | 2026-06-15 | 微信粘贴优化：8 个 `<table>` 模板 + 6 项 grep 自检 + 29 项验收 |
| v3.2 | 2026-06-15 | 双独立 `p` 章节色块方案 |
| **v3.3** | **2026-06-17** | **章节色块方案 A（数字+章节名一体）；零文字规则；陆尘/大黑形象基线；修真 prompt 优化；子 session 7 步骤模板** |
| v3.3.1 | 2026-06-18 | 修真词替换表独立为 references/xiuzhen_replacement.md，25+ 条替换规则 |
| **v3.3.2** | **2026-06-18** | **恢复卷首引线（模板 9）；强化行内高亮存在感；修正对话块背景色 #F5FBFA 默认值；新增 letter-spacing:0.3px；验收 31 项** |

## 文件结构

```
serial-typesetting/
├── SKILL.md                  # AI 加载的入口文件
├── README.md                 # 本文件
├── LICENSE                   # MIT
├── test-prompts.json         # 7 个测试用例
└── references/
    ├── opening_order.md      # 开头 4 元素顺序
    ├── template_1_dialogue.md     # 强调竖线 / 对话块
    ├── template_2_section_title.md # v3.3 章节大标题
    ├── template_3_epigraph.md    # 题词区
    ├── template_4_toc.md         # 目录区
    ├── template_5_image.md       # 配图 + 图注
    ├── template_6_highlight.md   # 关键短语高亮
    ├── template_7_divider.md     # 分隔线
    ├── template_8_dinkus.md      # 场景转换
    ├── template_9_section_epigraph.md # 卷首引线（v3.3.2 恢复）
    ├── grep_self_check.md        # 6 项 grep 自检
    ├── richness_metrics.md       # 丰富度硬指标
    ├── image_5elements.md        # 配图 5 元素清单
    ├── character_baseline.md     # 凡途 1960 人物基线
    ├── zero_text_rule.md         # 文字区零文字规则
    ├── notes_handling.md         # 创作笔记差异化处理
    ├── xiuzhen_replacement.md   # 修真词替换表（v3.3.1 新增）
    ├── acceptance_checklist.md   # 30 项验收清单
    └── convert_inline_pitfalls.md # convert_inline.py 坑点
```

## 案例：凡途 1960 第二章三节

- **章节**：第一节《转折之年》、第二节《走出大山》、第三节《书海探秘》
- **总图数**：35 张（含 3 封面 + 32 正文配图）
- **关键技术**：v3.3 章节色块方案 A、6 项 grep 自检、零文字规则、子 session 批量生图与替换
- **最终 HTML 路径**：
  - `凡途1960排版/第二章/第一节/_v3.1/凡途1960_第二章_第一节_转折之年_公众号版_v3.1.html`
  - `凡途1960排版/第二章/第二节/_v3.1/凡途1960_第二章_第二节_走出大山_公众号版_v3.1.html`
  - `凡途1960排版/第二章/第三节/_v3.1/凡途1960_第二章_第三节_书海探秘_公众号版_v3.1.html`

## 参考

- 公开 Skill 格式：SKILL.md 采用 YAML Frontmatter + Markdown 结构，核心字段为 `name`、`description`、`version`、`tags`、`emoji`、`metadata`。
- 公众号排版开源实践：WeChat Format 等工具采用 Markdown 转微信特制 HTML，强调内联样式与编辑器兼容性。
- gh extension 发布：通过 `gh extension create <name>` 与 `gh extension publish` 发布。

## License

MIT © 2026 缘来是你
