#!/usr/bin/env bash
set -euo pipefail

SCRIPT="/Users/zhangjianwen/Documents/Kingman/code/codex/小红书/scripts/image_gen_with_project_key.sh"
OUT_DIR="/Users/zhangjianwen/Documents/Kingman/code/happen/notes/001-happen-product-validation/images"

mkdir -p "${OUT_DIR}"

"${SCRIPT}" generate \
  --model gpt-image-2 \
  --size 1024x1024 \
  --quality low \
  --output-format png \
  --prompt "中文分享笔记封面图。标题：别急着开发，先问它为什么会失败。副标题：一次儿童健康记录工具的 MVP 收敛。画面：产品验证桌面，手机、纸质日历本、儿童体温计、便签、白板，白板文字：Happen、病程记录、大便间隔、MVP验证。风格：清晰明亮、专业亲和、中文知识笔记封面。配色：白色、浅青、暖黄色、少量红色。避免：品牌 logo、医疗诊断感、杂乱小字。" \
  --out "${OUT_DIR}/01-cover.png"

"${SCRIPT}" generate \
  --model gpt-image-2 \
  --size 1024x1024 \
  --quality low \
  --output-format png \
  --prompt "中文信息图，主题：Happen 产品失败风险地图。画面为清晰的产品验证风险看板，中心写 Happen，四周是四个风险模块：低频需求、备忘录替代、范围膨胀、提醒受限。每个模块用简短中文解释：生病才用容易忘、备忘录也能记、什么都做会失焦、小程序通知不稳定。风格：公众号/小红书知识图卡，专业、克制、易读。配色：白色背景、浅青、暖黄、红色风险标注、深灰文字。不要品牌 logo，不要医生诊断暗示，不要密密麻麻的小字。" \
  --out "${OUT_DIR}/02-risk-map.png"

"${SCRIPT}" generate \
  --model gpt-image-2 \
  --size 1024x1024 \
  --quality low \
  --output-format png \
  --prompt "中文信息图，主题：从所有 Event 收敛到健康事实 MVP。左侧是很多灰色卡片：阅读、积分、课程、运动、刷牙、成长相册、课时管理；中间是漏斗，写着产品验证、用户真实痛点、低成本记录、健康事实；右侧是两个清晰模块：大便间隔、按天病程日记。底部一句话：平时记大便，生病记病程，看医生快速回看。风格：清晰明亮、产品策略图、中文知识笔记配图。配色：白色、浅青、绿色、暖黄、少量红色。不要品牌 logo，不要医疗建议，不要杂乱文字。" \
  --out "${OUT_DIR}/03-mvp-focus.png"
