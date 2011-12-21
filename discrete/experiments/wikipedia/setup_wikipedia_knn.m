pseudocount = 0.1;

neighbors = neighbors';
similarities = similarities';

weights = sparse(kron((1:num_observations)', ones(num_neighbors, 1)), ...
                 neighbors(:), similarities(:), ...
                 num_observations, num_observations);

max_weights = max(weights);
max_weights = full(max_weights);

probability_function = @(data, responses, train_ind, test_ind) ...
    knn_probability_discrete(responses, train_ind, test_ind, weights, ...
                             pseudocount);

probability_bound = @(data, responses, train_ind, test_ind) ...
    knn_probability_bound_discrete(responses, train_ind, test_ind, ...
        weights, max_weights, pseudocount);

one_step_selection_function = @(data, responses, train_ind) ...
    identity_selection_function(responses, train_ind);

two_step_selection_function = @(data, responses, train_ind) ...
    two_step_search_bound_selection_function(data, responses, ...
        train_ind, probability_function, probability_bound);

selection_functions{1} = one_step_selection_function;
selection_functions{2} = two_step_selection_function;