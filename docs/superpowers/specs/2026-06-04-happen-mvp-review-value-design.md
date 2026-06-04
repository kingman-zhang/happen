# Happen MVP Review Value Design

## Purpose

This design defines the MVP shape for Happen after the project boundary update.

The MVP keeps the product focused on child health fact recording and review. It does not change Happen into a broad child event tracker, family social network, medical assistant, or generic parenting tool.

The primary validation target is review value:

> Before a doctor visit or revisit, can a caregiver use Happen to review recent child health facts in about 2 minutes and explain the situation more clearly than with memory, paper calendars, notes apps, WeChat messages, or Excel?

## Product Boundary

MVP includes only:

- Child and caregiver setup.
- Shared access to a child's health facts.
- Bowel movement recording and review.
- Illness day recording.
- Illness timeline review by selected date range.

MVP excludes:

- Medical advice, diagnosis, medicine recommendation, dose calculation, or symptom severity scoring.
- Automatic illness episode detection.
- Drug database.
- Stool classification, stool photo analysis, or abnormality alerts.
- Push-notification-dependent reminders.
- Family chat, comments, feeds, albums, roles, approval flows, or social features.
- Generic habits, courses, tasks, points, reading, sports, or tooth brushing.
- Dashboard-style long-term analytics.

## Core Model

### Child

A child is the subject whose health facts are recorded.

MVP supports multiple children. Each health fact belongs to exactly one child.

When adding a child, the product asks for a nickname, not a legal name.

### Caregiver

A caregiver is a user who can view and edit one child's health facts.

A caregiver may have access to multiple children. A child may have multiple caregivers.

Caregivers are invited per child. Access to one child does not grant access to another child.

### Caregiver Label

Each caregiver has a lightweight display label within each child, such as `妈妈`, `爸爸`, `奶奶`, `爷爷`, or a custom label.

The label is not required to be unique. It is not a permission role.

### Membership

A membership connects one caregiver to one child.

MVP permissions are simple: every invited caregiver for a child can view and edit that child's MVP health facts.

### Health Facts

Every health fact stores:

- Child.
- Creator.
- Last editor.
- Created time.
- Updated time.

Health facts must be saved only after explicit user confirmation. Opening the Mini Program or opening a form must never create a record automatically.

## MVP Surfaces

### First Use

If the user has no child yet, show setup:

1. Enter child nickname.
2. Choose caregiver label.
3. Enter the child's home view.

Child nickname copy:

> 孩子小名

Placeholder:

> 例如：豆豆

Caregiver label copy:

> 我怎么称呼自己

Quick labels:

- `妈妈`
- `爸爸`
- `奶奶`
- `爷爷`
- `姥姥`
- `姥爷`
- `其他`

Do not ask for child real name, birthday, gender, avatar, or caregiver real name in MVP.

### Home

Home always shows the currently selected child.

Top area:

- Current child selector.
- Bowel movement status.
- Illness actions.

Primary home emphasis is bowel movement status, because it is the lighter daily health anchor.

Example home content:

- `豆豆`
- `距离上次大便 2 天`
- `今天已记录 1 次`
- `记一次大便`
- `查看/编辑大便记录`
- `查看病程时间线`
- `记今天病程`

If the user can access multiple children, the child selector lets them switch child context. All displayed records and actions apply only to the selected child.

### Child Settings

Child settings include:

- Child nickname.
- Current user's caregiver label.
- List of caregivers by display label.
- Invite caregiver action.

Do not expose family groups, role hierarchy, read-only permission switches, approval workflows, chat, or activity feeds.

## Invitation Flow

Entry:

> 孩子设置 > 邀请共同照护者

Flow:

1. Existing caregiver taps `邀请共同照护者`.
2. Happen generates a WeChat Mini Program share card or invitation link for the selected child.
3. Invited user opens the invitation.
4. Confirmation page shows the child nickname and access meaning.
5. Invited user chooses caregiver label.
6. User taps `加入`.
7. User enters that child's home view.

Confirmation copy:

> 你将加入豆豆的健康记录

Supporting copy:

> 家人之间可以一起记录和查看这个孩子的健康事实。加入后，你也可以补记和编辑记录，方便谁陪孩子看医生，谁都能说清楚。

Required confirmation:

> 加入

MVP does not require invite approval after the share link is opened. Invite security and expiration should be handled carefully during implementation, but the product model stays simple.

## Bowel Movement Recording

### Purpose

Bowel movement tracking answers:

> 距离上次大便已经几天？

It also supports a lightweight second question:

> 某一天记录了几次大便？

### Data Shape

One bowel movement record exists per child per date.

Fields:

- Date.
- Count.
- Optional observation tags.
- Optional note.
- Creator.
- Last editor.

### Add Interaction

Home action:

> 记一次大便

Interaction:

1. User taps `记一次大便`.
2. A lightweight confirmation panel opens.
3. Date defaults to today and can be changed.
4. User confirms.
5. Happen increments the count for that child and date by 1.

Opening the app does not record bowel movement. Opening the panel does not record bowel movement.

### Edit Interaction

The user can open a date's bowel movement record and edit:

- Date.
- Count.
- Observation tags.
- Note.

If a date record is deleted, its count and observations are removed.

### Observation Tags

Observation tags are optional quick record words for unusual days:

- `偏稀`
- `偏硬`
- `量少`
- `次数多`
- `有点费劲`

Guidance copy:

> 和平时不太一样时，可以简单记一下。

Observation tags are not stool classification and should not trigger medical interpretation.

MVP does not include color, photos, Bristol stool scale, abnormality alerts, or trend charts.

## Illness Day Recording

### Purpose

Illness day notes let caregivers record day-level facts that may be needed at a doctor visit.

The goal is not a medical-grade timeline. The goal is a clear day-by-day factual record.

### Data Shape

One illness day note exists per child per date.

Fields:

- Date.
- Highest temperature.
- Medicines.
- Symptoms.
- Note.
- Creator.
- Last editor.

### Add Or Edit Interaction

Home action:

> 记今天病程

Interaction:

1. User taps `记今天病程`.
2. The illness day form opens.
3. Date defaults to today and can be changed.
4. If that child and date already have a note, the form edits the existing note.
5. User saves explicitly.

Opening the form does not create a note.

Save rule:

- Date is required.
- At least one fact besides date must be entered or selected.
- `最高体温`, `用药`, `症状`, and `备注` are all optional.
- A note with only symptoms, only medicine, or only free text is valid.

Empty save copy:

> 写一点今天想回看的情况，再保存。

### Symptoms

Symptoms can be selected through quick tags and manually edited.

MVP symptom tags:

- `发热`
- `咳嗽`
- `流鼻涕`
- `鼻塞`
- `喉咙痛`
- `呕吐`
- `腹泻`
- `肚子痛`
- `食欲差`
- `精神一般`
- `睡不好`

Tags are quick record words. They are not diagnostic categories and do not imply severity.

### Medicines

Medicine input supports free text and quick record words.

Quick record word title:

> 常用记录词

Safety copy:

> 只用于记录已经使用过的药品或护理用品，不是用药建议。

MVP quick words:

- `布洛芬`
- `对乙酰氨基酚`
- `小儿柴桂`
- `奥司他韦`
- `蒙脱石散`
- `益生菌`
- `生理盐水喷鼻`
- `口服补液盐`

Input placeholder:

> 例如：上午布洛芬，睡前小儿柴桂

Do not recommend medicines based on symptoms. Do not include dosage calculation, medicine instructions, or a drug database.

## Illness Timeline Review

### Purpose

The timeline helps a caregiver explain recent illness facts to a doctor or during a revisit.

It does not diagnose. It does not look like a medical report.

### Date Range Model

MVP does not create, store, or infer illness episodes.

The timeline is a selected date range for the current child.

Default range:

- End date: today.
- Start date: 6 days before today.
- Total: most recent 7 days.

The caregiver can manually adjust the start and end dates.

Use copy such as:

- `查看病程时间线`
- `日期范围`
- `修改日期范围`
- `共 7 天`

Avoid copy such as:

- `自动识别本次病程`
- `系统判断病程`
- `智能生成病程`

### Timeline Content

For each date in the selected range, show:

- Date.
- Highest temperature if present.
- Medicines if present.
- Symptoms if present.
- Note if present.
- Creator or last editor where useful.

Days with no illness day note may be shown as `无记录`, but should not create guilt or anxiety.

### Empty State

If the selected range has no illness day notes:

Main copy:

> 最近这段时间没有病程记录

Supporting copy:

> 没有不舒服的记录，也是好消息。  
> 如果孩子今天有发热、用药或明显症状，可以记一笔，之后看医生时更容易说清楚。

Actions:

- `记今天病程`
- `修改日期范围`

## Validation

The MVP should be validated against review value, not daily activity.

Useful validation signals:

- In 5 target-parent interviews, at least 3 describe a concrete recent difficulty recording or reviewing fever, medicine, bowel movement, or similar child health facts.
- At least 2 of the same parents are willing to save, try, or request access to a tool focused only on bowel movement interval and illness day notes.
- A caregiver can record a bowel movement in a few seconds.
- A caregiver can record multiple bowel movements on the same date without the UI becoming a detailed stool tracker.
- A caregiver can create or update an illness day note without needing a precise medical timeline.
- A caregiver can use the selected date-range timeline to explain illness history more clearly than memory, paper calendar, notes app, WeChat messages, or Excel.
- In a shared-care scenario, one caregiver can record facts and another invited caregiver can review them before or during a doctor visit.

Failure signals:

- Users say the idea is useful but cannot describe a real recording or review problem.
- Users prefer paper calendars, notes apps, WeChat messages, or Excel after trying the MVP.
- Users only remember Happen when shown it, not when the real health event happens.
- Shared editing turns into family chat, social interaction, role management, or a parenting community.
- The product adds unrelated frequency features before validating health fact review value.

## Implementation Boundaries

Implementation planning should keep the first build small:

- Use child-scoped data access everywhere.
- Treat caregiver membership as the authorization boundary.
- Use selected date ranges for timeline review.
- Keep health facts editable.
- Preserve original user-entered facts.
- Keep medicine and symptom tags configurable enough to adjust later.
- Avoid generic `Event` language in the UI even if an event-like backend abstraction exists.

Implementation planning should not include:

- AI summary.
- Notifications.
- Charts.
- Medical recommendation logic.
- Complex permissions.
- Family social features.
- Stored illness episode automation.
