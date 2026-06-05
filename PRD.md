# Happen MVP PRD

This PRD defines the first MVP for Happen, a WeChat Mini Program for parents and invited caregivers of children aged 0-12. The MVP is intentionally narrow: it records and reviews a small set of child health facts so caregivers can answer practical questions before or during a doctor visit.

Source documents:

- `PROJECT.md`
- `docs/superpowers/specs/2026-06-04-happen-mvp-review-value-design.md`
- `MVP Scope Review.md`

## Product Goals

1. Help caregivers record child health facts quickly during real caregiving moments.
2. Help caregivers review recent bowel movement and illness facts in about 2 minutes.
3. Help the caregiver who takes the child to the doctor access facts recorded by another caregiver.
4. Validate whether a narrow health fact review tool is more useful than memory, paper calendars, notes apps, WeChat messages, or Excel.
5. Keep the MVP focused on factual review, not medical advice, family social networking, generic event tracking, or long-term analytics.

Success signals:

- In 5 target-parent interviews, at least 3 parents describe a concrete recent difficulty recording or reviewing fever, medicine, bowel movement, or similar child health facts.
- At least 2 of those parents are willing to try a tool focused only on bowel movement interval and illness day notes.
- A caregiver can record a bowel movement in a few seconds.
- A caregiver can create or update an illness day note without needing a precise medical timeline.
- A caregiver can review a selected date range in about 2 minutes and explain the child's recent illness more clearly.
- In a shared-care scenario, one caregiver can record facts and another caregiver can review them before or during a doctor visit.

## Personas

### Primary Parent

- Parent of a child aged 0-12.
- Often records health facts using memory, paper calendars, notes apps, WeChat messages, or Excel.
- Needs to answer concrete questions during doctor visits, such as when fever started, the highest temperature, what medicine was taken, symptoms, and when the child last had a bowel movement.

### Doctor-Visit Caregiver

- Parent or family caregiver who may not be the person who originally recorded the facts.
- Needs to review recent health facts quickly before or during an outpatient visit.
- Values clear day-by-day review more than detailed data entry.

### Invited Caregiver

- Grandparent or another invited family caregiver who helps record or review the same child's health facts.
- May be less comfortable with complex apps.
- Needs simple child-scoped access, not family social features or permission management.

## User Stories

1. As a parent setting up Happen before the next health event happens, I want to add a child with a nickname and identify myself with a caregiver label so future records are tied to the right child and understandable to other caregivers without requiring formal identity details.
2. As a caregiver who helps more than one child, I want to clearly switch the current child before recording or reviewing anything so I do not mix up siblings' health facts during a rushed caregiving moment.
3. As a parent who records facts at home but may not be the one taking the child to the doctor, I want to invite another caregiver to the child's records so that person can review the same facts when they need to explain the situation.
4. As a caregiver checking whether a child's bowel movement interval is getting long, I want to record each bowel movement quickly by date so I can later answer whether it has been 2, 3, or 4 days since the last bowel movement.
5. As a caregiver who realizes a bowel movement was missed or entered on the wrong date, I want to edit or delete that day's record so the interval shown later is trustworthy.
6. As a caregiver dealing with fever, medicine, or symptoms during the day, I want to capture the important facts for that date so I do not have to reconstruct them from memory at the clinic.
7. As a caregiver recording illness facts while tired, busy, or on mobile, I want quick words and free text for symptoms and medicines so I can record enough useful detail without filling a clinical timeline.
8. As a caregiver preparing for a doctor visit or revisit, I want to review illness facts by a selected date range so I can explain what happened each day in a clear order.
9. As a caregiver reviewing records created by someone else, I want to see lightweight creator or last-editor labels where useful so I can understand who last touched a fact if something looks unfamiliar.
10. As a caregiver using Happen for child health facts, I want the product to avoid diagnosis and medication advice so I can trust it as a factual record rather than mistake it for a doctor.

## Functional Requirements

### Feature 1: First-Use Child And Caregiver Setup

#### User Value

Caregivers can start using Happen with minimal friction and without entering unnecessary sensitive details. The product immediately anchors all records to a child and a caregiver label.

#### Business Rules

- If the user has no child, show first-use setup.
- Setup requires a child nickname.
- Setup requires a caregiver label for the current user.
- Suggested caregiver labels include Mom, Dad, Grandma, Grandpa, and Other.
- Child real name, birthday, gender, avatar, and caregiver real name are not required in MVP.
- After setup, the user becomes a caregiver member of that child and enters that child's home view.
- A caregiver label is display text only. It is not a permission role and does not need to be unique.

#### Exception Scenarios

- If child nickname is empty, prevent completion and ask the user to enter a nickname.
- If caregiver label is empty, prevent completion and ask the user to choose or enter a label.
- If setup fails due to network or server error, keep entered values and let the user retry.
- If a duplicate nickname exists for the same user, allow it but make the child selector clear enough to avoid accidental switching.

#### Acceptance Criteria

- Given a new user with no child, when they open Happen, then they see first-use setup.
- Given the user enters child nickname and caregiver label, when they confirm, then a child and membership are created.
- Given setup succeeds, when the user lands on home, then the newly created child is selected.
- Given setup is opened, when the user does not confirm, then no child or health fact is created.
- Given child nickname is empty, when the user confirms setup, then setup is blocked and no child is created.
- Given caregiver label is empty, when the user confirms setup, then setup is blocked and no membership is created.
- Given setup submission fails, when the error is shown, then previously entered nickname and caregiver label remain available for retry.

### Feature 2: Current Child Context And Home

#### User Value

Caregivers can see the currently selected child and immediately access the highest-value recording and review actions.

#### Business Rules

- Home always operates within one selected child context.
- If the user has access to multiple children, provide a child selector.
- All home status, actions, and records must belong only to the selected child.
- Home shows bowel movement status as the primary daily health anchor.
- Home exposes actions to record a bowel movement, view or edit bowel movement records, record today's illness day, and view illness timeline.
- Home must use concrete health fact language, not generic event language.

#### Exception Scenarios

- If the selected child becomes unavailable, prompt the user to select another accessible child.
- If the user has no accessible child, return to first-use setup or invitation entry.
- If status data cannot load, show a retry state without creating records.

#### Acceptance Criteria

- Given a caregiver has one child, when home loads, then that child is selected automatically.
- Given a caregiver has multiple children, when they switch child, then all displayed statuses and actions update to that child.
- Given home loads, then it shows days since last bowel movement when a bowel movement record exists.
- Given no bowel movement record exists for the child, then home shows an empty state instead of an incorrect interval.
- Given the caregiver switches from Child A to Child B, when they record a health fact, then the new fact belongs to Child B only.
- Given a user loses access to the selected child, when home reloads, then records for that child are not shown and the user is asked to choose another accessible child.
- Given home status fails to load, when the retry state is shown, then no health fact is created as a side effect.

### Feature 3: Invite Caregiver And Shared Membership

#### User Value

The caregiver who records health facts and the caregiver who takes the child to the doctor can both access the same child records.

#### Business Rules

- A caregiver can invite another caregiver to a specific child from child settings.
- The invitation is scoped to one child only.
- Each invitation stores target child, inviter, creation time, expiration time, and status.
- MVP invitation links expire 7 days after creation unless implementation chooses a shorter security window.
- An invitation is valid only when the token exists, is well-formed, has not expired, has not been revoked or disabled, and points to an existing child that the inviter can still access.
- An invitation is expired when the current time is later than its expiration time.
- MVP invitations may be opened by more than one user before expiration because WeChat share cards or links are not bound to a known recipient.
- Accepting the same invitation more than once by the same user is idempotent: it must not create duplicate memberships.
- An invited user must confirm joining and choose a caregiver label.
- After joining, the invited caregiver can view and edit that child's MVP health facts.
- MVP permissions are simple: all caregivers for a child can view and edit that child's bowel movement records, illness day notes, and timeline.
- MVP does not include family groups, role hierarchy, read-only permissions, approval flows, chat, comments, or activity feeds.
- Records store creator and last editor.

#### Exception Scenarios

- If the invitation token is missing, malformed, not found, revoked, disabled, points to a deleted child, or points to a child the inviter can no longer access, show an invalid invitation state and do not create membership.
- If the invitation is opened after its expiration time, show an expired invitation state and do not create membership.
- If the invited user cancels before joining, do not create membership.
- If the invited user already has access to the child, do not create another membership; take them to that child's home view.
- If the same user confirms the same invitation multiple times, the first successful confirmation creates membership and later confirmations are treated as already joined.
- If two different users open the same valid invitation before expiration, each may join the same child with their own caregiver label.
- If membership creation fails, keep the confirmation page available and let the user retry.

#### Acceptance Criteria

- Given an existing caregiver opens child settings, when they choose invite caregiver, then Happen provides a child-scoped invitation.
- Given an invited user opens a valid invitation, when they choose a caregiver label and confirm, then membership is created for that child.
- Given the invited caregiver joins, when they open home, then the invited child is selected or available in the child selector.
- Given a caregiver belongs to one child but not another, when they request records, then they can access only the child where they have membership.
- Given an invitation token is missing, malformed, not found, revoked, disabled, points to a deleted child, or points to a child the inviter can no longer access, when the user opens it, then Happen shows an invalid invitation state and creates no membership.
- Given an invitation is opened after its expiration time, when the user attempts to join, then Happen shows an expired invitation state and creates no membership.
- Given an invited user cancels on the confirmation page, when they leave the flow, then no membership is created.
- Given a user who already belongs to the child opens the same invitation again, when they confirm or continue, then Happen does not create a duplicate membership and takes them to that child's home.
- Given the same user submits the same valid invitation twice, when both submissions are processed, then the user has exactly one membership for that child.
- Given two different users open the same valid invitation before expiration, when each confirms with a caregiver label, then each receives their own membership for the same child.
- Given an invited caregiver joins Child A through an invitation, when they request Child B records without Child B membership, then access is denied.

### Feature 4: Child Settings

#### User Value

Caregivers can manage the minimal information needed for shared health fact recording without entering family-management complexity.

#### Business Rules

- Child settings show child nickname.
- Child settings show the current user's caregiver label for that child.
- Child settings show the child caregiver list by display label.
- Child settings provide the invite caregiver action.
- The current user's caregiver label can be edited.
- Caregiver labels are not unique and do not define permission level.
- Child settings must not expose family groups, roles, read-only switches, approvals, chat, or activity feed.

#### Exception Scenarios

- If nickname update fails, keep the previous nickname and show retry.
- If caregiver label update fails, keep the previous label and show retry.
- If caregiver list cannot load, show a retry state while preserving other settings where possible.

#### Acceptance Criteria

- Given a caregiver opens child settings, then they see child nickname, their label, caregiver list, and invite action.
- Given a caregiver updates their label, when update succeeds, then future creator and last-editor labels use the updated label.
- Given two caregivers use the same label, then both labels are allowed.
- Given a caregiver opens settings, then no social, chat, role hierarchy, or approval controls are shown.
- Given child nickname update fails, when the error is shown, then the old nickname remains in effect.
- Given caregiver label update fails, when the error is shown, then the old label remains in effect.
- Given the caregiver list fails to load, when settings is shown, then no caregiver is removed or hidden as a persisted change.

### Feature 5: Bowel Movement Recording And Review

#### User Value

Caregivers can quickly answer how many days have passed since the child's last bowel movement and how many times a selected date was recorded.

#### Business Rules

- One bowel movement record exists per child per date.
- A bowel movement record stores date, count, optional observation tags, optional note, creator, and last editor.
- The home action "record one bowel movement" opens a lightweight confirmation panel.
- Date defaults to today and can be changed before confirmation.
- Confirming increments the count for the selected child and date by 1.
- Opening the app or opening the confirmation panel must not create a record.
- Caregivers can edit date, count, observation tags, and note.
- Caregivers can delete a bowel movement record.
- Optional observation tags are quick record words for unusual days, not stool classification.
- MVP does not include stool color, photos, Bristol stool scale, abnormality alerts, or trend charts.

#### Exception Scenarios

- If the user cancels the confirmation panel, no record is created or changed.
- If the date already has a record, confirmation increments the existing count instead of creating a duplicate date record.
- If the edited count is zero or empty, require correction or offer deletion.
- If saving fails, preserve the user's input and show retry.
- If two caregivers update the same date, the system must preserve a valid count and last-editor metadata.

#### Acceptance Criteria

- Given a child has no bowel movement record today, when a caregiver confirms "record one bowel movement", then today's count becomes 1.
- Given a child already has count 1 today, when a caregiver confirms again for today, then today's count becomes 2.
- Given the confirmation panel is opened, when the caregiver closes it without confirming, then no count changes.
- Given a bowel movement record exists, when a caregiver edits count, tags, or note and saves, then the record updates for that child and date.
- Given a bowel movement record is deleted, when home recalculates status, then days since last bowel movement uses the next most recent record or shows empty state.
- Given the app is opened, when the user takes no record action, then no bowel movement record is created.
- Given the confirmation panel is opened, when the user takes no confirm action, then no bowel movement record is created.
- Given the user edits count to zero or empty, when they try to save, then save is blocked or the user is asked to delete the record instead.
- Given the selected date already has a record, when the user records one bowel movement, then Happen updates the existing date record and does not create a duplicate record for that child and date.
- Given saving fails, when the error is shown, then the previous saved record remains unchanged and the user's unsaved input is available for retry.

### Feature 6: Illness Day Notes

#### User Value

Caregivers can record the day-level facts they may need for a doctor visit without filling a medical-grade timeline.

#### Business Rules

- One illness day note exists per child per date.
- An illness day note stores date, highest temperature, medicines, symptoms, note, creator, and last editor.
- The "record today's illness day" action opens a form with date defaulted to today.
- If a note already exists for that child and date, the form edits the existing note.
- The form saves only after explicit user confirmation.
- Date is required.
- At least one fact besides date must be entered or selected before saving.
- Highest temperature, medicines, symptoms, and note are individually optional.
- Medicines and symptoms support free text.
- Symptom quick words may be offered as recording shortcuts.
- Medicine quick words may be offered only as records of medicines already used.
- Medicine quick words must include safety copy that they are not medication advice.
- MVP does not include dosage calculation, drug instructions, drug database, symptom severity scoring, or medical recommendation.

#### Exception Scenarios

- If the user attempts to save with only date, prevent save and ask them to enter something they want to review later.
- If the user cancels the form, no note is created or changed.
- If the date is changed to a date with an existing note, load that note for editing or clearly warn before merging.
- If saving fails, preserve entered content and show retry.
- If two caregivers edit the same illness day, preserve a valid latest version and last-editor metadata.

#### Acceptance Criteria

- Given the caregiver opens the illness day form, when they do not save, then no note is created.
- Given the caregiver enters only symptoms and saves, then the illness day note is valid.
- Given the caregiver enters only medicine text and saves, then the illness day note is valid.
- Given the caregiver enters only free-text note and saves, then the illness day note is valid.
- Given the caregiver attempts to save only a date, then save is blocked.
- Given a note already exists for the selected date, when the caregiver opens the form, then they edit the existing note rather than creating a duplicate.
- Given the caregiver cancels the form, when they return home, then no illness day note is created or changed.
- Given medicine quick words are displayed, when the user views them, then safety copy states they record medicines already used and are not advice.
- Given the date is changed to another date with an existing note, when that date is selected, then Happen must not silently overwrite either note.
- Given saving fails, when the error is shown, then the last saved note remains unchanged and unsaved user input remains available for retry.

### Feature 7: Illness Timeline Review

#### User Value

Caregivers can review recent illness facts by day and explain the situation more clearly before or during a doctor visit.

#### Business Rules

- Timeline is scoped to the selected child.
- Timeline uses a selected date range, not stored or inferred illness episodes.
- Default date range is the most recent 7 days ending today.
- Caregivers can manually change start and end dates.
- Timeline shows the number of days in the selected range.
- For each date, timeline shows highest temperature, medicines, symptoms, and note when present.
- Days without illness day notes may show "no record" without guilt-inducing language.
- Timeline may show creator or last editor where useful.
- Timeline must avoid copy such as "automatically detected illness episode" or "system judged illness."
- Timeline must not look like a diagnosis report.

#### Exception Scenarios

- If the selected range has no illness day notes, show an empty state with actions to record today's illness day or change date range.
- If the start date is after the end date, prevent applying the range and ask for correction.
- If timeline data cannot load, show retry without changing stored records.
- If a date has partial data, show the available facts and omit empty fields.

#### Acceptance Criteria

- Given the caregiver opens illness timeline, then the default range is the most recent 7 days ending today.
- Given the caregiver changes date range, then the timeline updates to the selected range and shows the correct day count.
- Given illness day notes exist in the range, then they are grouped by date and show recorded facts.
- Given no illness day notes exist in the range, then the empty state appears and no records are created.
- Given a day has no note, then the timeline can show no record without implying the caregiver failed to record.
- Given the start date is after the end date, when the caregiver applies the range, then the range is rejected and the previous valid timeline remains.
- Given timeline data fails to load, when the retry state is shown, then no illness day note is created, edited, or deleted.
- Given a date has only symptoms and no medicine or temperature, when the timeline renders that date, then it shows symptoms and omits empty fields.
- Given the timeline opens, when records are shown, then the page does not claim to automatically detect an illness episode.

### Feature 8: Safety And Scope Guardrails

#### User Value

Caregivers can trust Happen as a factual record without mistaking it for medical advice or a clinical decision tool.

#### Business Rules

- The product records facts and user-entered observations only.
- The product must not diagnose, recommend medicine, calculate dosage, decide whether to visit a doctor, or replace a doctor.
- Medicine quick words are recording shortcuts only.
- User-facing copy should use concrete health fact language.
- User-facing copy should avoid generic "event" language as the main concept.
- MVP must not include AI summary, notifications, charts, medical recommendation logic, complex permissions, family social features, or stored illness episode automation.

#### Exception Scenarios

- If a user enters medical advice-like text in a note, store it as user-entered text without presenting it as system guidance.
- If a medicine quick word is shown, also show safety copy in the relevant context.
- If a feature request requires diagnosis, recommendation, reminders, or analytics, mark it as future scope or out of scope rather than adding it to MVP.

#### Acceptance Criteria

- Given the user views medicine quick words, then the interface states they are only for recording already used medicines or care items and are not advice.
- Given the user reviews timeline, then the screen presents facts by date and does not provide diagnosis or recommendation.
- Given the user navigates the MVP, then no family social, generic event, reminder, chart, AI summary, drug database, or medical advice feature is present.
- Given a health fact is opened or edited, then it is saved only after explicit user action.
- Given a user enters advice-like text in a note, when it is displayed later, then it is shown as user-entered note content and not as system guidance.
- Given symptoms are selected, when the note is saved or reviewed, then Happen does not calculate severity or recommend medicine.
- Given a future-scope feature such as reminders, charts, AI summary, or drug database is requested, when evaluating MVP scope, then it is not treated as an MVP requirement.

## User Flow

### First-Use Flow

1. User opens Happen.
2. If the user has no child, Happen shows setup.
3. User enters child nickname.
4. User chooses or enters caregiver label.
5. User confirms.
6. Happen creates child and membership.
7. User enters the selected child's home view.

### Daily Bowel Movement Flow

1. Caregiver opens home for the selected child.
2. Caregiver checks bowel movement status.
3. Caregiver taps "record one bowel movement."
4. Confirmation panel opens with date defaulted to today.
5. Caregiver confirms or changes date and confirms.
6. Happen increments the count for that child and date.
7. Home updates days since last bowel movement and today's count.

### Illness Day Recording Flow

1. Caregiver opens home for the selected child.
2. Caregiver taps "record today's illness day."
3. Illness day form opens with date defaulted to today.
4. Caregiver enters one or more facts: highest temperature, medicines, symptoms, or note.
5. Caregiver saves.
6. Happen creates or updates the illness day note for that child and date.

### Doctor-Visit Review Flow

1. Caregiver opens home for the selected child.
2. Caregiver taps "view illness timeline."
3. Timeline opens with the most recent 7 days.
4. Caregiver adjusts the date range if needed.
5. Caregiver reviews daily highest temperature, medicines, symptoms, and notes.
6. Caregiver uses the timeline to explain recent facts to a doctor or another caregiver.

### Shared Caregiver Flow

1. Existing caregiver opens child settings.
2. Existing caregiver chooses invite caregiver.
3. Happen generates a child-scoped WeChat share card or invitation link.
4. Invited user opens the invitation.
5. Invited user confirms the child and access meaning.
6. Invited user chooses caregiver label.
7. Invited user joins and enters that child's home.
8. Invited user can view and edit that child's MVP health facts.

## Screen List

1. First-Use Setup
   - Child nickname input.
   - Caregiver label selection or input.
   - Confirm action.

2. Home
   - Current child selector.
   - Days since last bowel movement.
   - Today's bowel movement count when relevant.
   - Record one bowel movement action.
   - View or edit bowel movement records action.
   - Record today's illness day action.
   - View illness timeline action.

3. Child Selector
   - Accessible children list.
   - Current child indicator.
   - Switch child action.

4. Child Settings
   - Child nickname.
   - Current user's caregiver label.
   - Caregiver list.
   - Invite caregiver action.

5. Invitation Confirmation
   - Child nickname.
   - Explanation of shared access.
   - Caregiver label selection or input.
   - Join action.
   - Invalid invitation state.

6. Bowel Movement Confirmation Panel
   - Date field defaulted to today.
   - Confirm record action.
   - Cancel action.

7. Bowel Movement Record Editor
   - Date.
   - Count.
   - Optional observation tags.
   - Optional note.
   - Save action.
   - Delete action.

8. Illness Day Form
   - Date.
   - Highest temperature.
   - Medicine free text.
   - Medicine quick words with safety copy.
   - Symptom free text or quick tags.
   - Optional note.
   - Save action.

9. Illness Timeline
   - Selected date range.
   - Date range edit action.
   - Day count.
   - Daily grouped illness facts.
   - Empty state.

## Acceptance Criteria

MVP-level acceptance:

1. A new caregiver can create a child with nickname and caregiver label.
2. A caregiver can switch between accessible children without seeing or editing another child's records accidentally.
3. A caregiver can invite another caregiver to one child.
4. An invited caregiver can join and view or edit only that child's MVP health facts.
5. A caregiver can record one bowel movement with explicit confirmation.
6. Repeated bowel movement recording on the same date increments one date-level record.
7. A caregiver can edit and delete bowel movement records.
8. Home accurately shows days since last bowel movement when data exists.
9. A caregiver can create or update illness day notes with at least one fact besides date.
10. Opening an illness form never creates a note by itself.
11. A caregiver can review illness day notes by the default 7-day range.
12. A caregiver can manually adjust the illness timeline date range.
13. Timeline review shows recorded facts by day and does not diagnose or recommend treatment.
14. Medicine quick words are clearly presented as recording shortcuts, not advice.
15. MVP contains no family social features, generic event tracker, drug database, AI summary, notification-dependent reminders, charts, or automatic illness episode detection.

Review-value acceptance:

1. A caregiver can record a bowel movement in a few seconds.
2. A caregiver can record an illness day without entering a precise medical timeline.
3. A caregiver can use the selected date-range timeline to explain recent illness facts in about 2 minutes.
4. A shared-care scenario works when one caregiver records facts and another caregiver reviews them.

## Future Scope

Future scope should be considered only after the MVP validates narrow review value with real parents.

Potential future additions:

- AI summary of user-recorded facts, limited to summarization and never medical advice.
- Reminder features that do not make MVP value depend on unreliable push notifications.
- More configurable symptom and medicine recording words.
- Better shared-care editing history.
- Export or shareable factual summaries for caregivers.
- Light trend views if parents prove repeated review value beyond the recent doctor-visit scenario.

Explicitly out of MVP:

- Medical advice, diagnosis, treatment recommendation, medicine recommendation, or dose calculation.
- Drug database.
- Automatic illness episode detection.
- Stool classification, stool photo analysis, or abnormality alerts.
- Growth album, photos, family chat, comments, feeds, or social features.
- Generic habits, courses, tasks, points, reading, exercise, or tooth brushing.
- Doctor-facing or teacher-facing workflows.
