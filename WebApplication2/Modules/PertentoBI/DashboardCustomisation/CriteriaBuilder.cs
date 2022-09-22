using System;
using System.Collections;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Web;
using DevExpress.Data.Filtering;
using PertentoBI.Classes;

namespace PertentoBI.Web.DashboardCustomisation
{
    public class CriteriaBuilder

    {

        private ArrayList Parameters = new ArrayList();


        public struct Data
        {
            public Data(string criteria, ArrayList parameters)
            {
                CriteriaData = criteria;
                ParameterData = parameters;
            }

            public string CriteriaData { get; private set; }
            public ArrayList ParameterData { get; private set; }
        }

        public Data BuildSQLServerCriteria(CriteriaPatcherBase.FilterCritera criteria)
        {
            try
            {
                StringBuilder sbCriteria = new StringBuilder();
                foreach (CriteriaOperator item in criteria.Operands)
                {
                    switch (item.GetType().Name)
                    {
                        case "BinaryOperator":
                            if (sbCriteria.Length == 0)
                            {
                                var qry = BinaryOperatorTypeCriteria(item);
                                if (qry.Length > 0) sbCriteria = qry;
                            }
                            else
                            {
                                var qryVal = BinaryOperatorTypeCriteria(item).ToString();
                                if (qryVal.Length > 0) sbCriteria.Append($" {criteria.GroupOperatorType.ToString()} {qryVal}");
                            }
                            break;
                        case "FunctionOperator":
                            if (sbCriteria.Length == 0)
                            {
                                var qry = FunctionOperatorTypeCriteria(item);
                                if (qry.Length > 0) sbCriteria = qry;
                            }
                            else
                            {
                                var qryVal = FunctionOperatorTypeCriteria(item).ToString();
                                if (qryVal.Length > 0) sbCriteria.Append($" {criteria.GroupOperatorType.ToString()} {qryVal}");
                            }
                            break;
                        case "BetweenOperator":
                            if (sbCriteria.Length == 0)
                            {
                                var qry = BetweenOperatorTypeCriteria(item);
                                if (qry.Length > 0) sbCriteria = qry;
                            }
                            else
                            {
                                var qryVal = BetweenOperatorTypeCriteria(item).ToString();
                                if (qryVal.Length > 0) sbCriteria.Append($" {criteria.GroupOperatorType.ToString()} {qryVal}");
                            }
                            break;
                        case "UnaryOperator":
                            if (sbCriteria.Length == 0)
                            {
                                var qry = UnaryOperatorTypeCriteria(item);
                                if (qry.Length > 0) sbCriteria = qry;
                            }
                            else
                            {
                                var qryVal = UnaryOperatorTypeCriteria(item).ToString();
                                if (qryVal.Length > 0) sbCriteria.Append($" {criteria.GroupOperatorType.ToString()} {qryVal}");
                            }
                            break;
                        case "InOperator":
                            if (sbCriteria.Length == 0)
                            {
                                var qry = InOperatorTypeCriteria(item);
                                if (qry.Length > 0) sbCriteria = qry;
                            }
                            else
                            {
                                var qryVal = InOperatorTypeCriteria(item).ToString();
                                if (qryVal.Length > 0) sbCriteria.Append($" {criteria.GroupOperatorType.ToString()} {qryVal}");
                            }
                            break;

                    }

                }

                return new Data(sbCriteria.ToString(), Parameters);
            }
            catch (Exception ex)
            {
 
                return new Data("", null);
            }

        }

        protected StringBuilder BinaryOperatorTypeCriteria(CriteriaOperator item)
        {
            try
            {
                var operatorItem = (BinaryOperator)item;
                StringBuilder sb = new StringBuilder();
                string parameterName = "";


                if (operatorItem.RightOperand.ToString() != "?")
                {
                    var paramValue = ((OperandValue)operatorItem.RightOperand).Value.ToString();
                    switch (operatorItem.OperatorType)
                    {
                        case BinaryOperatorType.Equal:

                            parameterName = operatorItem.LeftOperand.ToString().Trim('[', ']');
                            parameterName = HelperFunctions.CleanupFilename(ref parameterName).Replace(" ", "").Replace(" ", "");

                            Parameters.Add(new SqlParameter($"@{parameterName}", paramValue));
                            sb.Append($" {operatorItem.LeftOperand} = @{parameterName} ");
                            break;

                        case BinaryOperatorType.NotEqual:

                            parameterName = operatorItem.LeftOperand.ToString().Trim('[', ']');
                            parameterName = HelperFunctions.CleanupFilename(ref parameterName).Replace(" ", "");
                            Parameters.Add(new SqlParameter($"@{parameterName}", paramValue));

                            sb.Append($"{operatorItem.LeftOperand} <> @{parameterName}");
                            break;

                        case BinaryOperatorType.Less:

                            parameterName = operatorItem.LeftOperand.ToString().Trim('[', ']');
                            parameterName = HelperFunctions.CleanupFilename(ref parameterName).Replace(" ", "");
                            Parameters.Add(new SqlParameter($"@{parameterName}", paramValue));
                            sb.Append($"{operatorItem.LeftOperand} < @{parameterName}");
                            break;
                        case BinaryOperatorType.LessOrEqual:

                            parameterName = operatorItem.LeftOperand.ToString().Trim('[', ']');
                            parameterName = HelperFunctions.CleanupFilename(ref parameterName).Replace(" ", "");
                            Parameters.Add(new SqlParameter($"@{parameterName}", paramValue));
                            sb.Append($"{operatorItem.LeftOperand} <= @{parameterName}");
                            break;
                        case BinaryOperatorType.Greater:

                            parameterName = operatorItem.LeftOperand.ToString().Trim('[', ']');
                            parameterName = HelperFunctions.CleanupFilename(ref parameterName).Replace(" ", "");
                            Parameters.Add(new SqlParameter($"@{parameterName}", paramValue));

                            sb.Append($"{operatorItem.LeftOperand} > @{parameterName}");
                            break;
                        case BinaryOperatorType.GreaterOrEqual:

                            parameterName = operatorItem.LeftOperand.ToString().Trim('[', ']');
                            parameterName = HelperFunctions.CleanupFilename(ref parameterName).Replace(" ", "");
                            Parameters.Add(new SqlParameter($"@{parameterName}", paramValue));
                            sb.Append($"{operatorItem.LeftOperand} >= @{parameterName}");
                            break;
                    }
                }
                else { }
                return sb;
            }
            catch (Exception ex)
            {
          
                return null;
            }


        }
        protected StringBuilder FunctionOperatorTypeCriteria(CriteriaOperator item)
        {
            try
            {
                var operatorItem = (FunctionOperator)item;
                StringBuilder sb = new StringBuilder();

                if (operatorItem.Operands[1].ToString() != "?")
                {
                    switch (operatorItem.OperatorType)
                    {
                        case FunctionOperatorType.Contains:
                            var parameter = ((OperandProperty)operatorItem.Operands[0]).ToString();
                            var parameterName = operatorItem.Operands[0].ToString().Trim('[', ']');
                            parameterName = HelperFunctions.CleanupFilename(ref parameterName).Replace(" ", "");

                            var paraValue = ((OperandValue)operatorItem.Operands[1]).Value.ToString();

                            Parameters.Add(new SqlParameter($"@{parameterName}", paraValue));
                            sb.Append($"{parameter} LIKE '%' + @{parameterName} +'%' ");

                            break;

                        case FunctionOperatorType.StartsWith:
                            var parameterSW = ((OperandProperty)operatorItem.Operands[0]).ToString();
                            var parameterNameSW = operatorItem.Operands[0].ToString().Trim('[', ']');
                            parameterNameSW = HelperFunctions.CleanupFilename(ref parameterNameSW).Replace(" ", "");

                            var paraValueSW = ((OperandValue)operatorItem.Operands[1]).Value.ToString();

                            Parameters.Add(new SqlParameter($"@{parameterNameSW}", paraValueSW));
                            sb.Append($"{parameterSW} LIKE ''+ @{parameterNameSW} + '%' ");

                            break;

                        case FunctionOperatorType.EndsWith:
                            var parameterEW = ((OperandProperty)operatorItem.Operands[0]).ToString();
                            var parameterNameEW = operatorItem.Operands[0].ToString().Trim('[', ']');
                            parameterNameEW = HelperFunctions.CleanupFilename(ref parameterNameEW).Replace(" ", "");

                            var paraValueEW = ((OperandValue)operatorItem.Operands[1]).Value.ToString();

                            Parameters.Add(new SqlParameter($"@{parameterNameEW}", paraValueEW));
                            sb.Append($"{parameterEW} LIKE '%' + @{parameterNameEW} +'' ");

                            break;

                        case FunctionOperatorType.Custom:
                            var parameterC = ((OperandProperty)operatorItem.Operands[0]).ToString();
                            var parameterNameC = operatorItem.Operands[0].ToString().Trim('[', ']');
                            parameterNameC = HelperFunctions.CleanupFilename(ref parameterNameC).Replace(" ", "");

                            var paraValueC = ((OperandValue)operatorItem.Operands[1]).Value.ToString();

                            Parameters.Add(new SqlParameter($"@{parameterNameC}", paraValueC));
                            sb.Append($"{parameterC} LIKE '%' + @{parameterNameC} +'%' ");

                            break;
                    }

                }
                return sb;
            }
            catch (Exception ex)
            {
             
                return null;
            }

        }

        protected StringBuilder UnaryOperatorTypeCriteria(CriteriaOperator item)
        {
            try
            {
                var operatorItem = (UnaryOperator)item;
                StringBuilder sb = new StringBuilder();

                switch (operatorItem.OperatorType)
                {
                    case UnaryOperatorType.IsNull:

                        break;
                    case UnaryOperatorType.Not:
                        break;

                }
                return sb;
            }
            catch (Exception ex)
            {
             
                return null;
            }
        }

        protected StringBuilder InOperatorTypeCriteria(CriteriaOperator item)
        {
            try
            {
                var operatorItem = (InOperator)item;
                StringBuilder sb = new StringBuilder();
                StringBuilder sbIn = new StringBuilder();

                for (int i = 0; i < operatorItem.Operands.Count; i++)
                {
                    string parameterName = operatorItem.LeftOperand.ToString().Trim('[', ']');
                    parameterName = HelperFunctions.CleanupFilename(ref parameterName).Replace(" ", "");
                    var paramValue = ((DevExpress.Data.Filtering.OperandValue)operatorItem.Operands[i]).Value.ToString();

                    Parameters.Add(new SqlParameter($"@{parameterName}{i}", paramValue));
                    if (sbIn.Length <= 0)
                        sbIn.Append($"@{parameterName}{i}");
                    else
                        sbIn.Append($", @{parameterName}{i}");
                }

                sb.Append($" {operatorItem.LeftOperand} in ({sbIn.ToString()}) ");

                return sb;
            }
            catch (Exception ex)
            {
            
                return null;
            }
        }

        protected StringBuilder BetweenOperatorTypeCriteria(CriteriaOperator item)
        {
            try
            {
                var operatorItem = (BetweenOperator)item;
                StringBuilder sb = new StringBuilder();

                string beginExpression = ((OperandValue)operatorItem.BeginExpression).Value.ToString();
                string endExpression = ((OperandValue)operatorItem.EndExpression).Value.ToString();
                string testExpression = operatorItem.TestExpression.ToString();

                Parameters.Add(new SqlParameter($"@beginExpression", beginExpression));
                Parameters.Add(new SqlParameter($"@endExpression", endExpression));

                sb.Append($" {testExpression} BETWEEN @beginExpression AND @endExpression ");

                return sb;
            }
            catch (Exception ex)
            {
             
                return null;
            }
        }
    }
}