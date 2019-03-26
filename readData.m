dset_dir = '/afs/inf.ed.ac.uk/group/teaching/inf2b/cwk2/d/s1703935/';
[Xtrn, Ytrn, Xtst, Ytst] = load_my_data_set(dset_dir);
Xtrn = double(Xtrn)/255.0;