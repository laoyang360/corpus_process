# corpus_process
Corpus process for NLP classify.
http://blog.csdn.net/laoyang360

## 1、引言

   在进行自然语言处理（NLP)处理的时候，
   基本的操作无外乎分词、分类、聚类、命名实体识别、
   规则过滤、摘要提取、关键字提取、词性标注、拼音标注。
   
   分类通用的做法就是根据提供的语言库自学习识别成对应的分类。
   现有的复旦大学提供的语料库有20种分类。
   （参考：http://www.nlpir.org/?action-viewnews-itemid-103），网上也有提供更多种分类的。

分词网上比较NB的几个实验室有：

  ### 1）、背景理工大学张华平副教授的 nlp 自然语言处理与信息共享检索平台
  http://ictclas.nlpir.org/nlpir/。 

  ### 2）、哈工大“语言云” 以哈工大社会计算与信息检索研究中心研发的 “语言技术平台（LTP）” 
   http://www.ltp-cloud.com/demo/。
  （本段摘自网络）文本分类语料库（复旦）测试语料由复旦大学李荣陆提供。
  answer.rar为测试语料，共9833篇文档；
  train.rar为训练语料，共9804篇文档，分为20个类别。训练语料和测试语料基本按照1:1的比例来划分。
  收集工作花费了不少人力和物力，所以请大家在使用时尽量注明来源（复旦大学计算机信息与技术系国际数据库中心自然语言处理小组）。
  文件较大（训练测试各50多兆）。
  实际项目中需要根据自己的需要进行定制处理。
           
## 2、需求点

   结合口头需求，我整理出下面的两个核心需求点。
   需求1：以中文形式输出语料库中包含的全部文件类型到一个类型文件outtype.txt。
   需求2：将预料库中的所有文件以[EndEnd]结尾并合并，导出到数据文件outdata.txt。
   其中文件路径和文件个数如下，累计文件综合近1.3GB。

## 3、需求分析

   ### 需求1：
   1）每个类别命名的文件夹下存放的就是该类别的文件。统计下该类别下文件的个数cnt。
   2）内层循环cnt次，文件名追加输出到一个文件。
   3）外层循环20次（一共20类预料）即可。
   
   ### 需求2：
   1）每个文件末尾追加[EndEnd];
   2) 便利每个路径下的文件合成一个文件。
   细节注意事项：需求1的类别和需求2的以[EndEnd]结束的文件要一一对应，一旦对应偏了，整个工作都会白费。

20160304 22:40

