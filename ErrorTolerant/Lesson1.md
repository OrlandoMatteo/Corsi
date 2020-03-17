# Error Tolerant Application

## Power and Engergy in IoT

Once just improving the fabrication technology was fine to reduce the needed power but nowadays the cost to produce and design always smaller devices in esponentially increasing with the reduction of the size. Voltage scaling pratically stopped due to the tradeoff between mos delay and leakage current. The power is not scaling anymore and thus the power density is increasing and classic low power techniques are not enough. Parallelism is one of the two major ways to reduce power consumption but increase the area of the cicuit.
To avoid the binary tradeoff between area and power we need to accept possible error in the computation. SOme moder application are **Error Resilient** so the output quality perceived by the user is not affected by *small* or *occasional* error in computation. An *error* is a violation of the precision,accuracy or reliability requirements. This could be the only way to achieve the objective of IoT with the end of technology/voltage scaling.

## Error Tolerant Computing

Error is considered a dimension in the space of design at **all** levels of hierarchy from device to application. In general the output quality can be measuread as a continuos function of the accuracy. Error tolerance can have different source source:

- Noisy inputs: Application that process data coming from sensor that tamples physical quantities. Error can be tolerated if it is negligible.
- Redundant inputs: Application that process and aggregate redundant data. Error can be tolerated as long as they're rare.
- Golden Outputs: Application were the optimal result is too hard to compute anyway or multiple outputs are equivalent. Error can be tolerated as long as they don't affect the ouput dramatically.
- Output meant to be used by human: human have limited preceptual capabilities. Error can be tolerated as long as they're small or rare.
- Statistical algorithms: error can cancel themself or reduce.

## How to measure the quality?
There are many ways to measure errors, the two mains are **Error Rate** and **Error significance**. Most output quality metrics are a combination of rate and significance information.

## How to insert errors?
 
- Reduce the precision on computation
- Reduce design margin not taking into account worst case operation
- REduce redundancy and apply it only to the MSB's 
- Relaxing sinchronization
- Operate on probabilities rather than values

## Error Tolerant system
We always need to identify wich aprt of the application are error tolerant same for our workloads. Slide 41

### Error Tolerant Identification/Charachterization

To move the froma low level measure of error to an application level measure of output quality? There a re 2 possible ways: *Simulation* or *Formal/statistical* method
Quality monitoring need to cope with time dependen natur of error tolernace. Knobs control are used to measure quality and the usage contecxt to tune the know of error tolerant SW/HW

