import os
import pandas as pd
import numpy as np
import inspect

pd.options.display.max_columns = None
files = os.listdir(r'../../forPreparation/rawdata/rawdata/')
allfiles = {}
for element in files:
    allfiles[element[:-4]] = pd.read_csv(r'../../forPreparation/rawdata/rawdata/' + element, encoding='utf-8')
allfiles.keys()

###################
### preparation ###
###################

def retrieveName(var):
    for fi in reversed(inspect.stack()):
        names = [var_name for var_name, var_val in fi.frame.f_locals.items() if var_val is var]
        if len(names) > 0:
            return names[0]

def createDataFrame(table_name):
    columnlist = pd.read_excel(r'../forPreparation/TrueExcelData_r/TrueExcelData/'+ table_name+'.xlsx').columns
    newDataFrame = pd.DataFrame(columns = columnlist)
    return newDataFrame

def addRow(row, df):
    columnlist = df.columns
    df.append(pd.DataFrame([row], columns = columnlist), ignore_index=True)
    return df

#########################################
### convert pd.DataFrame to SQL files ###
#########################################

class DfToSqlFile:
    def __init__(self, df):
        self.df = df
        self.df_shape = df.shape
    def generate_and_prepare_table_values(self):
        values = ''
        for i in range(self.df_shape[0]):
            oneUnit = ''
            for j in range(self.df_shape[1]):
                rowdata = str(self.df.iloc[i, j])
                if rowdata == 'NULL':
                    oneUnit = oneUnit + " NULL,"
                else:
                    oneUnit = oneUnit + " '" + rowdata + "',"
            oneUnit = '(' + oneUnit[1:-1] + '),'
            values = values + oneUnit
        return values[:-1]
    def create_sql(self, table_name):        
        return 'INSERT INTO ' + table_name + ' VALUES' + self.generate_and_prepare_table_values() 
    def writeToSqlFile(self, table_name):
        file_dict = r"../forPreparation/TrueExcelData/oldData/"+ str(i) + '.' + table_name +'.sql'
        with open(file_dict, 'w', encoding="utf-8") as text_file:
            text_file.write(self.create_sql(table_name))

##################
### manipulate ###
##################

class WriteToCouponCode:
    
    def __init__(self, allfiles):
        self.df_raw_date = allfiles['coupons']
        self.df_CouponCode = createDataFrame('CouponCode')
        
    def clear_row_data(self, coupon_amount_max_length = 5):
        filter_condition = []
        for c_id, coupon_amount in zip(self.df_raw_date['c_id'], self.df_raw_date['c_info']):
            if len(coupon_amount) < coupon_amount_max_length:
                filter_condition.append(c_id)
        return self.df_raw_date[self.df_raw_date['c_id'].isin(filter_condition)][['c_code', 'c_info', 'c_name']]
        
    def writeTo_CouponCode(self):
        df_cleared_date = self.clear_row_data()
        for row_number in range(df_cleared_date.shape[0]):
            row = [row_number+1, df_cleared_date.iloc[row_number, 0], df_cleared_date.iloc[row_number, 1], 'N', 'NULL', df_cleared_date.iloc[row_number, 2]]
            addRow(row, self.df_CouponCode)
        return self.df_CouponCode
    
    def df_to_sql_file(self):
        df_sql = DfToSqlFile(self.writeTo_CouponCode)
        df_sql.writeToSqlFile('CouponCode')
                