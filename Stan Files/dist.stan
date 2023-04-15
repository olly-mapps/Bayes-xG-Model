data {
  
  //Model Structure

  int<lower=0> n;
  vector[n] X;
  int<lower = 0, upper = 1> y[n];

  //Prior Parameters

  real beta_mu;
  real beta_sigma;

  //Predictive Parameters

  int<lower=0> n_new;
  vector[n_new] X_new;
}

parameters {

  //Model Parameters

  real beta;

}

model {

  //Priors

  beta ~ normal(beta_mu, beta_sigma);

  //Model

  y ~ bernoulli_logit(beta * X);

}

generated quantities {

  //Gather Predictions
  
  vector[n_new] y_new;

  for (i in 1:n_new)
    y_new[i] = bernoulli_rng(inv_logit(beta*X_new[i]));
}
