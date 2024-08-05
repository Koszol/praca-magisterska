function [randVector] = randVal(mean,std_deviation,size)
    randVector=std_deviation.*randn(size,1)+mean;
end

