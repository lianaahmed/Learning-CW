%dset_dir = '/afs/inf.ed.ac.uk/group/teaching/inf2b/cwk2/d/s1703935/';
dset_dir = 'C:\Users\Liana\Desktop\Uni\Second Year\Semester 2\INF2B\Assignment 2';
[Xtrn, Ytrn, Xtst, Ytst] = load_my_data_set(dset_dir);
Xtrn = double(Xtrn)/255.0;
Ytrn = double(Ytrn);
Xtst = double(Xtst)/255.0;
Ytst = double(Ytst);