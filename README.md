# Chama Manager Mobile App (Kotlin + Jetpack Compose)

A digitized mobile solution for **Chamas, SACCOs, and Rotating Savings and Credit Associations (ROSCAs / Merry-Go-Rounds)** built with modern Android (Kotlin, Jetpack Compose, Material 3, Room, Coroutines/Flow, WorkManager, and Mobile Money M-Pesa integration).

---

## 🌟 Core Features & Modules

### 1. 🔄 Digitized Rotating Saving Groups (Merry-Go-Round / ROSCA)
* **Automated Cycle & Round Engine:** Auto-calculates pool totals, collection status, round numbers, and progress percentages.
* **Payout Queue Matrix:** Transparent visual schedule for all member payout turns.
* **Slot Swapping:** Members can swap payout positions with mutual consent or Admin approval for urgent financial emergencies.
* **One-Click Payout Disbursement:** Direct payout disbursement to scheduled member recipients via Mobile Money B2C.

### 2. 📱 Mobile Money Integration (M-Pesa STK Push / USSD Prompt)
* **Instant Digital Collections:** Members initiate payments directly inside the app.
* **Interactive STK Push Simulator & Daraja Client:** Simulates real-time SIM Application Toolkit prompt (enter 4-digit PIN, timeout countdown, validation, and authentic M-Pesa receipt generation).
* **Automatic Ledger Posting:** As soon as payment is confirmed, the app creates matching double-entry ledger entries automatically without manual entry errors.

### 3. 👥 Members & Role-Based Access Control (RBAC)
* **Roles:**
  * **Chairperson (Admin):** Group governance, loan policy approvals, dispute management.
  * **Treasurer:** Cash/wallet oversight, loan disbursements, payout sign-offs, ledger audits.
  * **Secretary:** Member registration, minutes, and notifications.
  * **Member:** View transparent records, make contributions, participate in rounds, apply for loans.
* **Enforced Permissions:** Only authorized roles can approve loans or disburse funds.

### 4. 💰 Contributions Management
* Categorized tracking for:
  * Regular Merry-Go-Round collections
  * Monthly Group Savings / Investment Fund
  * Emergency & Welfare ("Benevolent") Reserve
  * Late Contribution Fines
* Filter by category and member with instant search and receipt verification.

### 5. 🏦 Loans & Credit Management
* **Prudential Limits:** Maximum borrowing limit enforced based on savings multiplier (e.g. max 3x savings).
* **Guarantor System:** Member selection for loan endorsement.
* **Amortization & Interest:** Configurable interest rate (e.g. 10%) and loan duration (1 to 12 months).
* **Workflow:** `Applied` ➔ `Approved` ➔ `Disbursed` ➔ `Repaying` ➔ `Fully Paid`.
* **One-Tap Repayment:** Direct partial or full repayment via M-Pesa STK push.

### 6. 📊 Transparent Records & Automatic Ledgers
* **Double-Entry Bookkeeping Engine:**
  * Cash & Mobile Money Wallet (Asset `1010`)
  * Loans Receivable Principal (Asset `1020`)
  * Rotating Pool Liability (Liability `2010`)
  * Member Savings Equity (Equity `3010`)
  * Welfare Reserve (Equity `3020`)
  * Loan Interest Income (Revenue `4010`)
  * Late Fine Income (Revenue `4020`)
* **Real-time Trial Balance:** Guarantees $\text{Total Assets} = \text{Total Liabilities} + \text{Equity}$.
* **Certified Audit Statement Generator:** Generates formatted certified audit statements with tamper-evident logs for group meetings, exportable with one click.

### 7. 🔔 Automated Reminders & Alerts
* **Scheduled Reminders:**
  * Upcoming contribution reminders (days before deadline)
  * Overdue loan installment alerts
  * Rotating round payout celebration notices
* **Multi-channel:** In-app push notifications and simulated SMS mobile alerts.
* **Android WorkManager:** Background worker automatically checks due dates and triggers notifications even when the app is closed.

---

## 🏗️ Architecture & Tech Stack

```
com.chamamanager.app/
├── ChamaApp.kt                          # Application class & DI wiring
├── data/
│   ├── local/                           # Room Database, DAOs, TypeConverters, Entities
│   │   ├── ChamaDatabase.kt             # Room DB with realistic sample Chama data
│   │   ├── dao/                         # MemberDao, RotatingRoundDao, ContributionDao, LoanDao, LedgerDao, ReminderDao
│   │   └── entity/                      # ChamaEntities.kt
│   ├── remote/mobilemoney/              # MpesaModels, MobileMoneyService, MobileMoneySimulator
│   └── repository/                      # ChamaRepository, ChamaRepositoryImpl (Double-entry engine)
├── domain/
│   ├── model/                           # Role, Member, ChamaGroup, RotatingRound, Contribution, Loan, LedgerEntry, Reminder
│   └── usecase/                         # ProcessContributionUseCase, LoanUseCases, RotateMerryGoRoundUseCase, ReconcileLedgerUseCase, TriggerReminderUseCase
├── workers/                             # ScheduledReminderWorker, AutomaticLedgerReconciliationWorker
└── ui/
    ├── theme/                           # Color, Type, Theme (M-Pesa Green & Material 3)
    ├── components/                      # StkPushSimulationDialog, StatusBadge, StatCard
    ├── screens/                         # Dashboard, RotatingRounds, Contributions, Loans, Members, Ledger, Reminders
    ├── navigation/                      # ChamaNavGraph (Bottom Navigation Bar)
    └── MainActivity.kt                  # Root Activity
```

---

## 🚀 Getting Started

### Prerequisites
* **Android Studio** (Hedgehog 2023.1.1 or newer / Ladybug / Koala)
* **JDK 17 or 21**
* **Android SDK 34** (Min SDK: 26)

### Opening in Android Studio
1. Open Android Studio.
2. Select **File > Open** and select the folder `C:\chama manager`.
3. Allow Gradle to sync dependencies.
4. Select an Android Emulator or connected physical device (Android 8.0+).
5. Click **Run** (`Shift + F10`).

---

## 🧪 Running Unit Tests

Run the domain validation and double-entry ledger unit tests:
```bash
./gradlew test
```
* `DoubleEntryLedgerTest`: Validates the double-entry accounting equation ($\text{Assets} = \text{Liabilities} + \text{Equity} + \text{Revenue}$).
* `LoanRulesTest`: Validates 3x savings borrowing cap and RBAC role permissions.
