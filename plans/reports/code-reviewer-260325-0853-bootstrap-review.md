# Code Review: Bootstrap.sh & README Updates

**Reviewed:** bootstrap.sh (new), README.md (Quick Start & Structure sections)
**Date:** 2026-03-25
**Reviewer:** code-reviewer
**Assessment:** 8.5/10 – High quality, ship-ready with minor edge case fixes

---

## Scope

| Metric | Value |
|--------|-------|
| Files | 2 (bootstrap.sh, README.md) |
| LOC reviewed | 201 (bootstrap.sh) |
| Focus | Functionality, security, edge cases, docs accuracy |

---

## Overall Assessment

**bootstrap.sh** is well-structured, follows bash best practices, includes proper error handling, and provides clear user feedback. **README.md** Quick Start section is prominent and accurate. The implementation successfully achieves the 1-click bootstrap goal for fresh macOS setups.

**Quality: High.** Code is readable, idiomatic bash, and production-ready. The main blockers are minor edge cases that could cause issues in specific scenarios.

---

## Critical Issues

**None.** No security vulnerabilities, data loss risks, or breaking changes detected.

---

## High Priority Issues

### 1. Tilde (`~`) Not Expanded in `--dir` Argument

**Location:** Line 86
**Problem:**
When users pass `--dir ~/.config/dotfiles`, the tilde is NOT automatically expanded in bash variable assignment. This causes:
- `git clone` to fail with "fatal: could not create work tree dir"
- `cp` to fail with "No such file or directory"
- Script exits with cryptic error

**Example failure:**
```bash
# User runs:
curl ... | bash -s -- --dir ~/.config/dotfiles

# Script receives:
DOTFILES_DIR="~/.config/dotfiles"  # Literal tilde, not expanded

# git clone fails:
# fatal: could not create work tree dir '/~/.config/dotfiles'
```

**Impact:** Users who try to customize installation directory will hit a hard error, breaking one of the core feature options (--dir).

**Fix:** Expand tilde explicitly:
```bash
# Line 86:
DOTFILES_DIR="${2/#\~/$HOME}"  # Expand ~ to $HOME
# OR
DOTFILES_DIR="$(eval echo "$2")"  # eval expands tilde and variables
```

**Recommendation:** Use the first option (parameter expansion) to avoid eval injection risks.

---

### 2. No Parent Directory Creation Before Git Clone

**Location:** Lines 140–155
**Problem:**
If user specifies `--dir /custom/deep/path/dotfiles` and `/custom/deep` doesn't exist, the script relies on `git clone` to create the full path. While `git clone` DOES create parent directories (confirmed via testing), the script has NO error handling for:
- Insufficient permissions on parent directory
- Disk space issues
- Symlink loops or permission denied from parent path

**Current code:**
```bash
git clone "$GITHUB_REPO" "$DOTFILES_DIR" 2>/dev/null || {
    echo "❌ Error: Failed to clone repository"
    echo "   Check your internet connection and try again."
    exit 1
}
```

The error message assumes network failure, but may actually be a filesystem permission issue.

**Impact:** Misleading error message; users debugging permission issues see generic "check internet" advice.

**Fix:** Create parent directory explicitly and distinguish error types:
```bash
mkdir -p "$(dirname "$DOTFILES_DIR")" || {
    echo "❌ Error: Cannot create parent directory $(dirname "$DOTFILES_DIR")"
    echo "   Check permissions and disk space."
    exit 1
}

git clone "$GITHUB_REPO" "$DOTFILES_DIR" 2>/dev/null || {
    # Could be network, disk, or permission issue
    echo "❌ Error: Failed to clone repository"
    echo "   - Check internet connection"
    echo "   - Verify disk space"
    echo "   - Ensure $DOTFILES_DIR is not readonly"
    exit 1
}
```

---

## Medium Priority Issues

### 3. Silent Redirect of Git Pull Errors (Line 143)

**Location:** Line 143
```bash
git -C "$DOTFILES_DIR" pull --ff-only 2>/dev/null || {
    echo "   ⚠️  Could not pull latest changes (offline or local modifications)"
}
```

**Problem:**
`2>/dev/null` silences ALL errors, including:
- Corrupt local .git directory
- Permission issues
- Disk full
- Invalid remotes

Users see only a generic warning and might continue with stale code.

**Recommendation:** Log errors to aid troubleshooting (optional, not blocking):
```bash
git -C "$DOTFILES_DIR" pull --ff-only 2>&1 || {
    echo "   ⚠️  Could not pull latest changes (offline or local modifications)"
}
```

This allows users to see actual errors if they need to debug, while still continuing gracefully.

---

### 4. Config.local Copy Doesn't Preserve Permissions

**Location:** Line 177
```bash
cp "$DOTFILES_DIR/config.example" "$CONFIG_FILE"
```

**Problem:**
`cp` doesn't preserve file permissions by default. If `config.example` has restrictive permissions (e.g., 600), the copy may have different permissions. Minor issue but inconsistent with best practices.

**Recommendation:**
```bash
cp -p "$DOTFILES_DIR/config.example" "$CONFIG_FILE"  # -p preserves perms
```

---

### 5. Missing Quote Handling in Interactive Mode Path

**Location:** Line 170
```bash
bash "$DOTFILES_DIR/setup.sh"
```

**Problem:**
If user has spaces in `DOTFILES_DIR`, this still works (quotes present). ✓ Correct.

**Status:** No issue. Included for verification only.

---

## Low Priority Issues

### 6. Hardcoded GitHub URL and No Offline Fallback

**Location:** Line 13
```bash
GITHUB_REPO="https://github.com/tranxuanliem/dotfiles.git"
```

**Problem:**
If GitHub is unreachable, users cannot bootstrap. While expected behavior, no alternative (e.g., fallback URL, local file check) exists.

**Recommendation:** Not required but consider documenting mirror/fallback options in README if this becomes a frequent issue.

**Status:** Low priority – accept as-is for MVP.

---

### 7. Xcode Timeout Uses 5-second Polls

**Location:** Lines 114–126
```bash
max_attempts=360  # 30 minutes max
attempt=0
until xcode-select -p &>/dev/null; do
    attempt=$((attempt + 1))
    if [ $attempt -ge $max_attempts ]; then
        echo ""
        echo "❌ Error: Xcode CLI tools installation timed out after 30 minutes."
        exit 1
    fi
    sleep 5
done
```

**Observation:**
Timeout is reasonable (30 min) and polling interval is acceptable. On very slow networks, poll interval could be increased to 10–15 seconds to reduce CPU overhead, but current implementation is acceptable.

**Status:** No action needed.

---

## README.md Review

### Quick Start Section (Lines 12–31)

**Strengths:**
- ✓ Prominent position (line 12, second section after Features)
- ✓ Copy-paste ready single-line command
- ✓ Clear explanation of what it does
- ✓ Options documented with examples
- ✓ Manual alternative provided

**Issues:** None detected.

### Structure Section (Lines 95–124)

**Strengths:**
- ✓ Accurate file listing
- ✓ Matches actual directory structure
- ✓ Includes bootstrap.sh in documentation
- ✓ Clear hierarchy

**Verification:**
- `bootstrap.sh` exists and is executable ✓
- `setup.sh` and `install.sh` referenced correctly ✓
- `config.example` exists ✓
- All paths in structure diagram match reality ✓

**Issues:** None detected.

---

## Edge Cases Found

### Case 1: Tilde in Custom Directory Path
**Status:** BLOCKER (Issue #1)
**Example:** `bash bootstrap.sh --dir ~/.dotfiles`
**Outcome:** Will fail with cryptic git error
**Fix:** Expand tilde before using in commands

### Case 2: Parent Directory Lacks Permissions
**Status:** MEDIUM (Issue #2)
**Example:** `bash bootstrap.sh --dir /opt/tools/dotfiles` (no write access to /opt)
**Outcome:** Error message misleads ("check internet") when issue is permissions
**Fix:** Explicit `mkdir -p` with better error context

### Case 3: Pre-existing Repository
**Status:** HANDLES WELL
**Example:** Running script twice on same system
**Outcome:** Script detects .git and pulls updates ✓
**Verification:** Line 140–155 handles idempotency correctly

### Case 4: Network Timeout During Clone
**Status:** HANDLES WELL
**Example:** Slow/flaky internet during initial clone
**Outcome:** User gets clear error message ✓
**Verification:** Error handler provides actionable advice

### Case 5: Config.local Already Exists
**Status:** HANDLES WELL
**Example:** Running script twice with same config
**Outcome:** Script detects and skips overwrite ✓
**Verification:** Line 167 checks for existing file

---

## Security Review

### Credentials & Secrets
- ✓ No hardcoded credentials
- ✓ No environment variable leaks
- ✓ No unintended file writes

### Input Validation
- ✓ `--dir` argument is validated (requires argument, checked line 82)
- ✓ Unknown options rejected (line 89–92)
- ✓ Shell injection risk: LOW (variables are quoted or restricted)

### Command Injection
- ✓ User-supplied paths are properly quoted in most places
- ✓ One risk: eval in tilde expansion should use parameter expansion instead

### File Permissions
- Safe: Uses `cp` (not eval), `bash` with file args, `git` with URL
- Minor: Should use `cp -p` to preserve config file permissions

**Overall:** SECURE. No OWASP Top 10 issues detected.

---

## Code Quality

| Aspect | Score | Notes |
|--------|-------|-------|
| Readability | 9/10 | Clear structure, descriptive variable names, helpful comments |
| Error Handling | 7/10 | Uses `set -e`, good exit codes, but some errors mask root cause |
| Bash Style | 9/10 | Follows best practices (quotes, variable expansion, no unnecessary pipes) |
| Documentation | 9/10 | Help text is complete, examples are accurate |
| Idempotency | 9/10 | Handles re-runs correctly (except config setup) |
| User Experience | 8/10 | Clear progress messages, emoji feedback, but some error messages need context |

---

## Positive Observations

1. **Defensive Programming:** Uses `set -e`, quotes variables, checks file existence
2. **User-Friendly:** Provides progress indicators, explains what each step does, includes help text
3. **Portable:** Works across different macOS versions; uses standard bash (no zsh-isms)
4. **Idempotent:** Can run multiple times safely (git pull, config check)
5. **Well-Documented:** README updates are accurate, examples are correct
6. **Emoji Feedback:** Makes output scannable and friendly (subjective but effective)
7. **Clear Separation:** Four distinct logical steps (Xcode, repo, config, install)

---

## Recommended Actions

### Must Fix (Blocking)
1. **Issue #1:** Fix tilde expansion in `--dir` argument (line 86)
   - Use: `DOTFILES_DIR="${2/#\~/$HOME}"`
   - Risk: Without this, `--dir ~/.config/dotfiles` fails silently

### Should Fix (High Priority)
2. **Issue #2:** Add explicit parent directory creation (line 148)
   - Prevents permission errors from being misdiagnosed
   - Improves error messages

### Consider Fixing (Nice to Have)
3. **Issue #3:** Remove `2>/dev/null` from git pull (line 143)
   - Allows debugging without breaking functionality
4. **Issue #4:** Use `cp -p` to preserve config permissions (line 177)

### Finalization
- After fixes, run manual test: `bash bootstrap.sh --dir ~/.test_dotfiles` to verify tilde handling
- Test on a fresh Mac (VM recommended) to confirm Xcode CLI flow works end-to-end

---

## Metrics

| Metric | Result |
|--------|--------|
| Type Safety | N/A (bash script) |
| Syntax Errors | 0 |
| Critical Security Issues | 0 |
| High Priority Issues | 2 |
| Test Coverage | Manual testing required |
| Linting Issues | 0 (follows shellcheck best practices) |

---

## Unresolved Questions

1. **Should `config.local` remain git-ignored?** (Yes, current behavior is correct for user-specific config)
2. **Does install.sh expect a specific working directory?** (Assume yes, but script should verify)
3. **Are there integration tests for the full bootstrap flow?** (Recommend adding smoke test in CI)

---

## Summary

**bootstrap.sh** is production-ready with two high-priority edge case fixes needed. The implementation successfully enables 1-click setup, handles most error cases gracefully, and includes clear user feedback. README updates are accurate and properly positioned.

**Recommendation:** Fix issues #1 and #2, then approve for merge. The fixes are small and low-risk. After merge, recommend manual end-to-end test on fresh macOS instance.

**Quality Score: 8.5/10** (would be 9.5+ after fixes)
