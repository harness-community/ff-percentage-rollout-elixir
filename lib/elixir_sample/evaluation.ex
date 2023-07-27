defmodule ElixirPercentageRollout.Evaluation do
  require Logger

  def run_percentage_rollout_evaluations(flagIdentifier) do
    Logger.info("Running 100k evaluations on flag #{flagIdentifier}")
    {rollout_variant_1_count, rollout_variant_2_count, rollout_variant_3_count} = evaluate_100k_unique_targets(flagIdentifier, {0, 0, 0}, 0)

    rollout_variant_1_percentage = Float.round(rollout_variant_1_count / 100_000 * 100, 2)
    rollout_variant_2_percentage = Float.round(rollout_variant_2_count / 100_000 * 100, 2)
    rollout_variant_3_percentage = Float.round(rollout_variant_3_count / 100_000 * 100, 2)

    Logger.info("Final Variation Evaluation Counts: Variant 1: #{rollout_variant_1_count}, Variant 2: #{rollout_variant_2_count}, Variant 3: #{rollout_variant_3_count}")
    Logger.info("""
    Final Percentage Values (rounded to 2 decimal places):
    rollout_variant_1 1: #{rollout_variant_1_count} (#{rollout_variant_1_percentage}%)
    rollout_variant_2 2: #{rollout_variant_2_count} (#{rollout_variant_2_percentage}%)
    rollout_variant_3 3: #{rollout_variant_3_count} (#{rollout_variant_3_percentage}%)
    """)
  end

  defp evaluate_100k_unique_targets(_, {variation1_counter, variation2_counter, variation3_counter}, 100_000) do
    {variation1_counter, variation2_counter, variation3_counter}
  end
  defp evaluate_100k_unique_targets(flagIdentifier, {variation1_counter, variation2_counter, variation3_counter}, accu_in) do
    counter = accu_in + 1
    target_identifier_number = Integer.to_string(counter)
    dynamic_target = %{
      identifier: "target" <> target_identifier_number,
      name: "targetname" <> target_identifier_number,
      anonymous: ""
    }

    case :cfclient.string_variation(flagIdentifier, dynamic_target, "default") do
      "rollout_variant_1" ->
        evaluate_100k_unique_targets(
          flagIdentifier,
          {variation1_counter + 1, variation2_counter, variation3_counter},
          counter
        )

      "rollout_variant_2" ->
        evaluate_100k_unique_targets(
          flagIdentifier,
          {variation1_counter, variation2_counter + 1, variation3_counter},
          counter
        )

      "rollout_variant_3" ->
        evaluate_100k_unique_targets(
          flagIdentifier,
          {variation1_counter, variation2_counter, variation3_counter + 1},
          counter
        )
    end
  end
end
