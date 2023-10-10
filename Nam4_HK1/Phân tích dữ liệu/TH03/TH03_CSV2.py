import pandas as pd
import matplotlib.pyplot as plt
from sklearn import linear_model as lnm

# Sử dụng thư viện pandas để lấy dữ liệu từ file CSV.
environmentTaxAccount = pd.read_csv('./Dataset/environmental-tax-account-1999-2021.csv', encoding="ISO-8859-1")

# ===========================================================
# Environment Tax Account
# Xử lí tiền dữ liệu
# Environmental Accounts = 1
# National Accounts = 2
temp_eta = environmentTaxAccount.copy()
temp_eta = temp_eta.dropna(subset=['data_value'])
temp_eta = temp_eta.fillna("None")
temp_eta['source'] = temp_eta['source'].replace(['Environmental Accounts'], 1)
temp_eta['source'] = temp_eta['source'].replace(['National Accounts'], 2)

dataFrame = temp_eta.copy().reset_index()
# ===========================================================
#Hồi quy tuyến tính
#khởi tạo mô hình hồi quy tuyến tính
linearModel = lnm.LinearRegression()

#Biến độc lập
bdl = dataFrame[['data_value']]

#Biến phụ thuộc
bpt = dataFrame['source']

#Huấn luyện mô hình trên dữ liệu
linearModel.fit(bdl, bpt)

#Hệ số hồi quy
hshq = linearModel.coef_
print('Hệ số hồi quy:', hshq)

#Sai số
ss = linearModel.intercept_
print('Sai số:', ss)

#Dự đoán data_value của source trên mô hình hồi quy tuyến tính
print(linearModel.predict([[24515]]))

# ===========================================================
#Vẽ đồ thị
plt.scatter(dataFrame['data_value'], dataFrame['source'], color='green', label='Dữ liệu thực tế')
plt.plot(dataFrame['data_value'], hshq*dataFrame['data_value']+ss, color='red', label='Đường hồi quy')
plt.xlabel('Data Value')
plt.ylabel('Source')
plt.title('Data Value and Source')
plt.legend()
plt.show()