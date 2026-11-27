# Releasing KannadaDisco

| | Android | iOS |
|---|---|---|
| App ID | `com.prajwalmreddy.kannada_disco` | `com.prajwalmreddy.kannadaDisco` |
| Store | Google Play (live since 2023) | App Store (not published yet) |
| Built on | this PC | Codemagic (cloud Mac) |

Store text, the privacy policy link and screenshots are in
[docs/store-listing.md](docs/store-listing.md) and [docs/screenshots](docs/screenshots).

## Every release

1. Bump `version:` in `pubspec.yaml`. The part after `+` is the build number.
   Both stores need it to go up with every upload, even for a test build.
   Git doesn't record past store uploads: before 1.4.0, Play's latest was
   version 1.3 with version code 4 (Oct 2023). Check Play Console → App
   bundle explorer if unsure.
2. Set `appVersion` in `lib/element/side_bar.dart` to the same version name.
3. Run `flutter analyze` and `flutter test`.
4. Commit and push. GitHub Actions runs the tests and an iOS build to check
   nothing is broken on either platform.

---

## Android

### One-time: the upload key

Play only accepts bundles signed with the app's **upload key**. Releases
from 2023 were signed with `upload-keystore.jks`, which was on another
computer (`/home/sanjukumar/upload-keystore.jks`).

**If you can get that file**, copy it to `C:\Users\prajw\keys\upload-keystore.jks`
(outside OneDrive and outside git) and make `android/key.properties` say:

```properties
storeFile=C:/Users/prajw/keys/upload-keystore.jks
storePassword=...
keyAlias=upload
keyPassword=...
```

**If it's lost**, Play can swap in a new upload key, since the app uses
Play App Signing:

1. Make a new key. `keytool` asks for a password and your name; keep the
   password in your password manager.
   ```powershell
   & "C:\Program Files\Android\Android Studio\jbr\bin\keytool.exe" -genkeypair -v -keystore "$env:USERPROFILE\keys\upload-keystore.jks" -keyalg RSA -keysize 2048 -validity 10000 -alias upload
   ```
2. Export its certificate:
   ```powershell
   & "C:\Program Files\Android\Android Studio\jbr\bin\keytool.exe" -export -rfc -keystore "$env:USERPROFILE\keys\upload-keystore.jks" -alias upload -file "$env:USERPROFILE\keys\upload_certificate.pem"
   ```
3. In Play Console: **KannadaDisco → Test and release → App integrity →
   App signing → Request upload key reset**, and upload `upload_certificate.pem`.
   Google usually approves it within a few days.
4. Fill in `android/key.properties` as above.

Back up the `.jks` file and its password somewhere safe. Losing them again
means another reset.

### Build and upload

```powershell
flutter build appbundle
```

The bundle is at `build/app/outputs/bundle/release/app-release.aab`. If the
upload key isn't set up, the build stops and says so.

In Play Console:

1. **Test and release → Testing → Internal testing → Create new release**.
   Upload the `.aab` and paste "What's new" from the store listing. Install
   it from the internal test link and try it on your phone.
2. When it looks right, **Promote release → Production**.
3. Check these before the first new release:
   - **Policy → App content → Privacy policy**: set the URL from
     `docs/store-listing.md`. It's required because the app is in the
     Families program.
   - **Data safety**: currently "No data collected". The rhyme videos are
     YouTube embeds; read Google's guidance on data collected by content in
     a WebView and decide whether the form needs changing.
   - **Target audience**: still includes children, so the Families Policy
     applies. The app has no ads or analytics, which keeps this simple.

---

## iOS

Apple only builds iOS apps on a Mac. This repo uses Codemagic's Macs, which
have a free monthly allowance, so you can do everything from Windows.

### One-time setup

1. **Apple Developer Program**: enrol at https://developer.apple.com/programs/enroll/
   as an individual ($99 a year).
2. **Bundle ID**: developer.apple.com → Certificates, Identifiers & Profiles →
   Identifiers → **+** → App IDs → App. Bundle ID (explicit):
   `com.prajwalmreddy.kannadaDisco`. No extra capabilities are needed;
   local notifications work without the Push Notifications capability.
3. **The app record**: App Store Connect → Apps → **+** → New App. Platform
   iOS, name KannadaDisco, primary language English (U.S.), the bundle ID
   above, SKU `kannadadisco`.
4. **API key for Codemagic**: App Store Connect → Users and Access →
   Integrations → App Store Connect API → **+**. Name it Codemagic, with
   access **App Manager**. Download the `.p8` file (you can only download it
   once) and note the Issuer ID and Key ID.
5. **Codemagic**: sign in at https://codemagic.io with GitHub and add the
   KannadaDisco repository.
   - Team settings → Integrations → Developer Portal → **Connect**. Name the
     key `KannadaDisco`, which must match `codemagic.yaml`, and enter the
     Issuer ID, Key ID and `.p8` file.
   - Team settings → Code signing identities → iOS certificates →
     **Generate certificate** (type Apple Distribution).
   - Code signing identities → iOS provisioning profiles → **Fetch profiles**.
     If none exists for the bundle ID, create an App Store profile on
     developer.apple.com first.

### Build and upload

In Codemagic, start the **iOS release to TestFlight** workflow on the branch
you want to ship. It runs the tests, builds a signed `.ipa` and uploads it
to TestFlight.

Then in App Store Connect:

1. **TestFlight**: add yourself as an internal tester and install the build
   on an iPhone with the TestFlight app. Check especially:
   - tapping a word speaks Kannada. iOS may not have a Kannada voice; if it's
     silent, that needs fixing before release.
   - the daily reminder notification arrives
   - the rhyme videos play
2. **App Store tab**: fill in the listing from `docs/store-listing.md`.
3. **Screenshots**: Apple needs at least one set for 6.9" iPhones
   (1320 × 2868 or 1290 × 2796). Take them on an iPhone with the TestFlight
   build; the Android screenshots show Android's status bar and would be
   rejected.
4. **App Privacy**: Data Not Collected. **Age rating**: 4+.
5. **Add for Review → Submit**. First reviews usually take a day or two.

When it's live, set `appStoreId` in `lib/element/side_bar.dart` to the app's
Apple ID (App Information → Apple ID) so Feedback appears on iOS.
