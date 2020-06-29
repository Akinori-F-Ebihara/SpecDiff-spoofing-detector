# SpecDiff-spoofing-detector
This repository contains an example code that calculates the SpecDiff descriptor proposed in "Specular- and Diffuse-reflection-based Face Spoofing Detection for Mobile Devices" to perform face spoofing detection. The SpecDiff descriptor utilizes specular and diffuse reflection of a facial image, enables fast-and-accurate spoofing detection without either a large training database or a high-performance computing system.

## Tested computing environment
- MATLAB R2017b

## Tutorial of the example code
Run the main script, 'SpecDiff_main.m'. The script loads a pair of example photos, taken with and without flash, to compute the SpecDiff descriptor. The descriptor is classified to one of the two classes, live or spoof, by the Support Vector Machine (SVM) with a Radial Basis Function (RBF) kernel. Positive and negative value of classification scores indicate live and spoof class, respectively.

___Result Plot___

<img src ="./SpecDiff_result.png" width=75%>

## Files and directories
- SpecDiff_main.m
The main script applies preprocessing to example photo pairs, and classify them into either live or spoof class.

## Citation
___Please cite our paper if you use the whole or a part of our codes.___
```

@INPROCEEDINGS{SpecDiff,
  author    = {Akinori F. Ebihara and
               Kazuyuki Sakurai and
               Hitoshi Imaoka},
  booktitle={2020 IEEE International Joint Conference on Biometrics (IJCB)}, 
   title     = {Specular- and Diffuse-reflection-based Face Liveness Detection for
               Mobile Devices},
  year={2020}
  }

```
