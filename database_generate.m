clear; clc;

%Database of 21 images
my_db=imageSet('database');
img_size=150;

%Using Viola jones Algorithm for face detection 
facedetect=vision.CascadeObjectDetector('FrontalFaceCART','MinSize',[100,100],'MergeThreshold',4);
tally=zeros(img_size,img_size,3,1000);
a=zeros(1,4);

%Detecting number of faces present in an image
for i=1:my_db.Count
    crop=read(my_db,i);
  tally = countFaces(crop,facedetect);
end
tally(:,:,:,~any(tally,[1,2,3]))=[];