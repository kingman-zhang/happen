# Happen

## Project Overview

Happen is a WeChat Mini Program first product for parents of children aged 0-12.

The first version focuses on recording and reviewing a small set of child health facts:

- Bowel movement dates, so parents can quickly know how many days have passed since the last bowel movement.
- Daily illness notes, so parents can explain a recent fever/illness episode clearly when visiting or revisiting a doctor.

This file defines the project for AI agents and developers. It should guide future brainstorming, planning, TDD, implementation, and code review.

Happen is not currently a broad child event tracker. The initial product should stay narrow until the core assumptions are validated with real parents.

## Problem Statement

Parents often rely on memory, paper calendars, notes apps, WeChat messages to themselves, or Excel to track child health events.

These methods are usable, but they break down in specific situations:

- During a doctor visit, the parent cannot clearly answer when the fever started, how many days it lasted, the highest temperature, what medicines were taken, and how symptoms changed.
- A child has irregular bowel movements, and the parent cannot quickly tell whether it has been 2, 3, or 4 days since the last bowel movement.
- A paper calendar is convenient at home, but not available during an outpatient visit unless the parent remembered to take a photo.
- Excel is too slow and awkward on mobile for quick caregiving-context recording and review.

The core problem is not "parents have nowhere to write things down."

The core problem is:

> Parents need to quickly answer factual questions about recent child health events, but their current recording methods are scattered, hard to review, or unavailable at the moment of need.

## Target Users

Primary users:

- Parents of children aged 0-12.
- Parents who have previously been unable to clearly explain a child's recent illness history during a doctor visit.
- Parents who need to track irregular bowel movements.
- Parents who currently use memory, a paper calendar, notes apps, WeChat messages, or Excel for child health facts.
- Parents who are willing to use a lightweight WeChat Mini Program before a native app exists.

Non-primary users:

- Doctors, teachers, course providers, or caregivers as first-class users.
- Parents looking for a complete child growth album.
- Parents looking for medical advice, diagnosis, or treatment recommendations.
- Parents looking for a generic habit tracker or learning task system.

## Core Value Proposition

Happen helps parents record a few important child health facts with low effort and later review them in the form needed for real decisions or conversations.

The first version should help answer two questions:

1. How many days has it been since the child's last bowel movement?
2. During this illness episode, what happened each day: highest temperature, medicines taken, symptoms, and notes?

Happen should be better than a paper calendar, notes app, or Excel only in these narrow ways:

- Faster mobile entry for the target health facts.
- Faster review of recent bowel movement interval.
- Clearer day-by-day illness timeline for doctor visits or revisits.
- Less dependence on memory or carrying a paper record.

## Product Principles

### Record facts, not memories

Happen records health facts that may need future review. It is not a place for sentimental growth memories, photos, family sharing, or social posts.

### Review is more important than recording volume

The product should not optimize for the number of records created. It should optimize for whether a parent can answer a future question quickly.

### Use concrete user language

Frontend language should use concrete actions:

- Record bowel movement
- Record illness day
- Record temperature
- Record medicine
- Record symptoms
- View illness timeline

Avoid exposing generic product language such as:

- Add event
- Event type
- Event statistics

"Event" can exist as an engineering abstraction, but it should not be the primary user-facing concept.

### Keep entry lightweight

Parents record during caregiving situations: fever at night, medicine administration, outpatient preparation, or quick checks. Entry must stay quick and editable.

Avoid medical-grade structured entry in MVP:

- No drug database.
- No strict dosage system.
- No required exact time for every temperature or medicine.
- No complex symptom taxonomy.

### Do not depend on notifications

WeChat Mini Program notification behavior is limited and unreliable. Reminder features may enhance the product later, but MVP value must hold even without reliable push notifications.

### Do not provide medical judgment

Happen may organize facts. It must not diagnose, recommend medicine, decide whether to visit a doctor, or replace a doctor.

If AI is added later, it must only summarize user-recorded facts.

## MVP Scope

The MVP is limited to child health fact recording and review.

### Bowel Movement Tracking

MVP should support:

- Recording that a bowel movement happened on a specific date.
- Editing or deleting a bowel movement record.
- Showing how many days have passed since the most recent bowel movement.

MVP should not require stool type, color, amount, photos, or medical interpretation.

### Illness Day Notes

MVP should support illness records at day-level granularity.

Each illness day can contain:

- Date.
- Highest temperature of that day.
- Medicines taken that day as free text or multiple lightweight text entries.
- Main symptoms as simple text or lightweight tags.
- Optional notes.

Medicine entries may include user-written timing such as "morning", "afternoon", "before sleep", or "around 8 PM", but the system should not enforce minute-level medical timelines.

### Illness Timeline Review

MVP should support:

- Viewing an illness episode grouped by day.
- Seeing the number of days in the illness episode.
- Reviewing daily highest temperature, medicine text, symptoms, and notes.

The timeline should help a parent explain the illness to a doctor. It should not look like a diagnosis report.

### Lightweight Statistics

MVP statistics are limited to:

- Days since last bowel movement.
- Duration of current/recent illness episode.

No dashboard-style analytics in MVP.

## Out Of Scope

The following are explicitly out of scope for the first version:

- Growth album.
- Family photo timeline.
- Parenting community.
- AI medical consultation.
- Online doctor service.
- Diagnosis or treatment recommendation.
- Medicine recommendation.
- Course platform.
- Class hour tracking.
- Reading tasks.
- Points or rewards system.
- Exercise tracking.
- Tooth brushing tracking.
- Generic habit tracking.
- Generic child task management.
- Long-term health analytics dashboard.
- Drug database.
- Dose calculation.
- Symptom severity scoring.
- Stool photo analysis.
- Doctor-facing workflow.
- Teacher-facing workflow.

These items should not be added during MVP planning unless the project definition is intentionally revised.

## Core Concepts

### Child

The child whose health facts are being recorded.

MVP may assume a single child unless multi-child support is explicitly planned. If multi-child support is added, every health fact must belong to exactly one child.

### Health Fact

A recorded factual observation about the child.

Examples:

- A bowel movement happened on a date.
- The highest temperature on a date was 39.2°C.
- A medicine was taken on a date.
- A symptom was observed on a date.

Health facts should not contain diagnosis, medical advice, or AI-inferred certainty.

### Bowel Movement Record

A simple record that the child had a bowel movement on a date.

Primary review question:

> How many days has it been since the last bowel movement?

### Illness Episode

A bounded period of illness that parents want to review as one timeline.

Example:

> Fever started on June 1 and continued through June 3.

MVP should support reviewing an episode by day. The exact episode boundary model is an open design question.

### Illness Day Note

The day-level record inside an illness episode.

Expected fields:

- Date.
- Highest temperature.
- Medicines taken.
- Main symptoms.
- Notes.

### Timeline

A day-grouped review of an illness episode.

The timeline should preserve original user-entered facts and avoid over-summarizing.

### AI Fact Summary

Potential second-stage feature.

Allowed:

- Convert recorded facts into a concise factual summary.

Not allowed:

- Diagnose.
- Recommend treatment.
- Suggest medicine.
- Decide whether medical care is needed.

## User Scenarios

### Scenario 1: Parent Needs to Explain a Fever to a Doctor

The child has had a fever for several days. At the clinic, the doctor asks when the fever started, how high it got, what medicines were used, and what symptoms appeared.

The parent opens Happen and reviews the day-by-day illness timeline.

Success condition:

- The parent can answer from the timeline without relying on memory or searching scattered notes.

### Scenario 2: Parent Tracks Irregular Bowel Movement

The child does not have a bowel movement every day. The parent wants to know whether it has been too long since the last bowel movement.

The parent opens Happen and checks the "days since last bowel movement" value.

Success condition:

- The parent can know the interval immediately after opening the app.

### Scenario 3: Parent Records During a Busy Illness Day

The child is sick. The parent does not want to fill out a complex form.

The parent records one daily note: highest temperature, medicines taken, symptoms, and a short note.

Success condition:

- The record is useful later even if it is not medically precise.
- The parent does not abandon recording because of form complexity.

### Scenario 4: Parent Updates a Day Record Later

The parent first records the morning situation, then later adds afternoon medicine or updates the highest temperature.

Success condition:

- The daily record is editable.
- The final day note reflects the parent's best available facts for that day.

## Success Metrics

MVP success should not be measured by daily active users.

Better validation metrics:

- In a pre-development validation sample of 5 target parents, at least 3 report a concrete difficulty with recording or reviewing child fever, medicine, bowel movement, or similar health facts.
- In that same sample, at least 2 are willing to immediately save, try, or request access to a tool focused only on bowel movement interval and illness day notes.
- During real use, parents can create a bowel movement record in a few seconds.
- During real use, parents can create or update an illness day note without needing a precise medical timeline.
- During a doctor visit or revisit, a parent can use the timeline to explain the illness history more clearly than memory, paper calendar, notes app, or Excel.
- Parents who use Happen during one illness episode are willing to return during a later similar episode.
- Bowel movement tracking shows whether it can create a light checking habit without relying on push notifications.

Failure signals:

- Users say the idea is "useful" but cannot describe a real recent recording/review problem.
- Users prefer their paper calendar, notes app, WeChat messages, or Excel after trying the MVP.
- Users only remember the product when shown it, but not when the actual health event happens.
- The product adds reading, points, course, exercise, or tooth brushing features to chase frequency before validating health facts.

## Technical Constraints

Platform:

- WeChat Mini Program first.
- Native app may be considered only if the Mini Program validates the use case.

Backend:

- Java service.
- MongoDB.

Development constraints:

- Independent developer.
- MVP first.
- Prefer simple, maintainable implementation over broad feature coverage.
- Avoid early architecture that assumes a large platform.
- Avoid adding feature-specific subsystems before the core health fact workflow is validated.

Product/technical implications:

- Data model should allow health fact records to be grouped by child, date, and illness episode.
- User-facing UI should avoid generic "event management" language even if backend models use generic event-like storage.
- Reminder design must not assume reliable WeChat push delivery.
- Any future AI summary must retain links to original user records and must avoid medical advice.
- Privacy and data sensitivity should be treated seriously because the app stores child health information.

## Risks

### Pain May Be Founder-Specific

The initial need comes from one parent's real experience. It may not generalize.

Mitigation:

- Validate with at least 5 target parents before building a public MVP.

### Strongest Use Case Is Low Frequency

Illness timeline review is valuable, but children are not always sick. Users may forget the product when the next illness happens.

Mitigation:

- Test whether bowel movement interval tracking can serve as a light health-related anchor.
- Do not solve frequency by adding unrelated habit or learning features.

### Bowel Movement Tracking May Not Create a Habit

"Days since last bowel movement" is useful only after the parent opens the app. Without reliable reminders, sustained usage is uncertain.

Mitigation:

- Treat bowel tracking as an MVP assumption to validate, not as a proven retention mechanism.

### Scope Creep Toward Parenting OS

Because many child-related activities happen on dates, it is tempting to include learning, courses, tooth brushing, exercise, and rewards.

Mitigation:

- Keep MVP limited to health facts.
- Reject non-health features unless the project definition changes.

### Recording Cost May Exceed Current Tools

If Happen is slower than paper or notes, parents will not switch.

Mitigation:

- Keep day-level illness notes.
- Allow free text where structure would slow entry.
- Make records editable.

### Medical Trust Boundary

Users may treat organized health information or future AI summaries as medical advice.

Mitigation:

- Do not include diagnosis or recommendations.
- Keep AI out of MVP.
- If AI is added later, restrict it to factual summaries of user-entered data.

### WeChat Notification Limits

Reminder-based retention may be unreliable in a Mini Program.

Mitigation:

- MVP must work without reliable push notifications.

## Open Questions

1. Do enough target parents have this problem?
   - Validation standard: 5 interviews, at least 3 concrete pain cases, at least 2 willing to try/save the tool.

2. Is the first public positioning stronger around illness timeline, bowel movement interval, or "child health fact record"?
   - This should be tested with real parent responses, not decided only by internal reasoning.

3. Should MVP support one child only or multiple children?
   - Single child is simpler. Multiple children may be necessary for families with more than one child.

4. How should an illness episode start and end?
   - Options include manual episode creation, automatic grouping by consecutive illness day notes, or date-range selection.

5. What is the minimum acceptable medicine input model?
   - Free text is fastest. Multiple text entries may improve review. Structured medicine fields are out of scope for MVP.

6. What is the minimum useful symptom input model?
   - Free text and a few simple tags are possible. A complex symptom taxonomy is out of scope for MVP.

7. Should bowel movement records support multiple records per day?
   - MVP may only need "happened on date", but some parents may expect multiple records.

8. What privacy model is required before public use?
   - Child health data is sensitive. Account, storage, retention, deletion, and export expectations need explicit decisions.

9. When should AI fact summary be introduced?
   - Current decision: not in MVP. Revisit only after timeline recording and review are validated.
