#!/usr/bin/env bash
set -euo pipefail

SCRIPT="${HOME}/.codex/skills/gpt-image2-serial/scripts/gpt-image2-serial-generate.sh"
OUT_DIR="/Users/zhangjianwen/Documents/Kingman/code/happen/notes/002-happen-ai-collaboration-mvp-design/images"

mkdir -p "${OUT_DIR}"

"${SCRIPT}" \
  --size 1536x864 \
  --quality medium \
  --out "${OUT_DIR}/01-cover.png" \
  --prompt "中文知识笔记封面图，主题是“和 AI 协作打磨儿童健康记录产品 MVP”。画面：一位独立开发者坐在桌前，桌面有手机小程序草图、纸质日历、儿童体温计、便签；旁边是一块明亮白板，白板上有简洁大字：MVP、边界、回看价值、共享记录。整体像产品策略复盘封面，清晰明亮、专业、温和、适合公众号和小红书。配色：白色、浅青、暖黄色、少量绿色和红色标注。不要品牌 logo，不要医疗诊断感，不要密密麻麻小字，不要真实儿童隐私场景。"

"${SCRIPT}" \
  --size 1536x1152 \
  --quality medium \
  --out "${OUT_DIR}/02-doc-chain.png" \
  --prompt "中文产品文档链路信息图。主题：从 PROJECT 到 Design Spec 到 PRD。画面为三层清晰流程图：左侧或上方是 PROJECT，表示产品边界；中间是 Design Spec，表示 MVP 方案蓝图；右侧或下方是 PRD，表示可实现可验收需求。每层用简单图标：边界线、蓝图纸、任务清单。风格：简洁明亮的产品经理知识图卡，白色背景，浅青、暖黄、深灰，少量红色强调。文字只保留大标题和三个核心词：PROJECT、Design Spec、PRD。不要复杂小字，不要品牌 logo。"

"${SCRIPT}" \
  --size 1536x1152 \
  --quality medium \
  --out "${OUT_DIR}/03-decision-map.png" \
  --prompt "中文产品决策地图信息图。主题：Happen MVP 的关键选择。画面是四个清晰模块围绕中心 Happen MVP：不自动识别病程、默认今天但不自动记录、大便按日期次数汇总、按孩子共享编辑。每个模块使用简洁图标：日历范围、确认按钮、次数计数器、多人共享。风格：专业克制、清晰易读、像产品复盘图卡。配色：白色背景、浅青、绿色、暖黄、少量红色风险标注。文字少而大，只保留模块标题。不要医疗建议，不要药品包装，不要杂乱小字。"

"${SCRIPT}" \
  --size 1536x1152 \
  --quality medium \
  --out "${OUT_DIR}/04-shared-care.png" \
  --prompt "中文概念图，主题：一个孩子多个共同照护者，一个照护者也可能照看多个孩子。画面中心是两个孩子昵称卡片，例如“豆豆”“小米”，周围是妈妈、爸爸、奶奶、爷爷等照护者头像式抽象图标，用柔和连线表示共享健康记录。重点表达“按孩子共享记录”，不是家庭社交。风格：温和、清晰、现代小程序产品说明图，白色背景，浅青、暖黄、绿色。文字少，只保留：孩子、共同照护者、共享记录。不要真实人物照片，不要家庭相册感，不要社交动态界面，不要品牌 logo。"
