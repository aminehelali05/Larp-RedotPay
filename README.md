# Larp RedotPay Demo (Flutter)

Static frontend-only Android demo inspired by the RedotPay UI.
No backend, no real login, no payment or crypto functions.

## What is included (Step 1)

- Project structure with Flutter + Riverpod + SharedPreferences
- Main dashboard/home screen styled to match your screenshots
- Dark/light theme support (`ThemeMode.system` by default)
- Editable main balance (double-tap the big balance value)
- Fake user profile, fake transactions, fake assets, fake card/send/assets tabs
- Hidden admin mode in profile/settings to edit balances globally

## Hidden admin mode

1. Open `Home` tab
2. Tap profile avatar (top-left)
3. On `ami****@gmail.com`, long-press **7 times**
   - backup trigger: tap the invisible bottom-right corner of the profile screen 5 times
4. Admin panel opens
5. Change total balance + per-asset balances and tap `Apply`
6. Values are saved locally via `shared_preferences`

## Run

```bash
flutter pub get
flutter run
```

## Build APK without installing Flutter locally

If your connection is limited and you can't install Flutter SDK now, use GitHub Actions to build in the cloud.

1. Create a GitHub repo and push this project.
2. Open the repo on GitHub.
3. Go to `Actions` tab.
4. Run workflow: `Build Android APK` (or push to `main`/`master`).
5. When it finishes, open the run and download artifact `app-release-apk`.
6. Extract it and install `app-release.apk` on Android.

Workflow file already included:

- `.github/workflows/build-android-apk.yml`

Notes:

- This builds entirely on GitHub servers (no local Flutter SDK required).
- First run can take longer because dependencies are downloaded on the CI machine.

## Structure

- `lib/main.dart`: app bootstrap + ProviderScope
- `lib/app/app.dart`: MaterialApp + theme mode binding
- `lib/app/theme/app_theme.dart`: dark/light theme
- `lib/core/state/*`: app state and Riverpod controller
- `lib/core/storage/local_storage.dart`: local persistence
- `lib/features/home/home_screen.dart`: main dashboard UI
- `lib/features/profile/profile_settings_screen.dart`: profile/settings + hidden trigger
- `lib/features/admin/admin_panel_screen.dart`: secret admin editor
- `lib/features/navigation/shell_screen.dart`: bottom nav shell

## Next screenshot flow

Send the next screenshot and I will implement that screen pixel-by-pixel in the same architecture.
