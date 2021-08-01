### Helm chart dependency utility

This repo was created to showcase a way to express and highlight application charts's dependencies on K8s resources that are outside its own chart. 
I also wrote an [article explaning this](https://sitaram.substack.com/p/a-helm-chart-trick-for-dependency).

- We have two charts. One is a application chart which has an external dependency `redis-config` ConfigMap and `redis-cred` Secret from `redis-ns` namespace. We **express** it in the `values.yml` of Service A helm chart.          
- Then we **highlight** these dependecies in `Notes.txt` of Servie A. This file is printed to the console after `helm install/upgrade`
- We use a common utility which comes from the `common-lib` chart which is a library chart.