THE PROBLEM:

Business Challenge:  Loan Applications Approval
 
Financial fraud or bank fraud is the use of illegal or illicit means to obtain money, assets, or other property owned or held by a financial institution, or to obtain money from depositors. There is a wide variety of financial and bank fraud where predictive analytic is widely used such as on-line banking, internet credit card payment and rogue trading.
 
A loan application form seeks a lot of information about the applicant. Such data can be used to predict which customers are most likely to turn up as fraudulent. The customers who have been predicted to have a high probability to default are then declined the loan. The goal is to use historical data to build a model that could help the bank officer to decide whether or not to approve a loan request based on the information submitted by the applicant.
 
When a bank receives a loan application, based on the applicant’s profile the bank has to make a decision regarding whether to go ahead with the loan approval or not. Two types of risks are associated with the approver’s decision:
•	If the applicant will indeed repay the loan, then not approving the loan to the person results in a loss of business to the bank related to the interest rate received by the bank 
•	If the applicant is not going to repay the debt, then approving the loan to the person results in a financial loss to the bank equivalent to the unpaid debt and the additional expenses the bank may incur
 
The goal is to minimize loss from the bank’s perspective using a decision engine regarding who to grant approval of the loan and who to reject.  From the data science point of view the aim is to propose an approach for automatic approving or disapproving loan request. The scope must extend from the treatment of the raw data to the final decision. It is expected that various alternatives will be evaluated at each stage and a discussion of the associated tradeoff among the different alternatives will be discussed.

Attached here, data containing 700 features and one more feature called ‘loss’ which indicates to bank loss, i.e. how much percent of the loan the bank didn’t get back.

a.	Choose a strategy that could maximize the bank profits from giving loans (by increase the income or decrease loss\expanses).
Describe your strategy and commit a full ‘data science’ procedure as learnt in DM-CRISP model.
b.	In the assignment you will need to analyze the dataset you are given with on this link https://www.kaggle.com/c/loan-default-prediction/data?train_v2.csv.zip 
This file will be your full data, and on this data you will perform DM CRISP model.
c.	Split the dataset into training and test dataset with 70 percent training and 30 percent test.
d.	After analyzing the data, you will need to show us results of extended ‘data exploration’ for 5 interesting features (good or bad), for example: high correlation for ‘loss’ column, zero variance column, missing data in column etc.

e.	Note that the file has several columns which are often missing values, which may disturb you when you try to run a model to the data. The simple solution we offer is to omit from the data set columns with missing values. If you choose other solutions please explain what is the solution and why it is best suited to your taste.
f.	After preparing the data, you need to examine the results of a naive model ("rule of thumb" model with no data science).
g.	In addition, you are asked to build a DS based model that answers the problem well (that’s why you should check several different models, in order to compare and to choose the best of them). You can use R language built in packages. Note that you must set a target function (the function should give weight to errors Type 1 and Type 2). 
h.	Describe in writing (Word file), the process accompanied by the results from each part, explain the considerations for choosing the target function. 
i.	Submit your full and properly commented scripting code/program, you developed for the whole CRISP-DM.
j.	You also need to report the accuracy of your proposed mdels.
The program will run the models on csv file like the train file (train.csv).  The file will be local.

The program: 
i.	Load the models (function) you made 
ii.	Read the new data and make them the transformation to clean them (missing data handling \ extracting invariant features that the model uses for each model or any other data preprocessing/preparation task ).
iii.	Print to the screen the results of the two models you choose (according to the target function that you have defined) with text description that makes clear to which model the result belongs.




Highlights:
•	Describe all the process, from the business problem, selecting / learning data, translation data to a mining problem, indices, and how the solution will be used in the business world.
•	Select "naive model" (model that is simple to think without DS process), and compare the naïve model to models you have developed. Your goal to produce a model that best deals with the problem you was defined.
•	You can assume reasonable assumptions if necessary to answer the question.
•	The score will be affected by how well your model meets the relevant question, and actually give the maximum for the bank's profitability.

