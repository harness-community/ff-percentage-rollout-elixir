# ElixirPercentageRollout.Evaluation.runPercentageRolloutEvaluations

defmodule ElixirPercentageRollout.Evaluation do
  require Logger

  def runPercentageRolloutEvaluations(flagIdentifier) do
    evaluate_200k_unique_targets({0, 0, 0}, 0)
  end

  def evaluate_200k_unique_targets(flagIdentifier, {variation1_counter, variation2_counter, variation3_counter}, 200_000) do
    {variation1_counter, variation2_counter, variation3_counter}
  end
  def evaluate_200k_unique_targets(flagIdentifier, {variation1_counter, variation2_counter, variation3_counter}, accu_in) do
    counter = accu_in + 1
    target_identifier_number = Integer.to_string(counter)
    dynamic_target = %{
      identifier: "target" <> target_identifier_number,
      name: "targetname" <> target_identifier_number,
      anonymous: ""
    }
    case :cfclient.string_variation(flagIdentifier, dynamic_target, "default") do
      {:ok, _, "variation1"} ->
        evaluate_200k_unique_targets(
          flagIdentifier,
          {variation1_counter + 1, variation2_counter, variation3_counter},
          counter
        )

      {:ok, _, "variation2"} ->
        evaluate_200k_unique_targets(
          flagIdentifier,
          {variation1_counter, variation2_counter + 1, variation3_counter},
          counter
        )

      {:ok, _, "variation3"} ->
        evaluate_200k_unique_targets(
          flagIdentifier,
          {variation1_counter, variation2_counter, variation3_counter + 1},
          counter
        )
    end
  end
end
