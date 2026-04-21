# Multi-Page Registration Form

A little Flutter app that walks a user through a two-step sign-up, then proudly shows off everything they entered back on the home screen. Built as the Week 2 capstone — it ties together navigation, forms, validation, and `setState`.

## What it does

- **Home screen** welcomes you in and (after you register) shows your submitted info in a tidy card.
- **Page 1** collects the basics: name, email, phone, and a password you have to confirm.
- **Page 2** gathers a few more details: age, gender, country, and an optional bio.
- Hit **Submit** and the data hops all the way back to the home screen. 🎉

## Screens

1. **Home** — welcome + results view
2. **Registration Page 1** — personal info form
3. **Registration Page 2** — additional info form

## Validation rules

| Field | Rule |
|---|---|
| Name | Required, 3+ characters |
| Email | Required, valid email format |
| Phone | Required, 10+ digits |
| Password | Required, 6+ characters |
| Confirm Password | Must match password |
| Age | Required, 18 or older |
| Country | Required |
| Bio | Optional |

## Screenshots

A walkthrough of the full registration flow lives in the [`screenshots/`](screenshots/) directory as an animated GIF:

![Registration form walkthrough](screenshots/formregistrationcapture.gif)

The capture covers:

- Home screen (empty state)
- Registration Page 1
- Registration Page 2
- Home screen (with submitted data)

## Run it

```bash
flutter pub get
flutter run
```

That's it — pick a device and you're off.

## What I learned

Week 2 packed in a lot, and this project was where it all clicked:

- **Navigation as a stack** — `Navigator.push` to go forward, `Navigator.pop` with a value to return data. Double-popping from Page 2 to skip straight back to Home felt like a neat trick.
- **Forms** — `GlobalKey<FormState>` + `TextFormField` validators is a surprisingly tidy pattern once you get used to it.
- **Controllers have a lifecycle** — always `dispose()` them. Learned to treat that as muscle memory.
- **`setState` is simpler than I expected** — keep state local, lift it up only when you have to, never put `async` work inside the callback.
- **Null-check navigation results** — users hit back buttons, and the returned data will be `null`. Handle it gracefully.

## Challenges along the way

- Getting password confirmation right meant reaching into `_passwordController.text` from inside the confirm field's validator — a small "aha" moment about how controllers live alongside the form.
- Remembering to pop **twice** (once for Page 2, once for Page 1) to land back at Home with the data in hand.
- Matching `keyboardType` to each field so the phone field shows a number pad, email shows `@`, etc. — tiny detail, big UX win.

Good fun but not easy overall! 🚀
