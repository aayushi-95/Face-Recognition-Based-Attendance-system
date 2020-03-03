# Face-Recognition-Based-Attendance-system

Face Recognition: Biometric method. Is a form of Identity Access Management and Access Control. It will detect and identify a person from a group comparing facial features using Viola Jones Alogorithm. 

![](https://github.com/aayushi-95/Face-Recognition-Based-Attendance-system/blob/master/readme/database%20workflow.PNG)

When the camera takes pictures of all students, the image is trasformed for detection and recognition. It is cropped by a predefined size (after locating face from body) and converted to graycale and then equalized using histogram technique. 

Using Eigen feature Extraction these faces are stored in a database. Our model is trained on this database which we then test it with a query image and check the detection success rate.

![](https://github.com/aayushi-95/Face-Recognition-Based-Attendance-system/blob/master/readme/Capture.PNG)

## Architecture

Camera Orientation as a challenge was overcome by rotating the image until a face gets deteced.
False deetction was reduced by using hysteresis thresholding. 
The most challenging part of face recognition using Eigenface is the changes in background, illunimation, varying skintones (which can be overcome by YCbCr or HSV Filters), scale sensitivity, oculence which decreases the efficiency of the face. Upgrades can be done to PCA based Eigenface method.

![](https://github.com/aayushi-95/Face-Recognition-Based-Attendance-system/blob/master/readme/flowchart.PNG)
