N = 1000;
W = randn(N);

E = eig(W);
plot(real(E), imag(E), '.');