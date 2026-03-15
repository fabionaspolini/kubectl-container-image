# AGENTS.md - kubectl-container-image

## Project Overview
This project builds multi-version Docker containers for kubectl command-line tools, supporting specific Kubernetes versions (e.g., 1.19, 1.20, 1.21). Each version resides in its own directory with a Dockerfile and shared start.sh script.

## Architecture
- **Versioned Folders**: Each Kubernetes version has a dedicated folder (e.g., `1.21/`) containing:
  - `Dockerfile`: Installs kubectl and AWS CLI, sets up environment.
  - `start.sh`: Entrypoint script handling kubeconfig and AWS credentials.
- **Shared Logic**: `start.sh` is identical across versions, differing only in kubectl version installed.

## Key Patterns
- **Kubeconfig Handling**: Supports base64-encoded config via `KUBECONFIG_BASE64` env var or volume mount at `/root/.kube/config`.
- **AWS EKS Integration**: Automatically configures AWS CLI if `AWS_ACCESS_KEY_ID`, `AWS_SECRET_ACCESS_KEY`, `AWS_REGION` are set.
- **Verbose Mode**: Set `VERBOSE=true` to log decoded kubeconfig and args.
- **Entrypoint Logic**: Runs `kubectl` with passed args; if args start with 'bash' or 'sh', executes shell instead.

## Build Workflow
- **Local Build**: `docker build -f 1.21/Dockerfile -t kubectl:dev ./1.21`
- **CI/CD**: GitLab CI builds images for each version on master/tags, tags as `fabionaspolini/kubectl:<version>` and pushes to Docker Hub.
- **Tagging Convention**: Latest version gets `latest` tag; specific versions like `1.21.3` and `1.21`.

## Development Notes
- **Adding New Version**: Copy an existing folder (e.g., `1.21/`), update kubectl version in Dockerfile (e.g., `kubectl=1.22.x-00`), and add CI job in `.gitlab-ci.yml`.
- **Testing**: Run with `docker run --rm -it -e KUBECONFIG_BASE64=<data> fabionaspolini/kubectl config view`.
- **Dependencies**: Relies on Ubuntu 18.04 base, Kubernetes apt repo, AWS CLI v2.

## Key Files
- `README.md`: Usage examples and environment variables.
- `.gitlab-ci.yml`: CI pipeline for building and pushing images.
- `1.21/Dockerfile`: Exemplifies image build process.
- `1.21/start.sh`: Core entrypoint logic.</content>
<parameter name="filePath">/home/fabio/sources/kubectl-container-image/AGENTS.md
