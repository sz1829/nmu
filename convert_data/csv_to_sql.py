import os
import pandas as pd
import numpy as np
import inspect
pd.options.display.max_columns = None
files = os.listdir(r'../forPreparation/rawdata/rawdata/')
allfiles = {}
for element in files:
    allfiles[element[:-4]] = pd.read_csv(r'../forPreparation/rawdata/rawdata/' + element, encoding='utf-8')
# allfiles.keys()

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
    df = df.append(pd.DataFrame([row], columns =  df.columns), ignore_index=True)
    return df
#########################################
### convert pd.DataFrame to SQL files ###
#########################################

class DfToSqlFile:
    def __init__(self, df):
        self.df = df
    def generate_and_prepare_table_values(self):
        values = ''
        for i in range(self.df.shape[0]):
            oneUnit = ''
            for j in range(self.df.shape[1]):
                rowdata = str(self.df.iloc[i, j])
                if rowdata == 'NULL':
                    oneUnit = oneUnit + " NULL,"
                else:
                    oneUnit = oneUnit + " \"" + rowdata + "\","
            oneUnit = '(' + oneUnit[1:-1] + '),'
            values = values + oneUnit
        return values[:-1]
    def create_sql(self, table_name):        
        return 'INSERT INTO ' + table_name + ' VALUES' + self.generate_and_prepare_table_values() 
    def writeToSqlFile(self, table_name):
        file_dict = r"../forPreparation/TrueExcelData/oldData/" + table_name +'.sql'
        with open(file_dict, 'w', encoding="utf-8") as text_file:
            text_file.write(self.create_sql(table_name))


##################
### manipulate ###
##################

class WriteToCouponCode:
    def __init__(self, allfiles):
        self.df_raw_data = allfiles['coupons']
        self.df_CouponCode = createDataFrame('CouponCode')
    def clear_row_data(self, coupon_amount_max_length = 5):
        filter_condition = []
        for c_id, coupon_amount in zip(self.df_raw_data['c_id'], self.df_raw_data['c_info']):
            if len(coupon_amount) < coupon_amount_max_length:
                filter_condition.append(c_id)
        return self.df_raw_data[self.df_raw_data['c_id'].isin(filter_condition)][['c_code', 'c_info', 'c_name']]    
    def writeTo_CouponCode(self):
        df_cleared_data = self.clear_row_data()
        for row_number in range(df_cleared_data.shape[0]):
            row = [row_number+1, df_cleared_data.iloc[row_number, 0], df_cleared_data.iloc[row_number, 1], 'N', 'NULL', df_cleared_data.iloc[row_number, 2]]
            self.df_CouponCode = addRow(row, self.df_CouponCode)
        return self.df_CouponCode
    def df_to_sql_file(self):
        df_sql = DfToSqlFile(self.writeTo_CouponCode())
        df_sql.writeToSqlFile('CouponCode')
                
class WriteToQuestionBoard:
    def __init__(self, allfiles):
        self.df_raw_data = allfiles['question']
        self.df_QuestionBoard = createDataFrame('QuestionBoard')
    def writeTo_QuestionBoard(self):
        self.df_raw_data = pd.DataFrame.dropna(self.df_raw_data)
        for row_number in range(self.df_raw_data.shape[0]):
            row = [row_number+1, self.df_raw_data.iloc[row_number, 1], self.df_raw_data.iloc[row_number, 3], 'NULL', self.df_raw_data.iloc[row_number, 5], self.df_raw_data.iloc[row_number, 7], 'solved', 'airticket']
            self.df_QuestionBoard = addRow(row, self.df_QuestionBoard)
        return self.df_QuestionBoard
    def df_to_sql_file(self):
        df_sql = DfToSqlFile(self.writeTo_QuestionBoard())
        df_sql.writeToSqlFile('QuestionBoard')

class WriteToCustomerSource:
    def __init__(self, allfiles):
        self.df_raw_data = allfiles['source1']
        self.df_CustomerSource = createDataFrame('CustomerSource')
    def writeTo_CustomerSource(self):
        self.df_raw_data = pd.DataFrame.dropna(self.df_raw_data)
        for row_number in range(self.df_raw_data.shape[0]):
            row = [row_number+1, self.df_raw_data.iloc[row_number, 1]]
            self.df_CustomerSource = addRow(row, self.df_CustomerSource)
        return self.df_CustomerSource
    def df_to_sql_file(self):
        df_sql = DfToSqlFile(self.writeTo_CustomerSource())
        df_sql.writeToSqlFile('CustomerSource')
        
class WriteToUserAccount:
    def __init__(self, allfiles):
        self.df_raw_data = allfiles['users']
        self.df_UserAccount = createDataFrame('UserAccount')
    def writeTo_UserAccount(self):
        for row_number in range(self.df_raw_data.shape[0]):
            row = [self.df_raw_data.iloc[row_number, 0], self.df_raw_data.iloc[row_number, 1], self.df_raw_data.iloc[row_number, 2], 1]
            self.df_UserAccount = addRow(row, self.df_UserAccount)
        return self.df_UserAccount
    def df_to_sql_file(self):
        df_sql = DfToSqlFile(self.writeTo_UserAccount())
        df_sql.writeToSqlFile('UserAccount')

        
# class WriteToAirTicketTour:
#     def __init__(self, allfiles):
#         self.df_raw_data = allfiles['ticket']
#         self.df_raw_data_with_ = self.df_raw_data[self.df_raw_data['t_user_id'].isin(allfiles['users']['user_id'])]
#         self.df_AirticketTour = createDataFrame('AirticketTour')
#         self.df_Transactions = createDataFrame('Transactions')
#         self.
#         #同时插入顾客那个表
        
#     def clear_row_data(self):
#         self.df_raw_data.dropna(how='any', subset=['t_baseprice', 't_quotedprice', 't_margin', 't_locator', 't_count', 't_user_id'], inplace=True)
