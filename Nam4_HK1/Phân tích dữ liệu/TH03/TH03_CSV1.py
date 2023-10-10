import pandas as pd
import matplotlib.pyplot as plt
from sklearn import linear_model as lnm

# Sử dụng thư viện pandas để lấy dữ liệu từ file CSV.
businessOperationSurvey = pd.read_csv('./Dataset/business-operations-survey-2022-information-and-communications-technology.csv', encoding="ISO-8859-1") 

# ===========================================================
# Xử lí tiền dữ liệu: 
temp_bos = businessOperationSurvey.copy() # Tạo một bản sao 
for i in temp_bos.index:
    if temp_bos.loc[i, 'value'] <= 100:
        temp_bos.drop(i, inplace = True)
temp_bos = temp_bos.dropna(subset=['level'])

dataFrame = temp_bos.copy().reset_index()
# ===========================================================
#Hồi quy tuyến tính
#khởi tạo mô hình hồi quy tuyến tính
linearModel = lnm.LinearRegression()

#Biến độc lập
bdl = dataFrame[['value']]

#Biến phụ thuộc
bpt = dataFrame['level']

#Huấn luyện mô hình trên dữ liệu
linearModel.fit(bdl, bpt)

#Hệ số hồi quy
hshq = linearModel.coef_
print('Hệ số hồi quy:', hshq)

#Sai số
ss = linearModel.intercept_
print('Sai số:', ss)

#Dự đoán value của level trên mô hình hồi quy tuyến tính
print(linearModel.predict([[24515]]))

# ===========================================================
#Vẽ đồ thị
plt.scatter(dataFrame['value'], dataFrame['level'], color='green', label='Dữ liệu thực tế')
plt.plot(dataFrame['value'], hshq*dataFrame['level']+ss, color='red', label='Đường hồi quy')
plt.xlabel('Value')
plt.ylabel('Level')
plt.title('Value and Level')
plt.legend()
plt.show()