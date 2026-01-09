# Resume Template

This repository contains a resume template built with [Typst](https://typst.app/) and configured via a YAML file.

## Prerequisites

You need to have **Typst** installed on your system.
- **macOS (Homebrew):** `brew install typst`
- **Windows (Winget):** `winget install typst`
- **Linux (Arch):** `pacman -S typst`
- **Other:** Check the [Typst installation guide](https://github.com/typst/typst#installation).

## Usage

### 1. Modify Content
All personal information and resume content are stored in `config.yaml`. Open this file in any text editor to update:
- Contact Information (Name, Email, Phone, etc.)
- Links (Website, LinkedIn, GitHub)
- Education
- Experience
- Projects
- Awards
- Skills

### 2. Move/Reorder Sections
The layout is defined in `Carter_Tran_resume.typ`. To change the order of sections (e.g., move "Skills" above "Education"):

1. Open `Carter_Tran_resume.typ`.
2. Locate the code block for the section you want to move. A section typically starts with `#section("Title")` and includes a loop like `#for ... in config.section_name { ... }`.
3. Cut and paste the entire block to your desired location within the file.

**Example Section Block:**
```typst
#section("Education")

#for edu in config.education {
  resumeSubheading(
    edu.institution,
    edu.date,
    edu.degree,
    edu.location
  )
  resume-list-start([
    #for item in edu.items [
      - #eval(item, mode: "markup")
    ]
  ])
}
```

### 3. Compile
To generate the PDF resume, run the following command in your terminal:

```bash
typst compile Carter_Tran_resume.typ
```

This will create `Carter_Tran_resume.pdf` in the same directory.

### 4. Watch Mode (Optional)
To automatically recompile whenever you save changes to `.typ` or `.yaml` files:

```bash
typst watch Carter_Tran_resume.typ
```
