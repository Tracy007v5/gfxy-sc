clc;clear;
load train_mbhySDV;
train_mbhySDV = sparse(train_mbhySDV);
load train_labels;
model = train(train_labels,train_mbhySDV);
load test_mbhySDV;
test_mbhySDV = sparse(test_mbhySDV);
load test_labels;
[predicted_label,accuracy,decision_values] = predict(test_labels,test_mbhySDV,model);