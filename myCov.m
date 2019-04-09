function cov = myCov(m, mu)
    mShift = m - mu;
    cov = (mShift'*mShift)/(size(m,1));
end