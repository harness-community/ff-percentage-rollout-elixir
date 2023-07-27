# Before you Begin

Harness Feature Flags (FF) is a feature management solution that enables users to change the software’s functionality, without deploying new code. FF uses feature flags to hide code or behaviours without having to ship new versions of the software. A feature flag is like a powerful if statement.

For more information, see https://harness.io/products/feature-flags/

To read more, see https://ngdocs.harness.io/category/vjolt35atg-feature-flags

To sign up, https://app.harness.io/auth/#/signup/

The ElixirPercentageRollout is a module in Elixir that simulates a percentage rollout evaluation for feature flags. It counts the number of occurrences of each rollout variant over 100,000 evaluations with unique targets and calculates the percentage each variant makes up of the total. This can be used to verify the distribution of different variations in a feature flag setup.

## Requirements
- Elixir

## Prerequisites

Before using this module, make sure to:

1. Create a new string flag in Harness Feature Flags. While creating this flag, create the following variations:

   - rollout_variant_1
   - rollout_variant_2
   - rollout_variant_3
   - default_on_variant
   - default_off_variant
   
Set the Flag's default on value to use `default_on_variant`, and set the default off value to use `default_off_variant`

2. Create a Target Group with a condition that says `target identifier starts_with "target"`. This will ensure the targets generated by the module will be included in the Target Group.

## Usage

Install dependencies using [Mix](https://elixir-lang.org/getting-started/mix-otp/introduction-to-mix.html)
```shell
mix deps.get
````

Export SDK Key [Mix](https://elixir-lang.org/getting-started/mix-otp/introduction-to-mix.html)
```shell
export FF_API_KEY="your_key"
````

Start the Elixir CLI
```shell
iex -S mix
```

To use the module, call the `run_percentage_rollout_evaluations` function with the flag identifier as the parameter. For example:

```elixir
ElixirPercentageRollout.Evaluation.run_percentage_rollout_evaluations("my-flag-identifier")
```

The application will log the variation evaluation counts, and their percentage breakdown.

Next, you can optionally validate that your flag's metrics match up with your percentage rollout rule. 
** Important: Metrics for Harness Feature Flags show total evaluations, not the percentage rollout state of given targets.
Discrepancies can occur in Metrics for the following reasons:
- Majority of your traffic originates from a specific target or targets
- Evaluations from Other Code 
- Targets not being included in the target group

