#ifndef MPC_H
#define MPC_H

#include <vector>
#include "Eigen-3.3/Eigen/Core"

using namespace std;



//int latency_idx = (int) (0.1/dt);

struct optSolution {
    vector<double> x;
    vector<double> y;
    vector<double> delta;
    vector<double> a;
};

class MPC {
public:
    MPC();
    
    virtual ~MPC();
    
    int latency_idx;
    double last_ste;
    double last_acc;
    // Solve the model given an initial state and polynomial coefficients.
    // Return the first actuatotions.
    optSolution Solve(Eigen::VectorXd state, Eigen::VectorXd coeffs);
};

#endif /* MPC_H */
