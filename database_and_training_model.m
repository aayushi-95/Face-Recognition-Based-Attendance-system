clear all; clc

%Cal Histogram of gradient for Object detection 
my_db=imageSet('database', 'recursive'); 
hog=zeros(1000,46656);
people=size(my_db,2);
image_features=0;

for i=1:people
    people=my_db(i).Count;
    for j = 1:people
        image_features=image_features+1;
        hog(image_features,:) = extractHOGFeatures(read(my_db(i),j),'CellSize',[4 4]);
        %Model Description
        desc{image_features} = my_db(i).Description;    
    end
end
hog(~any(hog,2),:)=[];

%Fit for SVM classifier
training_model = fitcecoc(hog,desc);