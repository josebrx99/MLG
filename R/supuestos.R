supuestos = function(model, col) {
  # Normalidad
  library(MASS); library(lmtest)

  resid <- studres(model)
  jpeg("normalidad.jpg", width = 1400, height = 800)
  par(mfrow=c(1, 3))
  hist(resid, col = col, freq = F)
  lines(density(resid))
  car::qqPlot(model,xlab='cuantiles teóricos',ylab='residuos estudentizados',
              distribution = 'norm', pch = 19, main = "QQ-plot", col.lines = "red")

  boxplot(resid, main = "Boxplot", col = col)
  dev.off()


  # Homocedasticidad
  jpeg("homocedasticidad.jpg", width = 1400, height = 800)
  par(mfrow=c(1,2))

  # Residuos estudientizados
  plot(model$fitted.values, studres(model), ylab='residuos estudentizados',
       xlab='valores ajustados', main='valores ajustados vs residuos estudentizados', pch = 19, col = col)
  abline(h=0,lty=2)
  lines(lowess(studres(model) ~ model$fitted.values), col = col)


  plot(model$fitted.values, abs(studres(model)), ylab='valor absoluto residuos estudentizados',
       xlab='valores ajustados',main='valores ajustados vs valor absoluto residuos estudentizados', pch = 19, col = col)
  abline(h=0,lty=2)
  lines(lowess(abs(studres(model)) ~ model$fitted.values), col = "black")
  dev.off()


  # Correlacion de los residuos
  jpeg("correlacion.jpg", width = 1400, height = 800)
  par(mfrow=c(1,2))
  res.stud <- studres(model)
  randtests::runs.test(model$residuals)

  res.resagados <- res.stud[-1]
  res.stud <- res.stud[-length(res.stud)]

  plot(res.resagados, res.stud, main = "residuos estudentizados vs residuos estudentizados resagados" ,
       xlab = "t-1", ylab = "t", pch = 19, col = col)
  abline(lm(res.stud ~ res.resagados), col = "black", lty=2)

  plot(res.stud, main = "residuos estudentizados vs tiempo", xlab = "Tiempo", type = "o",
       pch = 19, col = col)
  abline(h = 0, col = "black", lty=2)
  dev.off()


  test = list(shapiro.test(resid),
              t.test(resid),
              bptest(model),
              dwtest(model, alternative = "two.sided", data = banksalary))
  return(test)
}
