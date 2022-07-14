require "cli_helper"

RSpec.describe "Generate Command", :type => :aruba do
  it "allows the user to run with no options given" do
    run_command('pokeng generate')

    expect(last_command_started).to have_exit_status(0)
  end

  it "allows the user to choose the naive algorithm" do
    run_command('pokeng generate --algorithm=naive')

    expect(last_command_started).to have_exit_status(0)
    expect(last_command_started).to have_output(/Naïve/)
  end

  it "allows the user to choose the markov chain based algorithm" do
    run_command('pokeng generate --algorithm=markov')

    expect(last_command_started).to have_exit_status(0)
    expect(last_command_started).to have_output(/Markov\[3\]/)
  end

  it "skips the introduction if only one name is being produced" do
    run_command('pokeng generate --number 1')

    expect(last_command_started).to have_exit_status(0)
    expect(last_command_started).not_to have_output(/Generating 1 name/)
  end

  it "allows the user to control the number of names generated" do
    run_command('pokeng generate --number 5')

    expect(last_command_started).to have_exit_status(0)
    expect(last_command_started).to have_output(/Generating 5 names\.\.\./)
  end
end
