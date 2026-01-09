# Makefile for building resumes

# User Settings: Change these to your name
FIRST_NAME = First
LAST_NAME = Last

# Find all .typ files in subdirectories (depth 2), excluding 'legacy' and 'template'
RESUME_FILES := $(shell find . -mindepth 2 -maxdepth 2 -type f -name "*.typ" -not -path "./legacy/*" -not -path "./template/*")
# Extract directory paths
RESUME_DIRS := $(dir $(RESUME_FILES))
# Extract just the directory names (e.g., ml_engineer, swe)
TARGETS := $(sort $(notdir $(patsubst %/,%,$(RESUME_DIRS))))

.PHONY: all clean new help $(TARGETS)

# Default target: build all discovered resumes
all: $(TARGETS)

# Dynamic rule: Any directory name listed in TARGETS will run this command
$(TARGETS):
	@echo "Building $@..."
	@# Find the .typ file in the target directory
	@SRC=$$(find $@ -maxdepth 1 -name "*.typ" | head -n 1); \
	if [ -z "$$SRC" ]; then \
		echo "Error: No .typ file found in $@"; \
		exit 1; \
	fi; \
	typst compile --root . "$$SRC"; \
	echo "[OK] Generated $${SRC%.typ}.pdf"

# Helper to create a new resume directory from the template
# Usage: make new NAME=folder_name
new:
	@if [ -z "$(NAME)" ]; then \
		echo "Error: NAME is required. Usage: make new NAME=<folder_name>"; \
		exit 1; \
	fi
	@if [ -d "$(NAME)" ]; then \
		echo "Error: Directory '$(NAME)' already exists."; \
		exit 1; \
	fi
	@mkdir -p $(NAME)
	@cp template/config.yaml $(NAME)/ 
	@cp template/First_Last_resume.typ $(NAME)/$(FIRST_NAME)_$(LAST_NAME)_resume.typ
	@echo "[OK] Created new resume in: $(NAME)/"
	@echo "  -> Created $(NAME)/$(FIRST_NAME)_$(LAST_NAME)_resume.typ"
	@echo "  -> Edit $(NAME)/config.yaml to customize."

clean:
	rm -f */*.pdf

help:
	@echo "Resume Builder"
	@echo "--------------"
	@echo "make all              : Build all resumes found in subdirectories"
	@echo "make <role>           : Build a specific resume (e.g., 'make swe')"
	@echo "make new NAME=<name>  : Create a new resume folder from template"
	@echo "make clean            : Remove all generated PDFs"
