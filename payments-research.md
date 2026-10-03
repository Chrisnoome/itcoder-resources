# Payments research: gateways and subscription enforcement for BestLessons

Researched 3 October 2026. Primary sources only. Each fee and claim carries the URL it came from, and every page was checked on 3 Oct 2026 unless the text says otherwise. "UNVERIFIED" means only a secondary source had the figure, or the official page did not say. VAT on fees is 15%. BestLessons is not VAT registered, so the VAT on gateway fees is a real cost. All rand amounts below are ex VAT unless they say "incl VAT".

Context: plain PHP + SQLite on one VPS. Billing tables already exist (`plans`, `subscriptions`, `payments`, `invoices`, `accessCodes`, `aiUsage`), and access is decided only by `Entitlements()` in `lib/billing.php`. This file does not redesign that. It picks the gateway(s) and the pattern for keeping `subscriptions` in step with money received.

---

## Recommendation

1. **Primary SA gateway: Paystack.** It is the cheapest card rate for the R50 to R500 range: 2.9% + R1, with the R1 waived under R10. Instant EFT and Capitec Pay are 2% with no flat fee. There is no monthly fee and payouts are free (settled in 2 working days).
   - The API is clean JSON REST: one HMAC-SHA512 header to verify webhooks, a "verify transaction" call, and reusable card authorizations we can charge on our own schedule.
   - It is owned by Stripe ("Paystack is a Stripe company").
   - A sole proprietor can sign up (choose the "Sole Proprietorship" type), with a R1,000,000 collection limit until upgraded to a registered business. Paystack's status page showed 99.95% uptime for SA transactions over 90 days.
2. **Fallback / second SA gateway: PayFast.**
   - Pros: best known to SA parents, and it has the widest set of methods (SnapScan, Zapper, Mobicred, Payflex, MoreTyme).
   - Cons: it costs more on small amounts (3.2% + R2 card, R8.70 per withdrawal), and its ITN needs a four-step check (MD5 signature with passphrase, host check, amount check, server validate call).
   - Keep it as a second option if Paystack onboarding fails or parents ask for SnapScan.
   - PayFast is the only SA gateway here with self-service card subscriptions and an official PHP SDK.
   - Yoco and iKhokha have no recurring billing. Ozow's recurring billing is Capitec-only and needs Ozow's approval.
3. **International buyers: start with Paystack international cards.** They cost 3.1% + R1, charged and settled in rand, with no extra account. Prices are shown in ZAR, so the buyer's bank does the conversion.
   - Only move to a merchant of record (Paddle at 5% + 50c) if foreign sales grow enough that foreign VAT/sales-tax registration becomes a burden.
   - Do not start on Lemon Squeezy. Its sellers are being moved to Stripe Managed Payments, which does not accept South African businesses.
   - Stripe itself is not available to SA businesses.
4. **Subscription pattern: we own the schedule.** The default is pay-per-period with reminders (no auto-renew).
   - Auto-renew is an opt-in. It charges a saved Paystack card authorization from our own daily cron, with our own retries and a 7-day grace period.
   - Schools stay on invoice + EFT.
   - Gateway-owned subscription plans are not used, because they would create a second source of truth next to `subscriptions`. Paystack's own subscriptions also do not retry a failed charge.
5. **Enforcement:**
   - Verified webhooks and the daily reconciliation job are the only things that change `subscriptions`.
   - Every gateway event is stored once (unique event key) before it is acted on.
   - `Entitlements()` keeps reading only `subscriptions` and honours a grace date.
   - Every billing change goes to an append-only log.
6. **Legal must-dos:**
   - Contract with and charge the parent (CPA s39).
   - Show the ECTA s43 information at checkout.
   - Get consent for immediate access, so the ECTA 7-day cooling-off right falls away (s42(2)(d)), or simply offer a 7-day refund.
   - For annual consumer plans, send the CPA s14 expiry notice 40 to 80 business days before the end date. The current 30-day and 7-day reminders are too late for this.

---

## Comparison: SA gateways

Fees as published; "ex VAT" unless noted. Worked examples add 15% VAT on the fee, because BestLessons cannot claim it back.

| Gateway | Card R100 (fee → incl VAT) | Card R1000 | Instant EFT / Capitec Pay R100 | Monthly / payout | Recurring | PHP effort | Who can sign up |
|---|---|---|---|---|---|---|---|
| **Paystack** | 2.9% + R1 = R3.90 → **R4.49** | R30.00 → **R34.50** | 2% = R2.00 → **R2.30** | None; payouts free; T+2 working days | Plans (Paystack schedule) or charge saved authorization (our schedule); cards only | Low: JSON REST + HMAC header | Sole proprietor / starter (R1m limit) or registered business |
| **PayFast** | 3.2% + R2 = R5.20 → **R5.98** | R34.00 → **R39.10** | 2% (min R2) = R2.00 → **R2.30** | None; R8.70 per withdrawal; 48 h hold | Subscriptions (PayFast schedule) or tokenization (our schedule, adhoc API); credit card only; min R5 | Medium: form post + MD5 signature + 4 ITN checks; official PHP SDK (last pushed Feb 2024) | Company, sole trader, non-profit; SA bank account |
| **Peach Payments** (Growth) | 2.95% + R1.50 = R4.45 → **R5.12** | R31.00 → **R35.65** | 1.5% + R1.50 = R3.00 → **R3.45** | No setup or monthly fee; **R200/month tokenisation fee** for saved cards; daily settlement | Recurring cards at 3.50% + R1.50 (R100 → R5.75 incl VAT) | Medium (HMAC or AES-GCM webhooks) | Sole proprietors and registered businesses |
| **Ozow** | 2.85% (min R1) = R2.85 → R3.28 if ex VAT (VAT treatment not stated) | R28.50 → R32.78 | 1.5% (min R1) = R1.50 → **R1.73** | No setup or monthly fee; R3 per payout, R3 per refund; refunds paid from a pre-funded float | Capitec Pay only, by approval | Medium: OAuth "One API", Svix-signed webhooks; no PHP SDK | Registered company, or "informal merchant" with bank account + website |
| **Yoco** (online) | 2.95% + R2 = R4.95 → **R5.69** (help-centre table; marketing page says 2.55 to 2.95%) | R31.50 → **R36.23** | No online EFT | None; standard payouts free, 1 to 2 business days | **None** | Low: REST Checkout API, Standard Webhooks | Sole traders (selfie ID, personal bank account) |
| **iKhokha** (online) | 2.85% = R2.85 → **R3.28** | R28.50 → **R32.78** | Instant EFT 2% = R2.00 → **R2.30** | R2.50 per daily payout | **None** | Medium: payment-link API, HMAC-signed; no PHP example; no refund endpoint in the guide | Not checked |

Arithmetic for the table:
- **Paystack:** R100 × 2.9% = R2.90 + R1 = R3.90, × 1.15 = R4.485. R1000 × 2.9% = R29 + R1 = R30, × 1.15 = R34.50. EFT R100 × 2% = R2.00, × 1.15 = R2.30. At R1000, EFT is R20 → R23.00.
- **PayFast:** R100 × 3.2% = R3.20 + R2 = R5.20, × 1.15 = R5.98. R1000 × 3.2% = R32 + R2 = R34, × 1.15 = R39.10. EFT R1000 is R20 → R23.00. Each payout costs R8.70 → R10.01 incl VAT.
- **Peach:** R100 × 2.95% = R2.95 + R1.50 = R4.45, × 1.15 = R5.12. R1000 × 2.95% = R29.50 + R1.50 = R31, × 1.15 = R35.65. Pay by Bank R1000 is R15 + R1.50 = R16.50 → R18.98.
- **Ozow:** R1000 Capitec Pay is R15.00.

Small-ticket view (R50 monthly):
- Paystack card: R1.45 + R1 = R2.45 → R2.82 (5.6%).
- PayFast card: R1.60 + R2 = R3.60 → R4.14 (8.3%).
- Peach card: R1.475 + R1.50 = R2.975 → R3.42 (6.8%).
- The flat part of the fee dominates small payments, which favours Paystack and EFT methods.

## Comparison: international

Example: a US$10 sale paid with a non-US card. The rand figures assume R18 = US$1, which is UNVERIFIED and used only for scale.

| Route | Type | Fee on US$10 | Tax handling | Payout to SA | Subscriptions | Notes |
|---|---|---|---|---|---|---|
| **Paystack international cards** | Processor (we are the seller) | 3.1% + R1 on R180 = R6.58 → R7.57 incl VAT ≈ US$0.42 | None: we own any foreign VAT duty | ZAR to SA bank, free, T+2 | As for SA (authorizations / plans) | Priced in ZAR; buyer's bank converts |
| **Peach international cards** | Processor | 3.50% + R1.50 on R180 = R7.80 → R8.97 incl VAT ≈ US$0.50 | None | ZAR daily | R200/month tokenisation | |
| **PayPal (ZA account)** | Processor | 4.40% + US$0.30 = US$0.74 | None | Withdraw via FNB; PayPal conversion 3.0% above base rate if converted in PayPal | PayPal Subscriptions API (SA availability UNVERIFIED) | Extra account and checkout |
| **Paddle** | Merchant of record | 5% + 50c = US$1.00 | Paddle collects and remits sales tax/VAT | Monthly, min US$100; wire (US$15 SWIFT fee when currency/bank country differ) or Payoneer | Full: dunning, customer portal | Software-focused; course content must be our own |
| **Polar** | Merchant of record | 5% + 50c + 1.5% non-US card = US$1.15 | Polar handles | SA listed for payouts (Stripe Connect Express); US$2/month + 0.25% + US$0.25 per payout + 0.25 to 1% FX | Yes | Courses explicitly allowed |
| **Lemon Squeezy** | Merchant of record | 5% + 50c + 1.5% intl + 0.5% subscription = US$1.20 | LS handles | SA bank payouts listed; 1% per non-US bank payout | Yes | Moving to Stripe Managed Payments, which excludes SA: avoid |
| **Stripe / Stripe Managed Payments** | — | — | — | **Not available to SA businesses** | — | Only through a foreign entity such as a Stripe Atlas US company (US$500) |
| **FastSpring** | Merchant of record | Quote only | FastSpring handles | UNVERIFIED | Yes | Not worth it at this size |

Arithmetic for the international table:
- **Paystack:** R180 × 3.1% = R5.58 + R1 = R6.58, × 1.15 = R7.57.
- **Peach:** R180 × 3.5% = R6.30 + R1.50 = R7.80, × 1.15 = R8.97.
- **PayPal:** US$10 × 4.4% = 0.44 + 0.30 = 0.74.
- **Paddle:** 0.50 + 0.50 = 1.00.
- **Polar:** 0.50 + 0.50 + 0.15 = 1.15.
- **Lemon Squeezy:** 0.50 + 0.50 + 0.15 + 0.05 = 1.20.

---

## SA gateways in detail

### Paystack (South Africa)

**Fees.** From https://paystack.com/za/pricing (read in a browser, because the page blocks automated fetches):
- Local transactions: "2.9% + ZAR 1 excluding VAT". The "ZAR 1 fee [is] waived for transactions less than ZAR 10".
- "Capitec Pay and Ozow EFT transactions are charged at 2% with no flat fee".
- "No upfront or monthly fees". "All payouts are free".
- International transactions: "3.1% + ZAR 1 excluding VAT". These are "charged and settled in Rand by default".
- Transfers to bank accounts (sending money out): ZAR 3 each. Not needed here.
- Settlement: "It takes 2 working days after a customer pays for you to receive your payout."
- Discrepancy: the help article https://support.paystack.com/en/articles/2130690 states international ZAR payments at "2.9% + R1.00". The pricing page (3.1%) is used here; confirm with Paystack. The same article says international payments must be selected at business creation, or requested later under Preferences.

**Who can sign up.** From https://support.paystack.com/en/articles/2128898:
- There are "Starter Business" and "Registered Business" accounts. For SA there is a "Sole Proprietorship" version of Starter.
- That page gives the SA collection limit as **ZAR 1,000,000**, the same for Starter and Sole Proprietorship. On reaching it, "payments for your business will be temporarily disabled" until you upgrade.
- Conflict: https://support.paystack.com/en/articles/2125314 gives SA Starter **ZAR 80,000** and Sole Proprietorship ZAR 1,000,000 (agent reading). So sign up as **Sole Proprietorship**, not plain Starter.
- Starter accounts cannot use Transfers.
- Registered businesses (CIPC certificate + corporate bank letter) have no limit.
- Sole proprietor documents: personal or business bank account, bank letter under 6 months old, ID, proof of address under 6 months old; all names must match (https://support.paystack.com/en/articles/2124418).

**Currency.** SA businesses accept and settle in ZAR only. USD pricing is for Kenya and Nigeria businesses (https://support.paystack.com/en/articles/2130690). International buyers see a ZAR price.

**Subscriptions (gateway-owned).** From https://paystack.com/docs/payments/subscriptions/:
- Plan intervals are "hourly, daily, weekly, monthly, quarterly, biannually (every 6 months) and annually". `invoice_limit` caps the number of charges.
- Monthly plans created on the 29th to 31st bill on the 28th.
- Card and Direct Debit (Nigeria) only. So in SA, card only: Capitec Pay or EFT cannot be used for renewals.
- "**Subscriptions aren't retried** — If a subscription charge fails, we don't retry it." The status moves to `attention`, and Paystack tries again only "on the next payment date".
- Events:
  - `subscription.create`
  - `invoice.create`, sent 3 days before the charge
  - `charge.success` or `invoice.payment_failed`
  - `invoice.update`
  - `subscription.not_renew`
  - `subscription.disable`
  - `subscription.expiring_cards`, sent monthly
- There is a hosted "manage subscription" link for card update or cancel: `GET /subscription/:code/manage/link`.

**Charging a saved card on our own schedule.** From https://paystack.com/docs/payments/recurring-charges/:
- After the first successful 3-D Secure payment, store the `authorization` object and the email used.
- Check `reusable: true` before reusing an authorization.
- Charge later with the Charge Authorization API.
- Paystack says this directly: "If your app needs to charge the authorizations at certain intervals, it means your server needs to have a cron job". This is the pattern recommended below.
- The minimum first charge to tokenise is ZAR 1.00.
- The authorization works for cards in all markets (direct debit is Nigeria only).
- Only the original email can be used to charge an authorization, so store it beside the code.

**Webhooks.** From https://paystack.com/docs/payments/webhooks/:
- The `x-paystack-signature` header is "a HMAC SHA512 signature of the event payload signed using your secret key".
- Webhooks also come only from 52.31.139.75, 52.49.173.169 and 52.214.14.220.
- Return 200 quickly. Unacknowledged events are resent "for the next 72 hours" (every 3 minutes for the first 4 tries, then hourly; request timeout 30 s).
- Retries mean duplicates are possible, so handlers must be idempotent.

**Other points:**
- PHP: plain cURL to `api.paystack.co`, and the docs show PHP snippets. No official PHP SDK confirmed, and none is needed.
- Test mode: test keys and test cards (https://paystack.com/docs/payments/test-payments/).
- Refunds: Refunds API, full or partial (https://paystack.com/docs/payments/refunds/).
- No "termly" plan interval exists. Another reason to run the schedule ourselves.
- Status page: https://status.paystack.com/ has a South Africa transactions group. It showed 99.95% uptime over 90 days when checked.
- Owner: "Paystack is a Stripe company" (footer of https://paystack.com/za/pricing). The SA entity is Paystack South Africa (Pty) Ltd, which its terms say is licensed by PASA (https://paystack.com/za/terms, agent reading).
- PCI DSS: Level 1 is claimed on https://paystack.com/security, but the page blocked direct fetch (UNVERIFIED).

### PayFast (by Network)

**Fees.** From https://payfast.io/fees/; "All fees exclude VAT":
- Credit and cheque card, Apple/Google/Samsung Pay: 3.2% + R2.00.
- Instant EFT: 2.0% (min R2.00). Capitec Pay: 2.0% (min R2.00).
- SnapScan / Scan to Pay: 3.5% + R2.00. Zapper: 4.5% + R5.00. Mobicred: 3.2%. Payflex: 5.45% + R5.00. MoreTyme: 5.5% + R2.00.
- Payout: R8.70 per withdrawal. Immediate payout: 0.8% (min R14). Refund: R2.00.
- No monthly or setup fee is listed. Lower rates are available above about R50,000 a month.

**Recurring billing.** From https://developers.payfast.co.za/docs (a JavaScript page, read in a browser):
- **Subscription** (`subscription_type=1`): PayFast charges on a fixed `frequency` (1 daily, 2 weekly, 3 monthly, 4 quarterly, 5 biannually, 6 annual) for `cycles` payments (0 = indefinite). A `billing_date` can be set.
  - A "passphrase is REQUIRED" in the signature.
  - `recurring_amount` has a "minimum value of 5.00".
  - PayFast can email the buyer 7 days before a trial ends or the amount increases.
- **Tokenization** (`subscription_type=2`): "A recurring charge where the future dates and amounts of payments may be unknown. Payfast will only charge the customer's card when instructed to do so via the API."
  - Setup can be R0.00: the card is 3-D Secured and nothing is charged.
  - This is the "we own the schedule" option.
- Card update: a hosted link `https://www.payfast.co.za/eng/recurring/update/{token}`.
- Pause and cancel: available via the dashboard and the API.

**ITN (webhook).** From the same docs page, "Conduct four security checks":
1. **Signature:** MD5 of the posted fields plus `&passphrase=`.
2. **Source host:** the request must come from www.payfast.co.za, w1w.payfast.co.za, w2w.payfast.co.za or sandbox.payfast.co.za, resolved to IPs.
3. **Amount:** `amount_gross` must match the expected amount within 0.01.
4. **Server confirmation:** post back to `https://www.payfast.co.za/eng/query/validate`.

**Subscription API** (https://developers.payfast.co.za/api#recurring-billing, agent reading):
- Base URL `api.payfast.co.za`, with `?testing=true` for the sandbox. Every call needs merchant-id, version, timestamp and an MD5 signature in its headers.
- Endpoints: `GET /subscriptions/:token/fetch`, `PUT …/pause`, `…/unpause`, `…/cancel`, `PATCH …/update`, and `POST …/adhoc` (charges a tokenization agreement now).
- There is also a refunds API: query first; a partial refund may go out as a `BANK_PAYOUT`.
- Both recurring kinds are credit card only, with a minimum of R5.00.
- When a subscription payment fails, PayFast retries "a number of times", then the subscription is "locked" until we act.
- Notify URLs must be on port 80, 8080, 8081 or 443.

**Other points:**
- Sandbox: `https://sandbox.payfast.co.za` ("an exact code duplicate of the production site", ITNs included).
- PHP SDK: https://github.com/Payfast/payfast-php-sdk (`composer require payfast/payfast-php-sdk`, PHP 8.1 or later). It covers the hosted form, onsite payments, the subscription API and card updates. The repo was last pushed 28 Feb 2024.
- **Ownership:** Network International bought PayFast in 2021, merged it with Paygate in 2022 to 2023, and rebranded it under Network in 2024 (https://payfast.io/about-us/). The footer says "PCI-DSS Level 1 Service Provider" (https://payfast.io/fees/).
- **Status page:** https://status.payfast.io/
- **Sign-up:** Company, Sole Trader or Non-Profit, with FICA documents (ID, address, bank account) (https://payfast.io/faq/). An SA bank account is required.
- **Payouts:** R8.70 per payout, by hand or scheduled. Funds are available after a 48-hour holding period (https://payfast.io/faq/).
- **International cards:** no separate rate is published. The fees FAQ says Visa and Mastercard credit cards are accepted "from anywhere in the world", which implies the standard 3.2% + R2.
- The integration is heavier than Paystack's, but well trodden in SA.

### Peach Payments

From https://www.peachpayments.com/fees/, Growth plan, "all prices ex VAT":
- **Card fees:**
  - Local cards with 3-D Secure: 2.95% + R1.50.
  - International cards: 3.50% + R1.50.
  - Local non-3-D Secure / recurring: 3.50% + R1.50.
- **Bank and wallet methods:**
  - Pay by Bank (all banks except Capitec): 1.50% + R1.50.
  - Capitec Pay: 1.50% + R1.50.
  - Apple/Google/Samsung Pay and Scan to Pay: 2.95% + R1.50.
- **Monthly and setup:**
  - "No Setup Fee". Growth plan account fee: N/A.
  - Tokenisation fee: R200 a month (unlimited cards).
  - Enterprise plan: R300 a month account fee, rates negotiated.
- **Settlement:** daily, next business day, "Free & Automated". Daily settlement starts "After 2 weeks of trading".
- **Features listed:** "Recurring / Subscription Billing", Refunds, Checkout API, Server to Server API, payment links, international cards. "Customers transact in their currency settled to you in Rands."
- **Sign-up:** "We accept applications from sole proprietors as well as registered businesses."
- **Compliance:** "PCI DSS Level 1 Certified" (site footer).

**Integration** (developer docs, agent reading):
- Tokenise in Checkout with `createRegistration=true`, then charge with the Recurring API. The merchant controls the schedule (https://developer.peachpayments.com/docs/checkout-tokenisation, https://developer.peachpayments.com/docs/oppwa-guides-card-on-file). No hosted plan engine found.
- Webhooks: Checkout uses optional HMAC-SHA256 (`x-webhook-signature`, `x-webhook-timestamp`) (https://developer.peachpayments.com/docs/checkout-webhooks). The server-to-server Payments API instead sends an AES-256-GCM encrypted body that must be decrypted (https://developer.peachpayments.com/docs/oppwa-guides-webhooks).
- Refunds: `POST /v1/checkout/refund`; sandbox at testapi.peachpayments.com (https://developer.peachpayments.com/docs/checkout-refund).
- Status page: https://status.peachpayments.com/. Founded 2012 in Cape Town (https://www.peachpayments.com/about/).

Verdict: competitive for once-off payments and the cheapest bank-payment rate after Ozow. But auto-renew costs R200/month plus a higher 3.5% recurring rate, so at a small subscriber count Paystack is cheaper.

### Stitch

- Express plan, ex VAT (https://pricing.stitch.money/): local cards 2.95%, international 3.4%, Capitec Pay 2%; payouts R2 (R10 instant); custom pricing over R200k/month.
- GraphQL API covering Pay by Bank, Capitec Pay, card, DebiCheck and manual EFT (https://docs.stitch.money/).
- Card-on-file for a custom PHP site on Express: not found.
- Enterprise-first, and GraphQL is more work than Paystack's REST. No reason to choose it here.

### PayGate / DPO (by Network)

- Now branded "DPO Paygate by Network": PayWeb (hosted), PayHost (server-to-server), PaySubs (recurring), sandbox (https://docs.paygate.co.za/paygate-by-network/docs/getting-started).
- paygate.co.za/pricing now redirects to PayFast's gateway page (https://payfast.io/solutions/gateway/). No PayGate rates are published. In practice Network steers small merchants to PayFast. Skip.

### Ozow

From https://ozow.com/pricing:
- "No setup fees."
- Cards: local 2.85% (min R1.00) up to R249,999.99 a month; international 3.5% (min R1.00).
- Bank methods at 1.5% (min R1.00): Capitec Pay, Nedbank Direct EFT, Absa Pay, Pay by Bank, PayShap Request.
- Instant payouts: R3.00 each. Real-time refunds: R3.00 each.
- The page does not say whether the figures include VAT.

- The FAQ confirms no monthly, activation or deactivation fee (https://ozow.com/faqs).
- **Settlement:** Ozow bills its fees separately. Refunds and payouts come from a float that must be topped up first (https://hub.ozow.com/payment-methods/settlements-and-float/settlements).
- **Recurring:** "Limited availability, and by approval only". Capitec Pay is the only method: the customer sets limits with their bank, and we trigger collections within them (https://hub.ozow.com/payment-methods/recurring-payments).
- **API:** new merchants use the OAuth "One API", which covers refunds and subscriptions. Webhooks are signed with Svix headers. The old SHA512 `hashCheck` API is deprecated (https://hub.ozow.com/llms-full.txt).
  - Staging moves real money unless you use "Ozow Demo Bank".
  - There is no PHP SDK.
- **Licensing:** Ozow says it is licensed by PASA as a System Operator and Third-Party Payment Provider, and is PCI Level 1 (https://ozow.com/faqs).
- **Sign-up:** a registered company, or an "informal merchant" with a bank account and a working website (same page).
- **Status page:** https://status.ozow.com/

Ozow is the cheapest for bank payments. But there is no card-on-file, recurring is Capitec-only and by approval, and the float makes refunds more work. It is worth adding later only as a cheap once-off EFT option.

### Yoco

From https://www.yoco.com/za/online-payments/:
- The fee is "2.55 - 2.95% Transaction fee (ex-VAT)", a "Flat fee per successful online payment", with custom rates above R200,000 a month.
- Cards, Apple Pay and Google Pay are supported.
- The page does not separate local and international card fees, and lists no instant EFT.
- Yoco is mainly a card-machine business. The fees page https://www.yoco.com/za/fees/ covers in-person plans only.
- **Conflict:** the Core Plan help article (https://support.yoco.help/en/articles/109451-core-fee-pricing-faqs) gives different rates, all ex VAT:
  - Online local cards: **2.95% + R2** up to R50k a month, then 2.75% + R2.
  - International and Amex: 3.50% + R2.
  - The table above uses the help article.
- **Payouts:** standard payouts are free, 1 to 2 business days, with a minimum balance of R10 (https://support.yoco.help/en/articles/109595-yoco-payouts-guidelines-schedule-reports).
- **API:** REST Checkout API, ZAR only, with refunds by API (https://developer.yoco.com/docs/checkout-api, https://developer.yoco.com/guides/online-payments/refunding-a-payment).
  - Webhooks use Standard Webhooks (HMAC-SHA256, `whsec_` secret) (https://developer.yoco.com/docs/api/webhooks/verifying-events).
  - Payments under R2 are rejected.
- **No recurring billing or tokenization** appears anywhere in the developer docs (https://developer.yoco.com/llms-full.txt). Once-off payments only.
- **Sign-up:** sole traders are accepted (https://support.yoco.help/en/articles/109586-how-to-sign-up-with-yoco).
- **Status page:** https://status.yoco.com/

### iKhokha

- **Fees** (https://www.ikhokha.com/pricing), ex VAT: online local cards 2.85%; Instant EFT 2%; international cards 3.25%; R2.50 per daily payout.
- **API** (https://developer.ikhokha.com): creates payment links. Requests are signed with HMAC-SHA256 (`IK-SIGN`).
  - The API guide has no refund endpoint and no recurring billing or tokenization.
  - The official examples cover C#, Dart, Go and Node, not PHP (https://github.com/ikhokha/ik-pay-api-examples).
- **Verdict:** cheap once-off payments, but no recurring payments and no API refunds. Skip.

### SnapScan / Zapper

- Both are scan-to-pay wallets. SnapScan's API (https://developer.getsnapscan.com/) covers QR payments, with no card checkout or subscriptions.
- Use them only as payment methods inside PayFast (3.5% + R2 and 4.5% + R5).

---

## International in detail

**Stripe:**
- Not available to SA businesses. https://stripe.com/global lists South Africa as "Extended network", linking to Paystack.
- Stripe Managed Payments (Stripe's merchant of record) lists supported business locations in North America, Europe and Asia-Pacific only; ZA is absent. https://docs.stripe.com/payments/managed-payments/eligibility
  - "Online courses and training" are eligible products there, which matters only if BestLessons ever has a non-SA entity.

**Paddle** (merchant of record):
- Fee "5% + 50¢ per Checkout transaction", with "bespoke pricing" for items under $10. https://www.paddle.com/pricing
- **Eligibility:**
  - Paddle "works with software businesses anywhere in the world" except listed countries; SA is not on that list. https://www.paddle.com/help/start/intro-to-paddle/which-countries-are-supported-by-paddle
  - It prohibits "certifications or courses for which the business is not the owner or creator" and human services not tied to software. https://www.paddle.com/help/start/intro-to-paddle/what-am-i-not-allowed-to-sell-on-paddle
  - Our own course platform content should qualify, but expect a review.
- **Payouts:**
  - Monthly. The balance converts on the 1st and is paid "by the 15th", with a minimum US$100, by wire or Payoneer. https://www.paddle.com/help/manage/get-paid/when-and-how-do-i-get-paid
  - Wire to a bank whose country does not match the payout currency costs US$15 (SWIFT). The conversion margin is "up to 1.5%". https://www.paddle.com/help/manage/get-paid/is-there-a-fee-taken-for-payouts
  - https://www.paddle.com/help/manage/get-paid/can-i-be-paid-in-my-local-currency lists ZAR among balance currencies, but the payout-fee page lists free local transfers only for USD, EUR, GBP, CAD and AUD. Whether a ZAR payout to an SA bank is free is UNVERIFIED; ask Paddle.
- **Webhooks:** `Paddle-Signature: ts=…;h1=…`, HMAC-SHA256 over `ts:rawBody`. https://developer.paddle.com/webhooks/signature-verification
- **Dunning:** failed payments are retried over a recovery window. Per the agent's reading of https://developer.paddle.com/build/retain/configure-payment-recovery-dunning, that is 7 attempts over 30 days (UNVERIFIED by me directly).

**Lemon Squeezy** (merchant of record):
- **Fees:** 5% + 50¢; "+1.5% for international (outside of the US) transactions"; "+1.5% for PayPal"; "+0.5% for subscription payments". https://docs.lemonsqueezy.com/help/getting-started/fees
- **Payouts:** 1% per payout to non-US banks, or 3% (capped US$30) via PayPal (same page). SA is on the bank-payout list. https://docs.lemonsqueezy.com/help/getting-started/supported-countries
- **Status:**
  - Owned by Stripe. A January 2026 post says sellers will need to migrate to Stripe Managed Payments. https://www.lemonsqueezy.com/blog/2026-update ("Our goal is to provide Lemon Squeezy users an easy way to migrate to Stripe Managed Payments"; no shutdown date given).
  - Managed Payments excludes SA, so this route has no clear future for us.

**Polar** (merchant of record):
- **Fees:** Starter plan 5% + 50¢; paid plans down to 3.4% + 30¢ at US$400/month; "International card payments incur an extra 1.5%".
- **Payouts:** "$2 per month of active payout(s)" plus "0.25% + $0.25 per payout", and 0.25 to 1% currency conversion. Disputes cost US$15. https://polar.sh/resources/pricing
- SA is listed: Polar "uses Stripe Connect Express to issue payouts to residents or businesses in any of the countries below … 🇿🇦 South Africa". https://polar.sh/docs/merchant-of-record/supported-countries
- Courses are allowed per https://polar.sh/docs/merchant-of-record/acceptable-use (agent reading).

**PayPal** (processor, SA account):
- From https://www.paypal.com/za/business/paypal-business-fees (read in a browser), ZA falls under "All other markets":
  - Receiving international commercial transactions: 4.40% + fixed fee. Domestic: 3.40% + fixed fee.
  - The USD fixed fee is 0.30 USD.
  - Converting a balance costs 3.0% above the base rate (Middle East & Africa).
- Withdrawals to SA run through FNB Online Banking (https://www.paypal.com/za/cshelp/article/how-do-i-withdraw-money-to-my-first-national-bank-fnb-account-help1130, agent reading). FNB's own fee is UNVERIFIED.

**FastSpring:** pricing is quote-only (https://fastspring.com/pricing/). Not suited to this size.

**Tax note for international sales.** A processor route (Paystack, Peach, PayPal) makes BestLessons the seller. Some countries (EU, UK and others) require non-resident sellers of electronic services to consumers to register for their VAT/GST. A merchant of record removes that duty. At low volume many sellers accept the risk or limit international B2C sales. **This needs a tax adviser's view (UNVERIFIED; foreign tax rules not researched here).**

---

## Subscription monitoring and enforcement

### The three patterns

| Pattern | How | Fits our system? |
|---|---|---|
| (a) Gateway owns the schedule | Paystack Plans, PayFast Subscriptions, Paddle/LS/Polar subscriptions. We mirror state from webhooks | Two sources of truth. Plan changes and refunds must be done in two places. Paystack does not retry failed charges. Use only for a merchant-of-record route, where it is unavoidable |
| (b) We own the schedule with tokenised cards | Store the Paystack `authorization_code` (or PayFast token). Our cron charges when `endsAt` is near and retries on failure | **Recommended for opt-in auto-renew.** One source of truth (`subscriptions`). We set the retry and grace rules. The cron is needed anyway for reminders |
| (c) Pay per period, no auto-renew | Reminder emails with a pay link. Access ends at `endsAt` (+ grace) | **Recommended default.** Simplest. No stored tokens. Avoids most CPA s14 auto-renewal issues. Works with EFT and Capitec Pay |

### Billing layers that could sit on top

| Tool | Cost | SA gateway support | Hosting | Verdict |
|---|---|---|---|---|
| Chargebee | Free up to about US$66K/month billing on its Flow plan, then 0.8% (https://www.chargebee.com/pricing/) | Paystack (ZAR, cards, 3-D Secure mandatory) per https://www.chargebee.com/docs/payments/2.0/payment-gateways-and-configuration/paystack. No PayFast, Peach, Ozow or Yoco | SaaS | Workable later, but it would replace our own `subscriptions` logic. Not needed now |
| Recurly | US$249/month + 0.9% (https://recurly.com/pricing/) | No SA gateway found | SaaS | Too expensive |
| Lago | Open source, AGPLv3 (https://github.com/getlago/lago) | Stripe, Adyen, GoCardless (+ custom). No SA gateway (https://getlago.com/docs/integrations/introduction) | Docker, Postgres, Redis (https://getlago.com/docs/guide/self-hosted/docker) | Far heavier than PHP + SQLite |
| Kill Bill | Open source, Apache 2.0, Java | Plugins; no SA plugin found | JVM + MySQL/Postgres (https://docs.killbill.io/latest/userguide_deployment.html) | Too heavy |
| Stripe Billing | 0.7% of billing volume (https://stripe.com/billing/pricing) | Needs a Stripe account, which SA cannot have | SaaS | Not available |
| RevenueCat | Free to US$2,500/month tracked revenue, then 1% (https://www.revenuecat.com/pricing/) | App stores, Stripe, Paddle; no SA gateways | SaaS | Only relevant for mobile apps |

Conclusion: no billing layer earns its place. About 300 lines of PHP around Paystack does the job, and keeps `Entitlements()` the only gate.

### Concrete design for PHP + SQLite

**1. Never grant access from the browser return URL.** The return page only shows "checking payment…". Access changes come from:
- a verified webhook, or
- our own server-side "verify transaction" call (Paystack `GET /transaction/verify/:reference`, or PayFast's validate step).

**2. Payment reference first.** Before redirecting to the gateway:
- Insert a `payments` row with status `pending`, the expected amount, currency, plan, and a unique reference we generate (e.g. `BL-2026-000123`).
- The gateway echoes the reference back, which ties every event to one row.

**3. Webhook idempotency.**
- Add one small table: `gatewayEvents(gateway, eventKey UNIQUE, type, reference, receivedAt, processedAt, outcome, rawHash)`. The event key is Paystack's event type plus the transaction id or reference, or PayFast's `pf_payment_id`.
- The handler steps, in order:
  1. Verify the signature (Paystack HMAC-SHA512 of the raw body with the secret key; PayFast's four checks).
  2. `INSERT OR IGNORE` into `gatewayEvents`. If it was already there, return 200 and stop.
  3. Return 200 quickly. Paystack's timeout is 30 s.
  4. In one SQLite transaction: re-verify with the API, compare amount and currency to the `payments` row, mark it `paid`, extend `subscriptions.endsAt` from the later of now or the current `endsAt`, issue the invoice number, write the audit log, and set `processedAt`.
- SQLite in WAL mode with `BEGIN IMMEDIATE` is enough at this volume.

**4. Reconciliation cron.** Run it daily, and every 15 minutes for pending payments, using `crontab` → `php cli/billing-cron.php`. It:
- Verifies any `pending` payments older than 15 minutes against the gateway API. This catches lost webhooks.
- Pulls the gateway's transaction list for the last 3 days and flags any successful gateway transaction with no matching `paid` row, or the reverse.
- For opt-in auto-renew subscriptions due within 1 day: charges the saved authorization once, with a per-period idempotency reference such as `BL-renew-<subscriptionId>-<periodEnd>`, so a re-run cannot double-charge.
- Moves states:
  - `active` → `past due` when the renewal charge fails or `endsAt` passes unpaid.
  - `past due` → `expired` after the grace period.
  - `trial` → `expired` at the trial end.
- Sends the reminders: the CPA s14 notice for annual plans (see Legal), the 30-day and 7-day reminders already planned, and the "payment failed, update card" message.
- Writes one summary line per run to the audit log. It emails the admin on any mismatch.

**5. Dunning (our own), auto-renew only.**
- Retry on day 0, day 3 and day 6 after a failure.
- Use a 7-day grace period: `past due` still passes `Entitlements()` until `endsAt + 7 days`, with a banner.
- After that the status becomes `expired`. Card update uses a fresh R1+ 3-D Secure checkout, which creates a new authorization.

**6. Enforcement stays in `Entitlements()`.**
- It reads only `subscriptions`: status in (trial, active, past due) AND now < `endsAt` (+ grace if `past due`).
- No other code reads payments or gateway state.
- Cancelling sets `autoRenew = 0` and leaves `endsAt` alone, so access runs to the end of the paid period.

**7. Audit log.**
- Use an append-only `billingLog(at, actor [admin id | 'webhook' | 'cron'], subscriptionId, paymentId, action, before, after, note)`.
- Write it for:
  - manual grants
  - EFT marked paid
  - every webhook-driven change
  - refunds
  - state changes made by the cron
- Never update or delete its rows.

**8. Refunds.** Use the gateway's refund API (Paystack Refund API; PayFast refunds at R2 each). Record `refundedAt`. Decide per case whether to shorten `endsAt`; for a full refund, set the status to `cancelled`.

---

## SA legal points

Statute texts are the gov.za PDFs, read 3 Oct 2026. These notes are not legal advice.

**ECT Act 25 of 2002, Chapter VII** (https://www.gov.za/sites/default/files/gcis_document/201409/a25-02.pdf)
- **Who it covers:** "consumer" is a natural person entering an electronic transaction "as the end user" (s1). Schools buying as juristic persons are not covered.
- **s43(1), information the site must show:**
  - Full name, legal status, physical address, phone and email.
  - Description of the service and the full price including taxes.
  - Manner of payment, and the terms and how to access them.
  - Refund policy, security procedures and privacy policy.
  - For recurring supply, "(q) the minimum duration of the agreement".
  - "(r)" the consumer's s44 cooling-off rights.
- **s43(2):** the buyer must be able to review the whole order, correct it, and withdraw before placing it.
- **s43(3)-(4):** if s43 is breached, the buyer may cancel within 14 days.
- **s43(5):** a "sufficiently secure" payment system is required. A hosted gateway checkout meets this.
- **s44:** the buyer may cancel services "without reason and without penalty" within 7 days of the agreement, with a full refund within 30 days.
- **s42(2)(d):** s44 does not apply to "services which began with the consumer's consent before the end of the seven-day period". A checkout tick box ("Start my access now; I understand this ends my 7-day cooling-off right") removes it. Offering a voluntary 7-day refund anyway is simpler and kinder.
- **s46:** perform within 30 days unless agreed otherwise.
- **s48:** any term excluding these rights is void.

**Consumer Protection Act 68 of 2008** (https://www.gov.za/sites/default/files/gcis_document/201409/321864670.pdf)
- **s14, fixed-term agreements.** This applies to our termly and annual consumer plans.
  - s14(1): it does not apply between juristic persons. School licences are therefore outside it, but a school buying from a sole proprietor may not count as "between juristic persons"; check with a lawyer.
  - The consumer may cancel at expiry, or "at any other time" on "20 business days' notice". The supplier "may impose a reasonable cancellation penalty" (s14(2)(b), (3)).
  - The supplier must notify the consumer of the coming expiry and any changes "not more than 80, nor less than 40, business days" before it (s14(2)(c)).
  - After expiry the agreement continues "month-to-month" unless the consumer directs otherwise (s14(2)(d)).
  - Regulation 5 (https://thencc.org.za/wp-content/uploads/2020/11/CPA-REGS.pdf): maximum term of 24 months. Penalty factors are in reg 5(2). A penalty may not have "the effect of negating" the right to cancel.
  - **What this means for us:**
    - Annual consumer plans need an expiry notice sent about 3 months before `endsAt` (40 to 80 business days). The current 30-day and 7-day reminders do not satisfy this.
    - Early cancellation of an annual plan must be possible, with a pro-rata refund less a reasonable penalty.
    - Monthly plans that simply roll month to month are arguably not "fixed-term". Pay-per-period with no auto-renew sidesteps most of this.
- **Juristic customers:** the CPA does not protect juristic persons with assets or turnover at or above R2,000,000 (GN 294, 1 April 2011: https://www.gov.za/sites/default/files/gcis_document/201409/34181gon294.pdf).
- **s16:** the 5-business-day cooling-off after direct marketing does not apply where ECTA s44 applies.
- **s22:** notices must be in plain language.
- **s39:** an agreement with an unemancipated minor acting without a responsible adult's consent is "voidable at the option of the consumer". The parent must be the buyer: parent account, parent email, and the parent pays.

**POPIA 4 of 2013** (https://www.gov.za/sites/default/files/gcis_document/201409/3706726-11act4of2013popi.pdf)
- s34-35: processing a child's (under 18) personal information needs "prior consent of a competent person" (the parent).
- s19: "appropriate, reasonable technical and organisational measures".
- We never see card numbers, because hosted checkout and tokens stay with the gateway. We store only the gateway's token, card brand, last 4 digits and expiry, which are low-risk.
- PCI DSS is a card-scheme and acquirer contract duty, not statute (UNVERIFIED).
- Card-on-file data from Paystack's authorization object (bin, last4, bank) is personal information. Store only what is needed, and cover it in the privacy notice.

**DebiCheck:** applies to debit orders only. Debit orders are "electronically approved by the consumer with their bank" (https://pasa.org.za/pasa-resources/pasa-debit-orders/). It is not relevant to card, instant EFT or Capitec Pay.

**VAT** (https://www.sars.gov.za/types-of-tax/value-added-tax/, https://www.sars.gov.za/faq/what-is-the-new-threshold-for-vat-registration/):
- The compulsory registration threshold rose to **R2.3 million** and the voluntary threshold to R120,000, from 1 April 2026.
- The rate stays at 15%.
- Until registration, VAT on gateway fees is a cost and cannot be claimed back.

---

## Unverified / check with the provider

1. **Paystack:**
   - International card rate: pricing page 3.1% + R1 vs help article 2.9% + R1. Confirm.
   - Exact sole-proprietor documents.
   - Refund API fees.
   - PCI DSS level.
   - Whether Capitec Pay or EFT can ever be used for repeat charges (the docs say cards only).
2. **PayFast:** whether an unregistered individual (not a sole trader) can open an account; international card rate (none published); number and timing of failed-payment retries; maximum transaction amount; whether the PHP SDK (last pushed Feb 2024) is still maintained.
3. **Ozow:** whether fees include VAT; settlement days per method; owner.
4. **Yoco:** online fee conflict (2.55 to 2.95% vs 2.95% + R2); whether online EFT exists; PCI level.
5. **iKhokha:** sign-up rules; refunds outside the API guide; PCI level; status page.
6. **Peach:** whether tokenisation can be used without the R200 fee on small volume.
7. **Stitch:** card-on-file and sign-up rules. **PayGate/DPO:** fees (none published).
8. **Paddle:** whether a ZAR payout to an SA bank is free; whether Paddle accepts a course platform in practice.
9. **Polar:** how SA payouts work through Stripe Connect Express. Stripe's own cross-border payout list is narrower; confirm with Polar.
10. **Lemon Squeezy:** timing of the forced migration to Stripe Managed Payments.
11. **PayPal:** FNB withdrawal fees and spread; Subscriptions API availability for ZA accounts.
12. **Foreign VAT** on international B2C sales of e-services if not using a merchant of record: needs tax advice.
13. **The R18/US$ rate** used for scale only.
14. **Legal:**
    - Whether a sole-proprietor supplier selling to a school counts as "between juristic persons" for CPA s14(1).
    - How ECTA s42(2)(d) interacts with CPA s16.
    - That ECTA Chapter VII is unamended since 2002 (as-enacted text read).

---

## Sources (all checked 3 October 2026)

**SA gateways**
- https://paystack.com/za/pricing
- https://paystack.com/docs/payments/subscriptions/
- https://paystack.com/docs/payments/recurring-charges/
- https://paystack.com/docs/payments/webhooks/
- https://support.paystack.com/en/articles/2128898
- https://support.paystack.com/en/articles/2130690
- https://support.paystack.com/en/articles/2124418 (search summary only)
- https://support.paystack.com/en/articles/2125314 (agent)
- https://paystack.com/docs/payments/refunds/ (agent)
- https://status.paystack.com/ (agent)
- https://paystack.com/za/terms (agent)
- https://developer.peachpayments.com/docs/checkout-tokenisation, /checkout-webhooks, /oppwa-guides-webhooks, /checkout-refund (agent)
- https://pricing.stitch.money/ and https://docs.stitch.money/ (agent)
- https://docs.paygate.co.za/paygate-by-network/docs/getting-started (agent)
- https://payfast.io/fees/
- https://developers.payfast.co.za/docs
- https://www.peachpayments.com/fees/
- https://ozow.com/pricing
- https://www.yoco.com/za/online-payments/
- https://www.yoco.com/za/fees/
- https://payfast.io/about-us/, https://payfast.io/faq/, https://developers.payfast.co.za/api#recurring-billing, https://github.com/Payfast/payfast-php-sdk, https://status.payfast.io/ (agent)
- https://support.yoco.help/en/articles/109451-core-fee-pricing-faqs, https://support.yoco.help/en/articles/109595-yoco-payouts-guidelines-schedule-reports, https://support.yoco.help/en/articles/109586-how-to-sign-up-with-yoco, https://developer.yoco.com/docs/checkout-api, https://developer.yoco.com/docs/api/webhooks/verifying-events, https://developer.yoco.com/llms-full.txt (agent)
- https://ozow.com/faqs, https://hub.ozow.com/payment-methods/recurring-payments, https://hub.ozow.com/payment-methods/settlements-and-float/settlements, https://hub.ozow.com/llms-full.txt (agent)
- https://www.ikhokha.com/pricing, https://developer.ikhokha.com, https://github.com/ikhokha/ik-pay-api-examples (agent)
- https://developer.getsnapscan.com/ (agent)

**International**
- https://stripe.com/global
- https://docs.stripe.com/payments/managed-payments
- https://docs.stripe.com/payments/managed-payments/eligibility
- https://stripe.com/billing/pricing (agent)
- https://www.paddle.com/pricing
- https://www.paddle.com/help/start/intro-to-paddle/which-countries-are-supported-by-paddle
- https://www.paddle.com/help/start/intro-to-paddle/what-am-i-not-allowed-to-sell-on-paddle
- https://www.paddle.com/help/manage/get-paid/when-and-how-do-i-get-paid
- https://www.paddle.com/help/manage/get-paid/is-there-a-fee-taken-for-payouts
- https://www.paddle.com/help/manage/get-paid/can-i-be-paid-in-my-local-currency
- https://developer.paddle.com/webhooks/signature-verification
- https://www.lemonsqueezy.com/pricing
- https://docs.lemonsqueezy.com/help/getting-started/fees
- https://docs.lemonsqueezy.com/help/getting-started/supported-countries
- https://www.lemonsqueezy.com/blog/2026-update (agent)
- https://polar.sh/resources/pricing
- https://polar.sh/docs/merchant-of-record/supported-countries
- https://polar.sh/docs/merchant-of-record/acceptable-use (agent)
- https://www.paypal.com/za/business/paypal-business-fees
- https://www.paypal.com/za/cshelp/article/how-do-i-withdraw-money-to-my-first-national-bank-fnb-account-help1130 (agent)
- https://fastspring.com/pricing/ (agent)

**Billing layers** (agent, 3 Oct 2026)
- https://www.chargebee.com/pricing/
- https://www.chargebee.com/docs/payments/2.0/payment-gateways-and-configuration/paystack
- https://recurly.com/pricing/
- https://github.com/getlago/lago
- https://getlago.com/docs/integrations/introduction
- https://getlago.com/docs/guide/self-hosted/docker
- https://docs.killbill.io/latest/userguide_deployment.html
- https://www.revenuecat.com/pricing/

**Legal** (agent, 3 Oct 2026)
- https://www.gov.za/sites/default/files/gcis_document/201409/a25-02.pdf
- https://www.gov.za/sites/default/files/gcis_document/201409/321864670.pdf
- https://thencc.org.za/wp-content/uploads/2020/11/CPA-REGS.pdf
- https://www.gov.za/sites/default/files/gcis_document/201409/34181gon294.pdf
- https://www.gov.za/sites/default/files/gcis_document/201409/3706726-11act4of2013popi.pdf
- https://pasa.org.za/pasa-resources/pasa-debit-orders/
- https://www.sars.gov.za/types-of-tax/value-added-tax/
- https://www.sars.gov.za/faq/what-is-the-new-threshold-for-vat-registration/
