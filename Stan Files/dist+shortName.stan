data {
  
  //Model Inputs

  int<lower=0> n;
  int<lower=0> p; 

  int<lower=0> player[n];

  vector[n] X;

  int<lower = 0, upper = 1> y[n];

  //Prior Parameters

  real beta_mu;
  real beta_sigma;

  //Hyper-Prior Parameters

  real beta_mu_mu;
  real beta_mu_sigma;

  real beta_sigma_rate;

  //Predictive Parameters

  int<lower=0> n_new;
  matrix[n_new,p] X_new;

}

parameters {

  //Model Parameters

  vector[p] beta;

}

model {

  //Model

  y ~ bernoulli_logit(X .* beta[player]);

  //Priors

  beta ~ normal(beta_mu, beta_sigma);

  //Hyper-Priors

  beta_mu ~ normal(beta_mu_mu, beta_mu_sigma);

  beta_sigma ~ exponential(beta_sigma_rate);
}

generated quantities {

  //Gather Predictions

  vector[n_new] y_new;

  for (i in 1:n_new)
    y_new[i] = bernoulli_rng(inv_logit(X_new[i]*beta));
}
