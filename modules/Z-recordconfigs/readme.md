*DISCLAIMER: this readme was created with AI, and it covers the general aspects of the module. If you require more specifics, please raise an issue in the github repository.  
  
# Z-recordconfigs: Configuration Recording Module

## Module Overview

The `Z-recordconfigs` module in the `nf-vcf2genehancer` pipeline records the configuration settings used during the pipeline execution. This ensures reproducibility and provides a reference for the parameters and settings applied in each run.

## Key Components

- **`main.nf`**: The primary Nextflow script orchestrating the configuration recording process.
- **`nextflow.config`**: Configuration file specifying parameters and settings for the module.
- **`testmodule.nf`**: A test Nextflow script to validate the module's functionality.
- **`testmodule.sh`**: A shell script associated with the test module for validation purposes.

## Process Overview

This module captures and records pipeline configurations by:

1. Reading the `nextflow.config` file and other relevant configuration sources.
2. Recording the parameters and their values used during the pipeline execution.
3. Saving the captured configurations to a designated output file for reference and reproducibility.

## Inputs

- **Configuration Files**: Files containing the configuration settings, primarily `nextflow.config`.

## Outputs

- **Recorded Configurations File**: A file documenting the configuration settings applied during the pipeline run.

## Usage

To use this module within the `nf-vcf2genehancer` pipeline, ensure that the `nextflow.config` and any other relevant configuration files are properly set up. The module will automatically capture and record the settings during the pipeline execution.

## Dependencies

- **Nextflow**: Ensure that Nextflow is installed and properly configured in your environment.
- **Bash**: Required for executing shell scripts in the module.

## Example Command

This module runs automatically as part of the pipeline. To execute the pipeline with specific parameters:

```bash
nextflow run nf-vcf2genehancer --param1 value1 --param2 value2
