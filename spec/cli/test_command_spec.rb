require "cli_helper"

RSpec.describe "Test Command", type: :aruba do
  it "returns an error with no algorithm chosen" do
    run_command("pokeng test")

    expect(last_command_started).to have_exit_status(1)
  end

  it "returns an error with an unknown algorithm chosen" do
    run_command("pokeng test --algorithm=nothing")

    expect(last_command_started).to have_exit_status(1)
  end

  it "allows the user to choose the naive algorithm" do
    run_command("pokeng test --algorithm=naive")

    expect(last_command_started).to have_exit_status(0)
    expect(last_command_started).to have_output(/Naïve/)
  end

  it "allows the user to choose the markov chain based algorithm" do
    run_command("pokeng test --algorithm=markov --context=3")

    expect(last_command_started).to have_exit_status(0)
    expect(last_command_started).to have_output(/Markov\[3\]/)
  end

  it "returns an error if the user does not choose of length for the markov chain" do
    run_command("pokeng test --algorithm=markov")

    expect(last_command_started).to have_exit_status(1)
  end

  it "allows the user to control the number of names generated" do
    run_command("pokeng test --algorithm=naive --sample 10000")

    expect(last_command_started).to have_exit_status(0)
    expect(last_command_started).to have_output(/10000/)
  end
end
