# Resume Repository

This repository manages multiple versions of my resume (SWE, Research, Company-Specific, etc.) using [Typst](https://typst.app/).

## Structure

- **`common.yaml`**: Contains shared personal data. **Note:** This file is ignored by git.
- **`layout.typ`**: The common Typst layout definition.
- **`template/`**: Template directory for creating new resume versions.
    - `First_Last_resume.typ`: The base resume source.
    - `config.yaml`: Default configuration.
- **Subdirectories (`swe/`, `research/`, etc.)**: Created via `make new`. These are ignored by git to keep your specific resume data private.

## Prerequisites

- **Typst**: [Installation Guide](https://github.com/typst/typst#installation)
- **Make**: For building the resumes.

## Usage

### 1. Setup
1. Create a `common.yaml` in the root directory with your base information.
2. Update the `FIRST_NAME` and `LAST_NAME` variables at the top of the `Makefile`.

### 2. Create New Resume
To create a new resume version (e.g., for a "SWE" role):

```bash
make new NAME=swe
```
This creates a `swe/` directory, copies the template files, and renames the source file according to the names set in your `Makefile`.

### 3. Build Resumes
Use the `Makefile` to build resumes into PDFs.

- **Build All:**
  ```bash
  make all
  ```
- **Build Specific Role:**
  ```bash
  make swe
  ```
- **Clean Output:**
  ```bash
  make clean
  ```

### 4. Development
To watch for changes and auto-compile a specific resume:

```bash
typst watch swe/Carter_Tran_resume.typ
```