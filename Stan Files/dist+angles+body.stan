data {
  
  //Model Inputs

  int<lower=0> n;
  int<lower=0> p;
  matrix[n,p] X;
  int<lower = 0, upper = 1> y[n];

  //Prior Parameters

  real beta_mu_dist;
  real beta_sigma_dist;

  real beta_mu_angle;
  real beta_sigma_angle;

  //Predictive Parameters

  int<lower=0> n_new;
  matrix[n_new,p] X_new;

}

parameters {

  //Model Parameters

  vector[p] beta;

}

model {

  //Priors

  beta[2] ~ normal(beta_mu_dist, beta_sigma_dist);

  beta[5] ~ normal(beta_mu_angle, beta_sigma_angle);

  //Model

  y ~ bernoulli_logit(X*beta);

}

generated quantities {

  //Gather Predictions

  vector[n_new] y_new;

  for (i in 1:n_new)
    y_new[i] = bernoulli_rng(inv_logit(X_new[i]*beta));
}


