# LDCHECK Action

This GitHub Action runs LDCHECK on Android recovery builds to check for missing dependencies.

## Description

LDCHECK is a tool used in Android development to identify missing shared library dependencies. This action automates the process of running LDCHECK on your recovery build output, helping you identify and resolve dependency issues more efficiently.

## Inputs

| Input | Description | Required | Default |
|-------|-------------|----------|---------|
| `OUTPUT_DIR` | Output directory of the build | Yes | N/A |
| `LDCHECKPATH` | Path of blobs to check | Yes | `system/bin/qseecomd` |

## Usage

To use this action in your workflow, add the following step:

```yaml
- name: Run LDCHECK
  uses: mlm-games/ldcheck-action@main
  with:
    OUTPUT_DIR: ${{ env.OUTPUT_DIR }}
    LDCHECKPATH: ${{ inputs.LDCHECKPATH }}
```

Replace `mlm-games/ldcheck-action@main` with the actual repository name and branch/tag where you've published this action.

## Example

Here's an example of how to integrate this action into a workflow:

```yaml
jobs:
  build:
    runs-on: ubuntu-latest
    steps:
      # ... previous steps ...

      - name: Build Recovery
        run: |
          # Your build steps here
          # This should populate the OUTPUT_DIR

      - name: Run LDCHECK
        uses: mlm-games/ldcheck-action@main
        with:
          OUTPUT_DIR: ${{ env.OUTPUT_DIR }}
          LDCHECKPATH: system/bin/qseecomd

      # ... subsequent steps ...
```

## Tools Included

This action includes two binary tools in the `tools` directory:

1. `libneeds`: A utility for analyzing shared library dependencies.
2. `ldcheck`: The main tool for checking library dependencies.

These tools are automatically copied to the appropriate location in your build output directory when the action runs.


## Contributing

Contributions to improve this action are welcome. Please feel free to submit issues or pull requests.

## Disclaimer

This action and the included tools are provided as-is, without any warranties. Always review the results and use them at your own discretion.
