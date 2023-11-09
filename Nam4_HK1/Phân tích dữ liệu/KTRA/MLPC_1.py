from sklearn.datasets import load_digits
from sklearn.neural_network import MLPClassifier
import pickle

# Load têp dü liêu digits
digits = load_digits()

# Xác định các features và labels
X = digits.data
y = digits.target

# Khởi tao và huán luyên mô hình MLPClassifier
model = MLPClassifier(hidden_layer_sizes=(100,100), activation='logistic', max_iter=500)
model.fit(X, y)

# Luu trong sô xuóng file
with open('model_ismax.pkl', 'wb') as file:
    pickle.dump(model, file)