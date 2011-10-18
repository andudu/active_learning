function test_ind = random_selection(data, responses, test, num_test_points)

  num_test = size(test, 1);
  r = randperm(num_test);
  test_ind = r(1:num_test_points);

end