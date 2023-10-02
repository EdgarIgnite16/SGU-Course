import pandas as pd
import matplotlib.pyplot as plt1
import matplotlib.pyplot as plt2

# Sử dụng thư viện pandas để lấy dữ liệu từ file CSV.
businessOperationSurvey = pd.read_csv('./Dataset/business-operations-survey-2022-information-and-communications-technology.csv', encoding="ISO-8859-1") 
environmentTaxAccount = pd.read_csv('./Dataset/environmental-tax-account-1999-2021.csv', encoding="ISO-8859-1") 

# ===========================================================
# Business Operation Survey
# Xử lí tiền dữ liệu: 
# Chỉ lấy những dữ liệu có value > 100
temp_bos = businessOperationSurvey.copy() # Tạo một bản sao 
for i in temp_bos.index:
    if temp_bos.loc[i, 'value'] <= 100:
        temp_bos.drop(i, inplace = True)

# # in ra kết quả để đối chiếu
print(temp_bos)
print(businessOperationSurvey)

# Environment Tax Account
# Xử lí tiền dữ liệu
    # Lọc dữ liệu: loại bỏ các bộ có giá trị rỗng của cột data_value
    # Xử lí dữ liệu thiếu: các bộ có dữ liệu NaN sẽ được thay thế bằng giá trị "None"

temp_eta = environmentTaxAccount.copy()
temp_eta = temp_eta.dropna(subset=['data_value'])
temp_eta = temp_eta.fillna("None")

print(environmentTaxAccount)
print(temp_eta)

# ===========================================================
# Hình ảnh trực quan hóa
# Business Operation Survey
# Trực quan hóa dữ liệu Business operations survey 2022: information and communications technology đã được tiền xử lí thông qua cột level và value (lấy 20 dòng đầu)
plt1.bar((temp_bos['level'].head(20)).astype(str), (temp_bos['value'].head(20)).astype(str))
plt1.title("level và value")
plt1.xlabel("level")
plt1.ylabel("value")
plt1.show()

# Environment Tax Account
# Trực quan hóa dữ liệu Environmental tax account 1999-2021 thông qua cột National_accounts_var và data_value (lấy 5 dòng đầu)
plt2.bar((temp_eta['National_accounts_var'].head(5)).astype(str), (temp_eta['data_value'].head(5)).astype(str))
plt2.title("National_accounts_var và data_value")
plt2.xlabel("National_accounts_var")
plt2.ylabel("data_value")
plt2.show()