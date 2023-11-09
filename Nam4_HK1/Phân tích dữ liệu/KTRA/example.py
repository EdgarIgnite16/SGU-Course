from sklearn.datasets import load_iris
from sklearn.neural_network import MLPClassifier
from sklearn.model_selection import train_test_split

# Load dữ liệu iris
iris = load_iris() 
x = iris.data
y = iris.target

# Chia tập dữ liệu thành tập huấn luyện và tập kiểm tra 
x_train, x_test, y_train, y_test = train_test_split(x, y, test_size=0.2, random_state=42)

# Xây dựng mạng neural 
model = MLPClassifier(hidden_layer_sizes=(100,50), activation='tanh', solver='adam', max_iter=500)

# Huấn luyện mô hình 
model.fit(x_train, y_train)

# Đánh giả mô hình trên tập kiếm tra 
accuracy = model.score(x_test, y_test) 
print("Accuracy:", accuracy)