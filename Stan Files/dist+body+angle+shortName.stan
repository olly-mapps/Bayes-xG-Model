data {
  
  //Model Inputs

  int<lower=0> n;
  int<lower=0> pred;
  int<lower=0> players; 

  int<lower=0, upper = players> player[n];

  matrix[n,pred] X;

  int<lower = 0, upper = 1> y[n];

  //Hyper-Prior Parameters

  real dist_beta_mu_mu;
  real dist_beta_mu_sigma;
  
  real angle_beta_mu_mu;
  real angle_beta_mu_sigma;

  real alpha_mu_mu;
  real alpha_mu_sigma;

  real dist_beta_sigma_rate;
  real angle_beta_sigma_rate;
  real alpha_sigma_rate;

  //Predictive Parameters

  int<lower=0> n_new;
  matrix[n_new,pred] X_new;

}

parameters {

  //Model Parameters

  vector[pred] beta[players];

  //Prior Parameters

  real dist_beta_mu;
  real <lower = 0> dist_beta_sigma;

  real angle_beta_mu;
  real <lower = 0> angle_beta_sigma;

  real alpha_mu;
  real <lower = 0> alpha_sigma;

}

model {

  //Model

  for (i in 1:n){
    y[i] ~ bernoulli_logit(X[i] * beta[player[i]]);
  }

  //Priors

  beta[2] ~ normal(dist_beta_mu, dist_beta_sigma);

  beta[5] ~ normal(angle_beta_mu, angle_beta_sigma);

  beta[1] ~ normal(alpha_mu, alpha_sigma);

  //Hyper-Priors

  dist_beta_mu ~ normal(dist_beta_mu_mu, dist_beta_mu_sigma);

  dist_beta_sigma ~ exponential(dist_beta_sigma_rate);

  angle_beta_mu ~ normal(angle_beta_mu_mu, angle_beta_mu_sigma);

  angle_beta_sigma ~ exponential(angle_beta_sigma_rate);

  alpha_mu ~ normal(alpha_mu_mu, alpha_mu_sigma);

  alpha_sigma ~ exponential(alpha_sigma_rate);
}

generated quantities {

  //Gather Predictions

  //real salah_y_new;

  //salah_y_new = inv_logit(X_new[8].*beta[35]);

  //real beta_pp = normal_rng(beta_mu, beta_sigma);

  //real pp_y_new = inv_logit(X_new[8]*beta_pp); 



}
