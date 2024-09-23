close all
load("mean3R.mat")
figure
plot(srednia_nom,'o')
hold on
plot(srednia_cal,'o')
plot(srednia_real,'x','Color',"blue")
axis([0 7 0 10])
grid on
title("Średnie pomiarów dla całej trajektorii modelu 3R")
xlabel("Numer pomiaru")
ylabel("Średni błąd [mm]")
legend("Model nominalny","Model skalibrowany","Model rzeczywisty")
