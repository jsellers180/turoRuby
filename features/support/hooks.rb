After do |scenario|
    ($non_cuke ? fail_info : fail_info_cuke) unless scenario.passed?
end