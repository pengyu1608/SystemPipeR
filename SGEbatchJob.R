cluster.functions = makeClusterFunctionsSGE("/home/yupeng/SGE.tmpl")
mail.start = "first+last"
mail.done = "first+last"
mail.error = "all" 
mail.from = "yup@pku.edu.cn"
mail.to = "yup@pku.edu.cn" 
mail.control = list(smtpServer="mgt.cluster.com")
default.resources = list(R="R-3.2.2", h_rt= "20:00:00", mem="5G", slots=1)
debug = FALSE
