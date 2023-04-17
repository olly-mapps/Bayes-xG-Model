data {
  
  //Model Inputs

  int<lower=0> n;

  int<lower=0> p;

  int<lower=0> players; 

  int<lower=0, upper = players> player[n];

  matrix[n,p] X;

  int<lower = 0, upper = 1> y[n];

  //Hyper-Prior Parameters

  real alpha_mu_mu;
  real alpha_mu_sigma;

  real angle_beta_sigma_rate;
  real dist_beta_sigma_rate;
  real alpha_sigma_rate;

  real dist_beta_mu_mu;
  real dist_beta_mu_sigma;

  real angle_beta_mu_mu;
  real angle_beta_mu_sigma;


  //Predictive Parameters

  int<lower=0> n_new;
  matrix[n_new,p] X_new;

}

parameters {

  //Model Parameters

  vector[players] dist_beta;

  vector[players] angle_beta;

  vector[players] body_beta;

  vector[players] alpha;

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

  y ~ bernoulli_logit(alpha[player] + X .* (dist_beta[player] + angle_beta[player] + body_beta[player]);

  //Priors

  dist_beta ~ normal(dist_beta_mu, dist_beta_sigma);

  angle_beta ~ normal(angle_beta_mu, angle_beta_sigma);

  alpha ~ normal(alpha_mu, alpha_sigma);

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

  real salah_y_new;

  salah_y_new = inv_logit(alpha[35] + X_new[8].*beta[35]);

  real alpha_pp = normal_rng(alpha_mu, alpha_sigma);
  real beta_pp = normal_rng(beta_mu, beta_sigma);

  real pp_y_new = inv_logit(alpha_pp + X_new[8]*beta_pp); 



}
