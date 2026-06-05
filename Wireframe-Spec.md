# Happen Wireframe Specification

This document defines the structural wireframe specification for Happen MVP. It is intended for Figma wireframe production only.

It does not define visual style, colors, typography, brand assets, illustration, motion, or polished UI treatment.

## App Structure

Happen is a WeChat Mini Program for child-scoped health fact recording and review. The MVP should feel like a quick recording workspace, not a broad record management app.

The app is organized around one selected child at a time. Every record, review surface, form, and setting belongs to the current child context.

Primary structure:

1. First-use setup
   - Used only when the user has no accessible child.
   - Creates the minimum usable context: child nickname and caregiver label.
2. Home
   - Default workspace after setup or app open.
   - Shows current child, bowel movement status, fast recording actions, and review entry points.
3. Child settings
   - Minimal child and caregiver management.
   - Contains caregiver invitation.
4. Records
   - Secondary correction and browsing page reached from Home.
   - Not a primary navigation destination.
5. Illness timeline
   - Date-range review page for doctor-visit preparation.
6. Record forms and panels
   - Bowel movement confirmation sheet.
   - Bowel movement record editor.
   - Illness day form.
7. Invitation join flow
   - Child-scoped shared access flow opened from a WeChat share card or invitation link.

Information hierarchy:

1. Fast recording of facts that already happened.
2. Immediate bowel movement interval review.
3. Illness timeline review for doctor conversations.
4. Record correction and browsing.
5. Child and caregiver settings.

Scope boundaries:

- The MVP records facts; it does not provide diagnosis, medical advice, medicine recommendations, dose calculation, charts, automatic illness episode detection, social features, chat, comments, or family role management.
- Use concrete language such as "record bowel movement", "record illness", and "illness timeline". Do not make "event" the primary user-facing concept.

## Navigation

The MVP should use a Home-first navigation model.

Recommended navigation:

- App open routes to First-use setup if the user has no child.
- App open routes to Home if the user has at least one accessible child.
- Home is the main workspace and primary return point.
- Child settings is reached from a small Home entry.
- Records is reached from a secondary Home entry.
- Illness timeline is reached from a visible Home review action.
- Record forms open from Home, Timeline, or Records depending on user intent.
- Invitation confirmation opens from an external invitation link or WeChat share card.

Bottom navigation:

- Prefer no bottom tab bar for MVP.
- If implementation requires a tab bar, use only Home and Settings.
- Do not include Records as a bottom tab.

Child context navigation:

- If the user has one child, show the child nickname as context without selector friction.
- If the user has multiple children, the child nickname opens a child selector.
- Switching child updates Home status, Records, Timeline, forms, and Settings.
- Forms must show the current child before any save or confirm action.
- Adding another child, if included in MVP, belongs in Child Settings rather than the child selector's primary path.

Back and close behavior:

- Closing a sheet returns to the previous screen with no saved changes.
- Back from an unsaved form asks for discard confirmation only after the user has entered content.
- Successful quick bowel movement recording returns directly to Home.
- Successful illness day save returns to the previous screen.
- Timeline range changes stay on Timeline.
- Records returns to Home.
- Invalid or expired invitation states do not enter Home through that invitation.

## Screen Inventory

### 1. First-Use Setup

Purpose: create the minimum child context for a new user.

Entry:

- App open when the user has no accessible child.

Exit:

- Successful setup goes to Home for the newly created child.

Required content:

- Setup title.
- Child nickname input.
- Caregiver label quick choices.
- Custom caregiver label input shown only when custom is selected.
- Primary confirm action.

States:

- Empty required input.
- Submission error with entered values preserved.

Exclusions:

- No birthday, gender, avatar, real child name, caregiver real name, family name, medical profile, invitation prompt, or multi-child prompt.

### 2. Home

Purpose: serve as the child-scoped quick recording workspace.

Entry:

- App open for existing users.
- After setup.
- After invitation join.
- After successful quick recording.

Required content:

- Current child nickname.
- Child switch affordance if multiple children exist.
- Settings entry.
- Bowel movement status.
- Primary action: record bowel movement.
- Primary action: record illness.
- Review action: illness timeline.
- Secondary action: view or edit records.

States:

- No bowel movement record yet.
- Bowel movement status loading failure with retry.
- Selected child unavailable.
- Multiple caregiver context with useful last-editor hint.

Exclusions:

- No charts, analytics dashboard, education content, onboarding carousel, invitation prompt, social feed, or generic event list as the main Home content.

### 3. Child Selector

Purpose: safely switch current child.

Entry:

- Tap child nickname on Home or another child-scoped screen when multiple children are accessible.

Required content:

- List of accessible children.
- Current child indicator.
- Tap target for each child.

Behavior:

- Switch happens only after the user selects a child.
- After switch, return to the previous screen if valid for that child.
- All visible child-scoped data refreshes to the new child.

Exclusions:

- Do not make add child a prominent selector action.
- No family workspace, household grouping, or role hierarchy.

### 4. Child Settings

Purpose: manage minimal child and caregiver information.

Entry:

- Settings entry from Home.

Required content:

- Child nickname field.
- Current user's caregiver label field.
- Caregiver list by display label.
- Invite caregiver action.
- Add another child action only if included in MVP.

States:

- Nickname update failure.
- Caregiver label update failure.
- Caregiver list load failure.

Exclusions:

- No read-only switch, admin role, approval flow, chat, comments, family feed, or activity feed.

### 5. Invitation Confirmation

Purpose: allow an invited caregiver to join one child's shared records.

Entry:

- Valid invitation link or WeChat share card.

Required content:

- Child nickname.
- Short explanation that joining allows viewing and editing this child's MVP health facts.
- Caregiver label quick choices.
- Custom caregiver label input if needed.
- Join action.
- Cancel or leave affordance.

States:

- Invalid invitation.
- Expired invitation.
- Already joined.
- Join submission failure with selected label preserved.

Exclusions:

- No family role selection, permission matrix, phone number requirement, real name requirement, or broad family account setup.

### 6. Bowel Movement Confirmation Sheet

Purpose: explicitly record one bowel movement with minimal friction.

Entry:

- Record bowel movement action from Home.

Required content:

- Current child label.
- Date field defaulted to today.
- Count impact text explaining that confirmation adds one time for the selected date.
- Confirm action.
- Add details action.
- Cancel action.

Expanded detail content:

- Optional observation tags.
- Optional short note.

States:

- Date changed before confirmation.
- Details expanded.
- Save failure with user input preserved.

Exclusions:

- No automatic record creation on open.
- No stool classification, stool photo, color, amount, medical alert, or trend analysis.

### 7. Bowel Movement Record Editor

Purpose: correct or enrich a date-level bowel movement record.

Entry:

- Tap a bowel movement date from Records.
- Optional correction path from Home if exposed.

Required content:

- Current child label.
- Date field.
- Count stepper and direct numeric input.
- Optional observation tags.
- Optional short note.
- Last editor label when useful.
- Save action.
- Delete action.

States:

- Count empty or zero.
- Delete confirmation.
- Save failure with unsaved input preserved.

Exclusions:

- Do not make this editor the normal fast recording path.

### 8. Illness Day Form

Purpose: create or update one date-level illness note.

Entry:

- Record illness action from Home.
- Tap date row from Timeline.
- Tap illness date from Records.

Required content:

- Current child label.
- Date field defaulted to today when opened from Home.
- Highest temperature input.
- Symptom quick words.
- Symptom or note free-text field.
- Medicine entry area.
- Save action.

Secondary content:

- Recent medicine words previously entered for this child, if available.
- Recording-only medicine safety copy.
- Additional note space if needed.
- Last editor label when useful.

States:

- Existing note for selected date loads as edit mode.
- Date changed to another date with an existing note.
- Save attempted with date only.
- Unsaved content on back.
- Save failure with unsaved input preserved.

Exclusions:

- No drug database, dosage calculator, medicine instructions, symptom severity score, medical recommendation, or diagnosis language.

### 9. Illness Timeline

Purpose: scan day-by-day illness facts for a selected date range.

Entry:

- Illness timeline action from Home.

Required content:

- Current child label.
- Date range selector.
- Day count.
- Recorded days in chronological order.
- Day entries showing only available facts:
  - Highest temperature.
  - Medicines.
  - Symptoms.
  - Note.
  - Last editor when useful.
- Compact indication for dates with no record.

States:

- Default most recent 7 days ending today.
- Adjusted valid date range.
- Start date after end date.
- Empty range with actions to record illness or change date range.
- Timeline load failure with retry.

Exclusions:

- No diagnosis report layout.
- No automatic illness episode language.
- No summary that replaces original user-entered facts.

### 10. Records

Purpose: browse and correct date-level records.

Entry:

- View or edit records action from Home.

Required content:

- Current child label.
- Segmented control for Bowel movement and Illness days.
- Date-grouped list for selected type.
- Empty state for selected type.
- Optional lightweight add action for selected type.

Behavior:

- Bowel movement date opens Bowel Movement Record Editor.
- Illness day date opens Illness Day Form.
- Records is secondary and should not compete with Home recording actions.

Exclusions:

- No generic event timeline.
- No analytics dashboard.

## Screen Layout

### First-Use Setup Layout

Top area:

- Short setup heading.

Main area:

- Child nickname input.
- Caregiver label quick choices.
- Custom label field conditionally displayed.

Bottom area:

- Primary confirm action.

Wireframe structure:

```text
[Setup heading]

[Child nickname input]

[Caregiver label choices]
[Custom label input if selected]

[Start / Confirm]
```

### Home Layout

Top bar:

- Current child nickname on the left or central context position.
- Child switch affordance attached to nickname when multiple children exist.
- Settings entry on the opposite side.

Main status:

- Bowel movement status block with the direct interval answer.
- Last bowel movement date when available.
- Today's count when relevant.

Primary actions:

- Record bowel movement.
- Record illness.

Review area:

- Illness timeline.
- View or edit records as secondary.

Wireframe structure:

```text
[Current child]                         [Settings]

[Bowel movement status]
[Days since last bowel movement]
[Last date]
[Today count]

[Record bowel movement]
[Record illness]

[Illness timeline]
[View or edit records]
```

### Child Selector Layout

Main area:

- Accessible child list.
- Current child marker.

Wireframe structure:

```text
[Select child]

[Current child item]
[Other child item]
[Other child item]
```

### Child Settings Layout

Top area:

- Page title.

Main area:

- Child nickname editable field.
- My caregiver label editable field.
- Caregiver list.

Action area:

- Invite caregiver.
- Add another child if supported.

Wireframe structure:

```text
[Child settings]

[Child nickname field]
[My caregiver label field]

[Caregiver list]

[Invite caregiver]
[Add another child if supported]
```

### Invitation Confirmation Layout

Top area:

- Invitation status or join heading.
- Child nickname.

Main area:

- Shared access explanation.
- Caregiver label choices.
- Custom label field conditionally displayed.

Bottom area:

- Join action.
- Cancel or leave action.

Wireframe structure:

```text
[Join child records]
[Child nickname]

[Access explanation]

[Caregiver label choices]
[Custom label input if selected]

[Join]
[Cancel]
```

### Bowel Movement Confirmation Sheet Layout

Header:

- Sheet title.
- Current child label.

Main area:

- Date selector.
- Count impact text.
- Optional details area collapsed by default.

Actions:

- Confirm.
- Add details.
- Cancel.

Wireframe structure:

```text
[Record bowel movement]
[Child label]
[Date selector]

[This will add 1 time]

[Confirm]
[Add details] [Cancel]
```

Expanded detail structure:

```text
[Observation tags]
[Short note]
```

### Bowel Movement Record Editor Layout

Header:

- Title and child label.

Main area:

- Date selector.
- Count control.
- Observation tags.
- Note field.
- Last editor if useful.

Actions:

- Save.
- Delete.

Wireframe structure:

```text
[Bowel movement record]
[Child label]
[Date selector]

[Count stepper + numeric value]

[Observation tags]
[Note field]
[Last editor if useful]

[Save] [Delete]
```

### Illness Day Form Layout

Header:

- Title and child label.

Main area:

- Date selector.
- Highest temperature input.
- Symptom quick words.
- Symptom or note text field.
- Medicine section.
- Additional notes if expanded or needed.
- Last editor if useful.

Actions:

- Save.

Wireframe structure:

```text
[Record illness]
[Child label]
[Date selector]

[Highest temperature input]

[Symptom quick words]
[Symptom / note text field]

[Medicine section]
[Recording-only safety copy when medicine words appear]

[Save]
```

### Illness Timeline Layout

Top area:

- Title and current child label.
- Date range selector.
- Day count.

Main area:

- Recorded days shown first in chronological order.
- Each day shows available facts only.
- Compact no-record indication for empty dates.

Empty state:

- No records message.
- Record illness action.
- Change date range action.

Wireframe structure:

```text
[Illness timeline]                 [Child label]
[Date range selector]
[Day count]

[Date]
[Temperature if present]
[Symptoms if present]
[Medicine if present]
[Note if present]
[Last editor if useful]

[Compact no-record summary]
```

### Records Layout

Top area:

- Title and current child label.
- Segmented control.

Main area:

- Date-grouped list.
- Row summaries.
- Empty state for selected type.

Wireframe structure:

```text
[Records]                         [Child label]
[Bowel movement | Illness days]

[Date group]
[Record summary row >]

[Date group]
[Record summary row >]
```

## Components

### Child Context Header

Used on Home, Timeline, Records, Settings, and forms.

Contains:

- Current child nickname.
- Switch affordance when multiple children exist.
- Optional compact child label on forms.

Rules:

- The selected child must be visible before save or confirm actions.
- Do not hide child context inside menus on record forms.

### Child Selector

Contains:

- Accessible child list.
- Current child indicator.

Rules:

- Select changes the current child.
- Do not include family management complexity.

### Bowel Movement Status Block

Contains:

- Days since last bowel movement when data exists.
- Last date.
- Today's count when relevant.
- Empty state if no record exists.

Rules:

- Do not show an incorrect interval when no data exists.
- Keep status as a direct answer, not a chart.

### Primary Record Actions

Contains:

- Record bowel movement.
- Record illness.

Rules:

- Both must be visible on Home.
- Record bowel movement should be the fastest reachable action.
- These actions should not be hidden behind Records.

### Review Actions

Contains:

- Illness timeline.
- View or edit records.

Rules:

- Timeline is a review surface for doctor conversations.
- Records is a secondary correction and browsing path.

### Date Selector

Used in:

- Bowel Movement Confirmation Sheet.
- Bowel Movement Record Editor.
- Illness Day Form.
- Illness Timeline.

Rules:

- Date defaults to today for recording forms.
- Timeline defaults to the most recent 7 days ending today.
- Start date after end date must be blocked on Timeline.

### Bowel Movement Confirmation Sheet

Contains:

- Child label.
- Date selector.
- Count impact text.
- Confirm.
- Add details.
- Cancel.
- Optional tags and note when expanded.

Rules:

- Opening the sheet does not create or update records.
- Confirm increments the selected child and date by one.

### Observation Tags

Suggested tags:

- Loose.
- Hard.
- Small amount.
- Frequent.
- Strained.

Rules:

- Tags are optional quick record words.
- Tags are not medical classification or abnormality alerts.

### Count Control

Used in Bowel Movement Record Editor.

Contains:

- Stepper.
- Direct numeric input.

Rules:

- Count must be positive to save.
- Empty or zero should be blocked or redirected to delete.

### Illness Day Form Fields

Contains:

- Date.
- Highest temperature.
- Symptom quick words.
- Symptom or note free text.
- Medicine text entry.
- Optional note expansion.

Rules:

- Save requires at least one fact besides date.
- All facts except date are individually optional.

### Symptom Quick Words

Possible examples:

- Fever.
- Cough.
- Runny nose.
- Vomiting.
- Diarrhea.
- Sore throat.
- Poor appetite.
- Slept poorly.

Rules:

- Quick words add editable/removable user-recorded content.
- They must not trigger severity scoring or advice.

### Medicine Entry

Contains:

- Free-text medicine field.
- Recent medicine words for this child when available.
- Safety copy when medicine words are visible.

Rules:

- Medicine words represent medicines already used.
- They must not appear as recommendations.
- If no medicine history exists, prefer plain text entry over a prominent generic medicine list.

### Timeline Day Entry

Contains:

- Date.
- Present fields only: temperature, medicines, symptoms, note.
- Last editor when useful.
- Row tap target to open Illness Day Form for that date.

Rules:

- Omit empty fields.
- Do not diagnose, summarize as system judgment, or infer episode boundaries.

### Records List

Contains:

- Segmented type selector.
- Date groups.
- Record summary rows.

Rules:

- Tap row opens the matching editor.
- Records is for browsing and correction.

### Caregiver List

Contains:

- Display labels for caregivers with access to the child.

Rules:

- Duplicate labels are allowed.
- Labels do not imply permission level.

### Invitation Join Module

Contains:

- Child nickname.
- Access explanation.
- Caregiver label choices.
- Join action.

Rules:

- Invitation is scoped to one child.
- Joining creates membership only after explicit confirmation.
- Invalid or expired invitations create no membership.

### Error And Empty States

Reusable states:

- No child.
- No bowel movement records.
- No illness notes in selected range.
- Load failure with retry.
- Save failure with preserved input.
- Invalid invitation.
- Expired invitation.
- Selected child unavailable.

Rules:

- Empty states should be calm and factual.
- Error states must not create, edit, or delete records as side effects.

## User Flows

### Flow 1: First Use

1. User opens Happen.
2. System checks accessible children.
3. If none exist, First-Use Setup appears.
4. User enters child nickname.
5. User chooses or enters caregiver label.
6. User confirms.
7. System creates child and membership.
8. User lands on Home for that child.

Wireframe requirements:

- One setup screen.
- Confirm disabled or blocked until child nickname and caregiver label are present.
- No health facts are created during setup.

### Flow 2: Returning User Opens Home

1. User opens Happen.
2. System loads last selected accessible child, or selects the only child.
3. Home displays child context and bowel movement status.
4. User can immediately record bowel movement or illness.

Wireframe requirements:

- Home must not require navigation before recording.
- Bowel movement status can show loading, empty, or loaded state.

### Flow 3: Switch Child

1. User taps current child nickname.
2. Child Selector opens if multiple children are accessible.
3. User selects a child.
4. Previous screen reloads in the new child context.
5. Future save or confirm actions apply only to the newly selected child.

Wireframe requirements:

- Current child indicator is visible.
- Forms show current child near date or save context.

### Flow 4: Record One Bowel Movement

1. User opens Home.
2. User taps Record bowel movement.
3. Confirmation sheet opens with current child and today's date.
4. User confirms, or changes date and confirms.
5. System increments the count for that child and date by one.
6. User returns to Home.
7. Home updates interval and today's count.

Wireframe requirements:

- Fast path is Home -> Record bowel movement -> Confirm.
- Add details is optional and secondary.
- Opening the sheet creates no record.

### Flow 5: Add Bowel Movement Details During Quick Record

1. User opens Bowel Movement Confirmation Sheet.
2. User taps Add details.
3. Tags and short note expand inside the sheet.
4. User selects tags or enters note.
5. User confirms.
6. System saves the increment plus details for that date.

Wireframe requirements:

- Details do not navigate to the full editor.
- Confirm remains the main completion action.

### Flow 6: Correct A Bowel Movement Record

1. User opens Records from Home.
2. User selects Bowel movement segment.
3. User taps a date row.
4. Bowel Movement Record Editor opens.
5. User edits date, count, tags, or note.
6. User saves or deletes.
7. System updates record and recalculates Home status.

Wireframe requirements:

- Count can be corrected directly.
- Delete has confirmation.
- Zero or empty count cannot be saved as a normal record.

### Flow 7: Record Illness Day

1. User opens Home.
2. User taps Record illness.
3. Illness Day Form opens with current child and today's date.
4. User enters at least one fact besides date.
5. User saves.
6. System creates or updates the note for that child and date.
7. User returns to the previous screen.

Wireframe requirements:

- Save blocked for date-only forms.
- The form supports one quick fact and Save.
- Medicine quick words include recording-only safety copy when shown.

### Flow 8: Update Existing Illness Day

1. User opens Timeline or Records.
2. User taps a date.
3. If a note exists, Illness Day Form opens in edit mode.
4. If no note exists, Illness Day Form opens as create mode for that date.
5. User edits and saves.

Wireframe requirements:

- Existing notes are edited rather than duplicated.
- Changing date to one with an existing note must not silently overwrite either note.

### Flow 9: Doctor-Visit Timeline Review

1. User opens Home for the selected child.
2. User taps Illness timeline.
3. Timeline opens with the most recent 7 days ending today.
4. User scans recorded days.
5. User adjusts date range if needed.
6. User uses the day-by-day facts to explain the illness.

Wireframe requirements:

- Date range and day count are visible.
- Recorded days are easy to scan.
- Empty days are compact.
- The page does not look like diagnosis output.

### Flow 10: Invite Caregiver

1. Existing caregiver opens Child Settings.
2. Existing caregiver taps Invite caregiver.
3. System provides a child-scoped invitation link or WeChat share card.
4. Existing caregiver shares it outside the daily recording path.

Wireframe requirements:

- Invite action lives in Settings.
- Invitation is clearly scoped to the current child.

### Flow 11: Invited Caregiver Joins

1. Invited user opens invitation.
2. System validates invitation.
3. Valid invitation shows Invitation Confirmation.
4. User chooses or enters caregiver label.
5. User taps Join.
6. System creates membership for that child.
7. User enters Home for the invited child.

Wireframe requirements:

- Invalid and expired states are separate.
- Already joined users go to Home without duplicate membership.
- Join creates membership only after explicit confirmation.

## Wireframe Notes

1. Keep Home focused on recording. The first screen should make the two main record actions immediately available.
2. Keep record management secondary. Records is for correction and browsing, not the main daily workflow.
3. Keep child context visible. Wrong-child recording is a major risk, so forms and sheets must show the current child before save or confirm.
4. Use explicit save boundaries. Opening the app, a sheet, or a form must never create a health fact.
5. Preserve the two-tap bowel movement fast path after Home appears: Record bowel movement -> Confirm.
6. Let illness recording succeed with one useful fact. A caregiver should not need to fill a clinical timeline.
7. Use progressive disclosure for details. Tags, notes, medicine history, and date range editing should not slow down the fast path.
8. Use date-level records. One bowel movement record per child per date, and one illness day note per child per date.
9. Keep Timeline scannable. Show recorded facts by day; omit empty fields; compress no-record days.
10. Avoid medical interpretation. Do not include diagnosis, recommendation, severity scoring, abnormality alerts, medicine advice, or report-like framing.
11. Keep invitation low-frequency. Shared access matters, but it belongs in Settings rather than Home.
12. Keep caregiver labels lightweight. Labels help attribution only; they are not roles or permissions.
13. Keep empty states calm. Do not imply the caregiver failed to record.
14. Preserve unsaved input on save errors. The user may be recording during a stressful moment.
15. Avoid MVP scope creep. Do not wireframe photos, growth albums, chat, comments, feeds, charts, reminders, AI summaries, drug databases, family roles, habit tracking, or teacher/doctor-facing portals.

