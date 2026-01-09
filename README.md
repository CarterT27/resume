# Resume Repository

This repository manages multiple versions of my resume (SWE, Research, Company-Specific, etc.) using [Typst](https://typst.app/). It is inspired by [Jake's Resume Template](https://www.overleaf.com/latex/templates/jakes-resume/syzfjbzwjncs).

## Structure

- **`common.yaml`**: Contains shared personal data (Contact info, Education, Experience pool). **Note:** This file is ignored by git to protect private data.
- **`layout.typ`**: The common Typst layout definition.
- **`template/`**: Template directory for creating new resume versions.
- **`swe/`, `research/`, etc.**: Subdirectories for specific resume versions. Each contains:
    - `First_Last_resume.typ`: The entry point for that version.
    - `config.yaml`: Role-specific overrides (ignored by git).

## Prerequisites

- **Typst**: [Installation Guide](https://github.com/typst/typst#installation)
- **Make**: For building the resumes.

## Usage

### 1. Setup
Ensure you have a `common.yaml` in the root directory. This file should contain your base information (Contact, Education, Experience).

### 2. Build Resumes
Use the `Makefile` to build resumes. Change `First_Last_resume.typ` to your name.

- **Build All:**
  ```bash
  make all
  ```
- **Build Specific Role:**
  ```bash
  make swe
  make research
  ```
- **Clean Output:**
  ```bash
  make clean
  ```

### 3. Create New Resume
To create a new resume version (e.g., for a "Data Scientist" role):

```bash
make new NAME=data_scientist
```
This creates a `data_scientist/` directory. Edit `data_scientist/config.yaml` to override specific sections or select specific experiences.

### 4. Development
To watch for changes and auto-compile a specific resume:

```bash
typst watch swe/First_Last_resume.typ
```
