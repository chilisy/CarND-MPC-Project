---
title: "Reflections"
author: "Liheng Chen"
output: html_document
---

# Reflections of Project 5 - Model Predictive Control

## Model

The model used is a kinematic bicycle model and calculate at each timestamp as follows: 
$$x_{t+1} = x_t + v_t \cos(\psi_t) dt$$
$$y_{t+1} = y_t + v_t \sin(\psi_t) dt$$
$$\psi_{t+1} = \psi_t + \frac{v_t}{L_f} \delta_t dt$$
$$v_{t+1} = v_t + a_t dt $$

where $x$, $y$ represents the position of the car, $\psi$ the heading direction, $v$ the speed. Actuators of the car are the steering angle of the front wheel $\delta_t$, which depends on steering wheel angle and acceleration of the vehicle $a_t$, which depends on brake and gas pedal. $L_f$ is a physical parameter describes the distance between the front wheel axis and center of gravity of the car. 

Also the cross track errors and orientation errors are monitored as states and calculated at update step as follows: 

$$cte_{t+1} = cte_t + v_t \sin(e\psi_t) dt$$
$$e\psi_{t+1} = \psi_t - \psi des_t + v_t \frac{\delta_t}{L_f} dt$$

## Parameters Timestemp Length $N$ and Elapsed Duration $dt$

The parameter timestemp length $N$ and elapsed duration $dt§ determine together the prediction horizon of the model $N \cdot dt$. A longer prediction horizon smoother, a shorter prediction horizon reacts faster. I've chosen $N = 24$ and $dt = 25ms$ for this task, since this seems to balance the reaction time and the smoothiness of the controller. 

## Polynomial Fitting and MPC Preprocessing
Before the solving of MPC optimizer, the waypoints are transformed to car coordinate system with translation and rotation:  
```
next_x_vals[i] = (ptsx[i] - x) * cos(psi) + (ptsy[i] - y) * sin(psi);
next_y_vals[i] = (ptsy[i] - y) * cos(psi) - (ptsx[i] - x) * sin(psi);
```
After transformation, the waypoints are given in car coordinate system, which means the car position can be set to origin $(0,0)$ and orientation also to 0. Using the `polyfit`-function on waypoints, the coefficients are found and cross track error and orientation error could be calculated. The state of the model can be then set to: `state << 0, 0, 0, v, cte, epsi`. 


## Model Predictive Control with Latency
If a latency of 100 ms is simulated and the MPC-controller don't that into account, it will result instable oscilations and the car drives off the track. In order to prevent that, the actuation after the latency should be applied before the latency took place. This is done by using the 4th actuation of the MPC-controller since $dt=25ms$. 

