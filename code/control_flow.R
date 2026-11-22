a <- TRUE
if (a) {
  paste(a, "is true")
} else {
  paste(a, "is False")
}
getwd()

z <- runif(1)
if (z <= 0.5) {
  print("less than a half")
} else {
  print("more than a half")
}
print(z)

for (i in 1:10) {
  j <- i * i
  print(paste(i, "squared is", j))
}

for (species in c("Heliodoxa rubinoides",
                  "Boissonneaua jardini",
                  "Sula nibouxii")) {
  print(paste("The species is", species))
}

v1 <- c("a", "bc", "def")
for (i in v1) {
  print(i)
}

i <- 0
while (i < 10) {
  i <- i + 1
  print(i^2)
}
