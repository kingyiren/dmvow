# Introduction #

I've searched a lot for a way to get my model as a text file from the SSAS, but found the only way. Here it is.


# Details #

  1. Launch **Microsoft SQL Management Studio**
  1. Connect to your server
  1. Create new **DMX** Query `SELECT * FROM [Process Events].CONTENT`
  1. Execute the query on your mining model
  1. Copy all the table with results with Ctrl + C
  1. Open Notepad and paste it with Ctrl + V
  1. Save the file and use it in DMVoW