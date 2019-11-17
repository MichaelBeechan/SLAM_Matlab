%ROBOTDISPLACEMENT Predict global map after a robot displacement.%   G = ROBOTDISPLACEMENT(G,XR,CR,FXR) updates the global map G given%   the predicted 3x1 robot pose XR, its predicted 3x3 covariance %   matrix CR and the 3x3 process model Jacobian linearized around%   the prediction, FXR.%%   The predicted map is returned, with the updated first row and %   column of the map covariance matrix.%%   See also SLAM.% v.1.0, Kai Arras, Nov. 2003, CAS-KTHfunction G = robotdisplacement(G,xr,Cr,Fxr);% Predict mapn = length(get(G,'x'));C = get(G,'c');for i = 2:n,  C(1,i).C = Fxr*C(1,i).C;  C(i,1).C = C(1,i).C';end;G = set(G,'c',C);             % set map state covariance first...% Check on positive definiteness[x,C] = getstate(G);if det(C) < 0,  disp('--> robotdisplacement: cov negative definite!');end;