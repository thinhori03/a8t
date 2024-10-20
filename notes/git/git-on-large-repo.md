
# git on large repository.

### 1. **Shallow Clone**
For large repositories, cloning the entire history can be cumbersome. To save time and disk space, you can clone a shallow copy with only part of the history using:

```bash
git clone --depth 1 <repo-url>
```

This only fetches the most recent commit (or a few commits if you increase the value of `--depth`), reducing both clone time and storage usage.

### 2. **Sparse-Checkout**
If you only need specific folders or files from a large repository, you can use `sparse-checkout` to download only the necessary parts, reducing disk usage and improving performance.

For example:
```bash
git sparse-checkout init
git sparse-checkout set <folder-path>
```
This helps you only fetch the parts of the repository that are required, rather than the entire repo.

### 3. **Single-Branch Clone**
If you don't need all branches of the repository, you can clone only a specific branch, which saves memory and time:

```bash
git clone --single-branch --branch <branch-name> <repo-url>
```

This only fetches the branch you're interested in, ignoring other branches.

### 4. **Git LFS (Large File Storage)**
If the repository contains large files (such as images, videos, or binary files), you can use [Git LFS](https://git-lfs.github.com/) to manage them efficiently. Git LFS stores large files outside the main Git repository, helping to keep the repo light and faster.

Install Git LFS:
```bash
git lfs install
```
Track large files with LFS:
```bash
git lfs track "*.psd"  # Example for .psd files
```

### 5. **Splitting Large Repos into Submodules or Monorepo**
If a repository becomes too large because it contains multiple independent components, you may consider splitting it into submodules or switching to a monorepo structure:

- **Git Submodules**: Allows you to keep multiple repositories as separate entities inside a parent repository.
- **Monorepo**: Use tools like [Lerna](https://lerna.js.org/) (for JavaScript) or [Bazel](https://bazel.build/) to manage multiple projects inside one large repository while maintaining efficiency.

### 6. **Use `git gc` to Clean Up the Repo**
When a repository is large with lots of commit history, garbage files can take up significant space. You can run `git gc` to clean it up:

```bash
git gc --prune=now --aggressive
```

This helps reduce the size of the repository by removing unnecessary objects.

### 7. **Analyze Repo with `git-sizer`**
The [git-sizer](https://github.com/github/git-sizer) tool helps you analyze a repository to find the largest parts (commits, files, branches). This is useful for identifying which components are taking up the most space in a large repository.

Install `git-sizer`:
```bash
brew install git-sizer  # For macOS
```

Run `git-sizer` to analyze the repo:
```bash
git-sizer
```

### 8. **Limit History with `git log`**
In large repositories, using `git log` to view commit history can be slow. You can limit the number of commits displayed by using parameters:

- Show history for a specific file:
  ```bash
  git log -- <filename>
  ```

- Limit the number of commits:
  ```bash
  git log -n 100
  ```

### 9. **Use CI/CD to Manage Large Repos**
With large repositories, building and testing can take a lot of time. You can automate the build, testing, and deployment process using CI/CD (Continuous Integration/Continuous Delivery) systems so you don’t have to run everything on your local machine.

### Conclusion:
- Using techniques like shallow clone, sparse-checkout, and managing large files with Git LFS can help improve performance when working with large repositories.
- Optimizing the repository by cleaning up or breaking the project into smaller modules will help in long-term maintenance.
