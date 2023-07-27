# ElixirPercentageRollout.Evaluation.runPercentageRolloutEvaluations

defmodule ElixirPercentageRollout.Evaluation do
  require Logger

  def runPercentageRolloutEvaluations(flagIdentifier) do
    final_counts = evaluate200kUniqueTargets(flagIdentifier, {0, 0, 0}, 0)
    Logger.info("Final Counter Values: Variant 1: #{elem(final_counts, 0)}, Variant 2: #{elem(final_counts, 1)}, Variant 3: #{elem(final_counts, 2)}")
    Logger.info("""
    Final Percentage Values (rounded to 2 decimal places):
    Variant 1: #{elem(final_counts, 0)} (#{Float.round(elem(final_counts, 0) / 200_000 * 100, 2)}%)
    Variant 2: #{elem(final_counts, 1)} (#{Float.round(elem(final_counts, 1) / 200_000 * 100, 2)}%)
    Variant 3: #{elem(final_counts, 2)} (#{Float.round(elem(final_counts, 2) / 200_000 * 100, 2)}%)
    """)
  end
  defp evaluate200kUniqueTargets(_, {variation1_counter, variation2_counter, variation3_counter}, 200_000) do
    {variation1_counter, variation2_counter, variation3_counter}
  end
  defp evaluate200kUniqueTargets(flagIdentifier, {variation1_counter, variation2_counter, variation3_counter}, accu_in) do
    counter = accu_in + 1
    target_identifier_number = Integer.to_string(counter)
    dynamic_target = %{
      identifier: "target" <> target_identifier_number,
      name: "targetname" <> target_identifier_number,
      anonymous: ""
    }
    case :cfclient.string_variation(flagIdentifier, dynamic_target, "default") do
      {:ok, _, "rollout_variant_1"} ->
        evaluate200kUniqueTargets(
          flagIdentifier,
          {variation1_counter + 1, variation2_counter, variation3_counter},
          counter
        )

      {:ok, _, "rollout_variant_2"} ->
        evaluate200kUniqueTargets(
          flagIdentifier,
          {variation1_counter, variation2_counter + 1, variation3_counter},
          counter
        )

      {:ok, _, "rollout_variant_3"} ->
        evaluate200kUniqueTargets(
          flagIdentifier,
          {variation1_counter, variation2_counter, variation3_counter + 1},
          counter
        )
    end
  end
end
