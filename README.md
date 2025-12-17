# AWS Lambda Python Template

A production-ready template for developing Python applications that can run both as CLI tools and AWS Lambda functions.

## Features

- **🚀 Dual Environment**: Develop and test locally as a CLI application, deploy as AWS Lambda
- **📦 Modern Tooling**: UV package manager for fast dependency management
- **🧪 Testing Ready**: Pre-configured unit testing setup
- **⚙️ CI/CD Integration**: GitHub Actions workflow for automated deployment
- **📋 Deployment Scripts**: Built-in packaging and deployment automation

## Quick Start

1. **Clone and customize**:
   ```bash
   git clone <repository-url>
   cd aws-lambda-python-template
   ```

2. **Rename the project**:
   - Replace all occurrences of `aws-lambda-python-template` with your project name. Find all occurrences using `grep -r 'aws-lambda-python-template'`
   - Rename the `aws-lambda-python-template` folder to match your project

3. **Install dependencies**:
   ```bash
   uv sync
   ```

4. **Run locally**:
   ```bash
   uv run python -m your_project_name
   ```

## Project Structure

```
├── src/                    # Source code
├── tests/                  # Unit tests
├── scripts/               # Deployment scripts
├── .github/workflows/     # GitHub Actions
└── pyproject.toml        # Project configuration
```

## Development

- **Local testing**: Run as a standard Python CLI application
- **Unit tests**: Execute with your preferred test runner
- **Lambda deployment**: Use included scripts for AWS deployment

## Deployment

The template includes automated deployment via GitHub Actions. Configure your AWS credentials in repository secrets for seamless CI/CD.