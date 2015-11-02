# 1) Parse the input file and create collection of Test Cases
# 2) For each TestCase, query if complete, if not continue test
# 3) Print out each test's time
require './test_case.rb'
class TestConductor

  VALID_TEST_CASE_EXPRESSION =  /[a-zA-Z]+/

  attr_reader :test_cases

  def initialize(input_file)
    @input_file = input_file
    @test_cases = []

    initialize_test_cases
    # execute_test_cases_independent
    # execute_test_cases_dependent

  end

  def execute_test_cases_independent
    @test_cases.each do | test_case |
      while ( !(test_case.complete?) )
        test_case.perform_test_case_step_independent
      end
    end

    print_test_case_results
  end

  def execute_test_cases_dependent
    @test_cases.each do | test_case |
      while ( !(test_case.complete?) )
        test_case.perform_test_case_step_dependent
      end
    end

    print_test_case_results
  end

  private

  def print_test_case_results
    @test_cases.each_with_index do | test_case, test_case_index |
      puts "Case ##{test_case_index + 1}: #{test_case.time}"
    end
    puts "======================"
  end

  def initialize_test_cases
    @input_file.each_line do |input_file_line|
      next unless VALID_TEST_CASE_EXPRESSION.match(input_file_line)
      @test_cases << TestCase.new(input_file_line)
    end
    @input_file.close
  end

end

# TestConductor.new( File.open("spec/test_input.txt", "r")).execute_test_cases_dependent
# TestConductor.new( File.open("spec/test_input.txt", "r")).execute_test_cases_independent
