data {
  
  //Model Inputs

  int<lower=0> n;
  int<lower=0> players; 

  int<lower=0, upper = players> player[n];

  vector[n] X;

  int<lower = 0, upper = 1> y[n];

  //Hyper-Prior Parameters

  real beta_mu_mu;
  real beta_mu_sigma;

  //real alpha_mu_mu;
  //real alpha_mu_sigma;

  real beta_sigma_rate;
  //real alpha_sigma_rate;

  //Predictive Parameters

  int<lower=0> n_new;
  vector[n_new] X_new;

}

parameters {

  //Model Parameters

  vector[players] beta;

  real alpha;

  //Prior Parameters

  real beta_mu;
  real <lower = 0> beta_sigma;

  //real alpha_mu;
  //real <lower = 0> alpha_sigma;

}

model {

  //Model

  y ~ bernoulli_logit(alpha + X .* beta[player]);

  //Priors

  beta ~ normal(beta_mu, beta_sigma);

  //alpha ~ normal(alpha_mu, alpha_sigma);

  //Hyper-Priors

  beta_mu ~ normal(beta_mu_mu, beta_mu_sigma);

  beta_sigma ~ exponential(beta_sigma_rate);

  //alpha_mu ~ normal(alpha_mu_mu, alpha_mu_sigma);

  //alpha_sigma ~ exponential(alpha_sigma_rate);
}

generated quantities {

  //Gather Predictions

  real salah_y_new;

  salah_y_new = inv_logit(alpha + X_new[8].*beta[35]);

  //real alpha_pp = normal_rng(alpha_mu, alpha_sigma);
  real beta_pp = normal_rng(beta_mu, beta_sigma);

  real pp_y_new = inv_logit(alpha + X_new[8]*beta_pp); 



}

