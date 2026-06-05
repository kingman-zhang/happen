# MVP Scope Review

This document is a scope review, not a PRD. It reviews the current Happen MVP boundary against review value, implementation complexity, and value verifiability.

Source documents:

- `PROJECT.md`
- `docs/superpowers/specs/2026-06-04-happen-mvp-review-value-design.md`

## 1. Functions The MVP Should Have

The MVP should include only functions that directly support the core validation question:

> Can a caregiver review recent child health facts in about 2 minutes before a doctor visit or revisit, and explain the situation more clearly than with memory, paper calendars, notes apps, WeChat messages, or Excel?

### Child And Caregiver Setup

Must have:

- Add a child with a nickname.
- Set the current user's caregiver label for that child.
- Select the current child when the user has access to more than one child.
- Invite another caregiver to a specific child.
- Let invited caregivers view and edit that child's MVP health facts.
- Show creator or last-editor labels where useful.

Rationale:

- Shared access is part of the review-value hypothesis because the recorder and doctor-visit caregiver may be different people.
- The setup must stay lightweight so onboarding does not become family account management.

### Bowel Movement Recording And Review

Must have:

- Record a bowel movement by date.
- Increment the count for an existing date when another bowel movement is recorded.
- Edit the count for a date.
- Add optional observation tags or notes for unusual days.
- Edit or delete a bowel movement record.
- Show days since the most recent bowel movement.
- Show today's bowel movement count when relevant.

Rationale:

- This is the simplest daily anchor.
- It answers a concrete parent question: "How many days has it been since the last bowel movement?"

### Illness Day Notes

Must have:

- Create or edit one illness day note per child per date.
- Default the date to today while requiring explicit save.
- Allow highest temperature, medicines, symptoms, and notes.
- Allow medicine and symptom entry as free text or lightweight quick words.
- Require at least one fact besides date before saving.
- Preserve the user's original recorded facts.

Rationale:

- The illness model should be day-level, not medical-grade minute-level.
- Parents need to reconstruct a story for doctor visits, not build a clinical chart.

### Illness Timeline Review

Must have:

- View illness day notes grouped by day.
- Default to the most recent 7 days ending today.
- Let the caregiver manually adjust the date range.
- Show the number of days in the selected range.
- Show daily highest temperature, medicines, symptoms, and notes.
- Show empty days as no record without creating guilt or anxiety.

Rationale:

- The timeline is the primary review surface.
- Manual date ranges keep the product useful without requiring automatic illness episode detection.

### Minimal Safety And Boundary Copy

Must have:

- State that medicine quick words are for recording medicines already used, not medication advice.
- Avoid diagnosis, recommendation, abnormality alert, severity score, and treatment language.
- Use concrete health fact language instead of generic event language.

Rationale:

- The MVP organizes facts. It must not imply medical judgment.

## 2. Functions That Should Be Deleted

These functions should be removed from MVP scope if they appear in plans, prototypes, navigation, backlog shortcuts, or interface drafts.

### Broad Child Event Tracking

Delete:

- Generic event creation.
- User-facing event types.
- Custom event categories.
- General child timeline.
- Milestones, growth memories, family moments, or photos.

Reason:

- They dilute the review-value test and make the product compete with notes, albums, and generic trackers.

### Family Social And Collaboration Features

Delete:

- Family groups.
- Chat.
- Comments.
- Activity feeds.
- Likes or reactions.
- Family albums.
- Approval flows.
- Role hierarchy.
- Read-only permission switches.
- Complex permission matrix.

Reason:

- MVP collaboration should only mean shared child health fact access.
- Social behavior would create a different product and a different validation problem.

### Medical Advice Or Clinical Decision Features

Delete:

- AI medical consultation.
- Diagnosis.
- Treatment recommendation.
- Medicine recommendation.
- Dose calculation.
- Drug database.
- Symptom severity scoring.
- Abnormality alerts.
- Doctor-facing workflow.

Reason:

- These increase safety, trust, regulatory, and product complexity before the core recording and review value is proven.

### Advanced Stool Tracking

Delete:

- Stool color tracking as a required field.
- Stool amount tracking as a required field.
- Stool photos.
- Stool photo analysis.
- Bristol stool classification.
- Stool abnormality interpretation.
- Long-term stool trend charts.

Reason:

- The MVP question is bowel movement interval and daily count, not medical stool analysis.

### Reminders And Notification-Dependent Workflows

Delete:

- Push-notification-dependent reminders.
- Streaks.
- Missed-record alerts.
- Scheduled medication reminders.

Reason:

- WeChat Mini Program notification behavior is unreliable enough that MVP value should not depend on it.

### Generic Parenting Or Habit Features

Delete:

- Course platform.
- Class-hour tracking.
- Reading tasks.
- Points or rewards.
- Exercise tracking.
- Tooth brushing tracking.
- Generic habit tracking.
- Generic child task management.

Reason:

- These are unrelated to the health fact review hypothesis.

## 3. Functions That Increase Complexity

These functions may sound adjacent to the MVP, but they add meaningful complexity and should be deferred unless validation proves they are necessary.

### Multiple Children

Complexity added:

- Child-scoped data access everywhere.
- Child switching.
- Empty states per child.
- Avoiding cross-child record leakage.

Decision:

- Keep in MVP, but implement minimally.

Why:

- Parents may have more than one child, and every health fact must belong to exactly one child.

### Invited Caregivers

Complexity added:

- Invitation links or WeChat share cards.
- Membership records.
- Authorization by child.
- Concurrent editing edge cases.
- Creator and last-editor display.

Decision:

- Keep in MVP, but only as simple view-and-edit access for invited caregivers.

Why:

- Shared access is central to the "who records may not be who visits the doctor" problem.

### Observation Tags For Bowel Movements

Complexity added:

- Tag vocabulary.
- Editing tags.
- Preventing tags from becoming medical classification.

Decision:

- Keep only optional lightweight tags and note.

Why:

- Useful for unusual days, but not required for the core interval question.

### Medicine And Symptom Quick Words

Complexity added:

- Configurable word lists.
- Safety copy.
- Risk of users interpreting quick words as recommendations.

Decision:

- Keep only if presented as recording shortcuts, not medical guidance.

Why:

- They reduce entry friction for illness day notes.

### Illness Timeline Date Range

Complexity added:

- Date range controls.
- Empty days.
- Counting selected days.
- Editing records from review context.

Decision:

- Keep in MVP.

Why:

- This is the core review surface for doctor-visit preparation.

### Automatic Illness Episodes

Complexity added:

- Inference rules.
- Edge cases around recurring symptoms.
- Trust issues when the system guesses wrong.
- More complicated data model.

Decision:

- Defer.

Why:

- Manual date ranges are enough to validate review value.

### Charts And Analytics

Complexity added:

- Aggregation logic.
- Visual design.
- Edge cases for missing data.
- Risk of turning the product into a dashboard.

Decision:

- Defer.

Why:

- MVP statistics should be limited to days since last bowel movement, daily bowel movement count, and number of days in the selected illness timeline.

## 4. Functions That Cannot Verify Value

These functions may create engagement, polish, or perceived completeness, but they do not directly verify whether Happen is better than memory, paper calendars, notes apps, WeChat messages, or Excel for recent child health fact review.

### Growth Album Or Memory Timeline

Why it cannot verify MVP value:

- It tests emotional sharing and memory keeping, not doctor-visit health fact review.

### Family Chat, Comments, Or Feed

Why it cannot verify MVP value:

- Usage would indicate social interaction, not whether factual review becomes faster or clearer.

### Points, Rewards, Or Streaks

Why it cannot verify MVP value:

- They may increase recording behavior without proving that records are useful at the moment of need.

### Long-Term Analytics Dashboard

Why it cannot verify MVP value:

- It tests analytic curiosity, not the 2-minute recent-review scenario.

### AI Summary

Why it cannot verify MVP value:

- It may hide whether the underlying recording and timeline structure already works.
- It introduces trust and safety questions too early.

### Notifications And Reminders

Why it cannot verify MVP value:

- Reminder success would test notification mechanics and habit formation, not whether stored facts are easier to review.

### Detailed Medical Structuring

Why it cannot verify MVP value:

- Drug databases, dose fields, severity scores, and exact time requirements test clinical-data completeness rather than lightweight parent review.

## Recommended MVP

The recommended MVP is:

> A WeChat Mini Program for recording and reviewing a narrow set of shared child health facts: bowel movement interval/count and day-level illness facts, with minimal child/caregiver setup and invited caregiver access.

### MVP Must Include

- First-use setup with child nickname and caregiver label.
- Current child selector for users with multiple children.
- Child settings with caregiver list and invite action.
- Per-child caregiver membership.
- Simple invited caregiver flow.
- Shared view-and-edit access for invited caregivers.
- Bowel movement record per child per date.
- Quick "record one bowel movement" action that increments the selected date count after confirmation.
- Edit and delete for bowel movement records.
- Optional bowel movement observation tags and note.
- Home status for days since last bowel movement.
- Home status for today's bowel movement count when relevant.
- Illness day note per child per date.
- Illness day fields: highest temperature, medicines, symptoms, and note.
- Free-text medicine and symptom input.
- Optional medicine and symptom quick words with safety copy.
- Explicit save for every health fact.
- Save validation requiring at least one fact besides date for illness day notes.
- Illness timeline grouped by day.
- Default illness timeline range of the most recent 7 days.
- Manual date range adjustment.
- Timeline display of daily highest temperature, medicines, symptoms, and notes.
- Lightweight creator or last-editor labels where useful.

### MVP Should Exclude

- Generic event tracker.
- Growth album.
- Photos.
- Family social features.
- Chat, comments, feeds, likes, or reactions.
- Complex roles, read-only permissions, approval flows, or family groups.
- Medical advice, diagnosis, treatment recommendation, medicine recommendation, or dose calculation.
- Drug database.
- Automatic illness episode detection.
- Stool classification, stool photo analysis, or abnormality alerts.
- Notification-dependent reminders.
- Charts, trends, and dashboard analytics.
- Generic habits, tasks, courses, points, reading, exercise, or tooth brushing.
- Doctor-facing or teacher-facing workflows.

### Validation Bar

The MVP should be considered valuable only if it shows evidence that:

- Parents have a concrete recent problem recording or reviewing child illness, medicine, fever, or bowel movement facts.
- At least some target parents want to try a tool that is this narrow.
- A caregiver can record a bowel movement in a few seconds.
- A caregiver can record or update an illness day note without needing a clinical timeline.
- A caregiver can review a selected date range in about 2 minutes and explain the child's recent illness more clearly.
- Shared access helps when one caregiver records facts and another caregiver needs to review them.

### Product Management Recommendation

Build the smallest version that can test review value:

1. Start with child setup, bowel movement status, and bowel movement recording.
2. Add illness day notes and the 7-day timeline.
3. Add invited caregiver access only after the single-user review loop is usable.
4. Do not add broader parenting, medical, social, analytics, or reminder features until real parent testing proves the narrow review loop is valuable.

