data {
  
  //Model Inputs

  int<lower=0> n;
  int<lower=0> p;
  matrix[n,p] X;
  int<lower = 0, upper = 1> y[n];

  //Prior Parameters

  real beta_mu_1;
  real beta_sigma_1;

  real beta_mu_2;
  real beta_sigma_2;

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

  beta[1] ~ normal(beta_mu_1, beta_sigma_1);

  beta[2] ~ normal(beta_mu_2, beta_sigma_2);

  //Model

  y ~ bernoulli_logit(X*beta);

}

generated quantities {

  //Gather Predictions

  vector[n_new] y_new;

  for (i in 1:n_new)
    y_new[i] = bernoulli_rng(inv_logit(X_new[i]*beta));
}


