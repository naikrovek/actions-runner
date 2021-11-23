# actions-runner
EXTREMELY BASIC github actions runner docker image.  Use this as a base to customize your own image,
or copy what this one is doing.

Usage for a single repo:
```bash
docker run --rm -d \
 -e RUNNER_REPOSITORY_URL=https://github.com/who/what \
 -e GITHUB_TOKEN=<PAT_having_repo_access> \
 <name_and_tag_of_this_container:1.0>
```

... for an entire org:
```bash
docker run --rm -d \
 -e RUNNER_ORGANIZATION_URL=https://github.com/who/ \
 -e GITHUB_TOKEN=<PAT_having_admin:org> \
 <name_and_tag_of_this_container:1.0>
```

... and for an entire enterprise server instance:
```bash
docker run --rm -d \
 -e RUNNER_ENTERPRISE_URL=https://github.example.com/ \
 -e GITHUB_TOKEN=<PAT_having_admin:enterprise> \
 <name_and_tag_of_this_container:1.0>
```