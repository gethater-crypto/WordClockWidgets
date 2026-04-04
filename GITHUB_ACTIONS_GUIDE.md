# GitHub Actions Automated Build & Release

## 🚀 Automated Build Pipeline

Your iOS project is now configured for **automatic compilation on GitHub** using macOS runners. Every time you push code, GitHub will automatically compile it!

## 📦 How It Works

### 1. **Automatic Build on Push**
When you push to `main` or `ios-port` branch:
1. GitHub Actions automatically starts
2. Builds project on macOS runner
3. Creates build artifacts
4. Stores artifacts for 30 days

### 2. **Getting the Built App**

#### From GitHub Actions:
1. Go to **GitHub.com** → Your repository → **Actions** tab
2. Find the latest "Build iOS App" workflow
3. Click on the workflow run
4. Scroll down to **Artifacts** section
5. Download **ios-build-artifacts.zip**

#### What You Get:
- Complete build output
- XCArchive file
- Build report
- Source code snapshot

### 3. **Using the Build on macOS**

After downloading artifacts:

```bash
# 1. Extract and navigate
unzip ios-build-artifacts.zip
cd ios

# 2. Open in Xcode
open WordClockWidgets.xcworkspace

# 3. Select device
# - iPhone XS Simulator OR
# - Connect physical iPhone XS

# 4. Build and Run
# - Press Cmd+B (build)
# - Press Cmd+R (run)
```

## 🏷️ Creating Releases

### Automatic Release from Web Interface:

1. **Go to GitHub.com** → Your repository
2. Click **Releases** (right sidebar)
3. Click **Create a new release**
4. **Tag version:** `v1.0.0` (or your version)
5. **Release title:** "WordClockWidgets iOS v1.0.0"
6. **Description:** Add release notes
7. **Attach files:**
   - Download artifacts.zip from latest Actions run
   - Attach it to release
8. Click **Publish release**

### Or Use Command Line:

```bash
# 1. Create tag
git tag v1.0.0

# 2. Push tag to GitHub
git push origin v1.0.0

# 3. GitHub automatically creates release
# (then manually attach artifacts if needed)
```

## 📊 Workflow Files

### `.github/workflows/build-ios.yml`
- **Triggers:** Push to main/ios-port, PR, manual trigger
- **Runner:** macOS (latest)
- **Actions:**
  - Checks out code
  - Verifies Xcode & Swift
  - Creates Xcode workspace
  - Builds for iOS Simulator (iPhone XS)
  - Builds for Device (iPhone XS)
  - Generates build report
  - Uploads artifacts (30-day retention)

### `.github/workflows/release.yml`
- **Triggers:** After successful build, manual dispatch
- **Actions:**
  - Downloads build artifacts
  - Creates release notes
  - Generates GitHub Release
  - Attaches documentation

## 🎯 Workflow Triggers

### Auto-Build Triggers:
```
✅ Push to main branch
✅ Push to ios-port branch
✅ Pull requests
✅ Manual dispatch (via Actions tab)
```

### Files that Trigger Build:
```
ios/**              (any iOS file change)
.github/workflows/  (workflow changes)
```

## 💾 Artifacts Retention

- **Free Plan:** 30 days
- **Pro Plan:** Same (configurable)

To keep artifacts for 90 days, change in `build-ios.yml`:
```yaml
retention-days: 90
```

## 🔐 Secrets & Authentication

No additional setup needed! The workflow uses:
- `GITHUB_TOKEN` (automatically provided)
- No Apple certificates required for build validation
- No signing keys needed for CI build

## 📱 Build Output Contents

When you download artifacts, you get:

```
ios/
├── build/
│   ├── BUILD_REPORT.md           # Build summary
│   ├── DerivedData/              # Xcode build products
│   └── export/                   # Export options
├── WordClockWidgets/
│   └── [Source files & build products]
└── WordClockWidgetsWidget/
    └── [Widget source & products]
```

## 🚀 Installation Workflow

### Development Flow:
```
1. Make code changes locally
   ↓
2. Push to GitHub (ios-port branch)
   ↓
3. GitHub Actions automatically builds
   ↓
4. Get build artifacts from Actions tab
   ↓
5. Download & test on Mac with Xcode
   ↓
6. Merge to main when ready
```

### Release Flow:
```
1. Create tag: git tag v1.0.0
   ↓
2. Push tag: git push origin v1.0.0
   ↓
3. GitHub creates Release automatically
   ↓
4. Download from Releases page
   ↓
5. Share with users
```

## 📋 Checklist for Using Automated Build

- ✅ Push code to GitHub
- ✅ Wait for Actions to complete (2-5 minutes)
- ✅ Go to Actions tab
- ✅ Download artifacts.zip
- ✅ On Mac: Extract → Open in Xcode → Build → Test
- ✅ Create Release when ready

## 🐛 Troubleshooting

### Build Failed?
1. Check the workflow logs (Actions tab)
2. Common issues:
   - Xcode version mismatch
   - Missing Info.plist files
   - Swift syntax errors
3. Fix locally, commit, and try again

### Artifacts Not Available?
1. Might be older than 30 days
2. Check retention settings
3. Re-trigger build: Push any change or use workflow_dispatch

### Can't Download?
1. Check GitHub.com → Actions tab
2. Select latest "Build iOS App" workflow
3. Scroll to Artifacts section
4. Verify artifacts.zip exists

## 🔄 Re-running Builds

### From GitHub Web:
1. Go to Actions tab
2. Select "Build iOS App" workflow
3. Click "Run workflow"
4. Select branch
5. Click "Run workflow"

### From Command Line:
```bash
# Trigger workflow by pushing a change
echo "# Update" >> README.md
git add README.md
git commit -m "Trigger rebuild"
git push
```

## 📊 Monitoring Builds

Go to **GitHub.com** → Your repo → **Actions** tab to see:
- ✅ Passed builds (green)
- ❌ Failed builds (red)
- ⏳ In-progress builds (yellow)
- Build duration
- Commit & branch info

## 📞 Support Resources

- **GitHub Actions Docs:** https://docs.github.com/en/actions
- **Xcode Build Guide:** ios/BUILD_GUIDE.md
- **Device Setup:** ios/DEVICE_INSTALLATION.md
- **Troubleshooting:** ios/README.md

---

**Your iOS app is now automatically built on every push!** 🎉

No more manual Xcode compilation needed for CI/CD.
