functions {
   real[] LV(
      real t,
      real[] y,
      real[] theta,
      real[] x_r,
      int[] x_i
   ) {
      real dydt[2];
      dydt[1] <- (theta[1]-theta[3]*y[2])*y[1];
      dydt[2] <- (-theta[2]+theta[4]*y[1])*y[2];
      return dydt;
   }
}

data{
   int<lower=1> T;
   real y_obs[T,2];
   real t0;
   real ts[T];
   real y0[2];
}

transformed data {
   real x_r[0];
   int x_i[0];
}

parameters {
   real<lower=-100, upper=100> alpha;
   real<lower=-100, upper=100> beta;
   real<lower=-100, upper=100> k;
   real<lower=-100, upper=100> l;
   real<lower=0> sigma[2];
}

transformed parameters {
   real y_hat[T,2];
   real theta[4];
   theta[1] <- alpha;
   theta[2] <- beta;
   theta[3] <- k;
   theta[4] <- l;
   y_hat <- integrate_ode(LV, y0, t0, ts, theta, x_r, x_i);
}

model {
//   for(i in 1:2)
//       sigma[i] ~ cauchy(0, 2.5);
       
   for (t in 1:T)
       for(i in 1:2)
         y_obs[t,i] ~ normal(y_hat[t,i], sigma[i]);

}