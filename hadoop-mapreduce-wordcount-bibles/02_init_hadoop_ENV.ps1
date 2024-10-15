# Ensure we can run everything
Set-ExecutionPolicy Bypass -Scope Process -Force

# Hadoop download and initialization
# https://kontext.tech/column/spark/311/apache-spark-243-installation-on-windows-10-using-windows-subsystem-for-linux
# https://cwiki.apache.org/confluence/display/HADOOP/Hadoop+Java+Versions

# dowload and untar to $HOME/hadoop
bash -c 'mkdir ~/hadoop'
bash -c "cd ~ && wget https://ftp.fau.de/apache/hadoop/common/hadoop-3.3.6/hadoop-3.3.6.tar.gz"
bash -c "cd ~ && tar -xvzf hadoop-3.3.6.tar.gz -C ~/hadoop"

# HADOOP_HOME and PATH initialization
bash -c 'echo "HADOOP_HOME=~/hadoop/hadoop-3.3.6" | sudo tee -a /etc/environment'
bash -c 'echo -e \"\\nexport HADOOP_HOME=~/hadoop/hadoop-3.3.6\" >> ~/.bashrc'
bash -c 'echo -e \"export PATH=\\\$PATH:\\\$HADOOP_HOME/bin\" >> ~/.bashrc'
bash -c 'echo -e \"\\nexport HADOOP_HOME=~/hadoop/hadoop-3.3.6\" >> ~/.zshrc'
bash -c 'echo -e \"export PATH=\\\$PATH:\\\$HADOOP_HOME/bin\" >> ~/.zshrc'
# check:
bash -c 'cat /etc/environment'
bash -c 'cat ~/.bashrc'
bash -c 'cat ~/.zshrc'

Write-Host "`nFINISHED with preparing Hadoop installation inside WSL2/Ubuntu."
Write-Host "`Installed to ~/hadoop."
Write-Host "(You can re-enter ubuntu with PowerShell-command 'bash'!)"
Write-Output "Press ENTER to continue..."
cmd /c Pause | Out-Null