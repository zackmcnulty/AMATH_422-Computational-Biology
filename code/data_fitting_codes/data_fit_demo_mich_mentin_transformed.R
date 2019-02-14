  # change this to your directory
EggRatioData <- read.table("/home/apewu/teaching/AMATH410/lectMar9/EggRatioData.dat")

xlist <- EggRatioData[,1]
ylist <- EggRatioData[,2]

# we want to do a least squares fit
V_initial_guess <- 1
K_initial_guess <- 1
p0 <- c(V_initial_guess, K_initial_guess)

p_fit <- nls(sqrt(ylist) ~ sqrt(V*xlist / (K+xlist)), 
             start = list(V = V_initial_guess, K = K_initial_guess))

plot(xlist, sqrt(ylist))
newdata <- seq(min(xlist), max(xlist), length = 1000)
lines(newdata, predict(p_fit, list(xlist = newdata)), col = "red", lwd = 2)

residual_list <- residuals(p_fit)

par(mfrow = c(2,1))
resid.hist <- hist(residual_list, breaks = 30, plot = F)
plot(resid.hist$mids, resid.hist$counts, type = "h", lwd = 5,
     main = "Hist of Resids")
plot(resid.hist$mids, log(resid.hist$counts), type = "h", lwd = 5,
     main = "Log Hist of Resids")

