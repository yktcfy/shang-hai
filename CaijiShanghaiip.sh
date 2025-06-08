#pwd
if [ $# -eq 0 ]; then
  echo "开始测试······"
  echo "在5秒内输入1~4可选择城市"
  echo "请选择城市："
  echo "1. 上海（Shanghai_dianxin）"
  read -t 5 -p "超时未输入,将按默认设置测试" city_choice

  if [ -z "$city_choice" ]; then
      echo "未检测到输入,默认测试全部"
      city_choice=0
  fi

else
  city_choice=$1
fi
# 设置城市和相应的stream
case $city_choice in
    1)
        city="Shanghai_dianxin"
        stream="rtp/239.45.3.237:5140"
        ;;
    0)
        # 逐个处理{ }内每个选项
        for option in {1..22}; do
          bash "$0" $option  # 假定fofa.sh是当前脚本的文件名，$option将递归调用
        done
        exit 0
        ;;
esac

# 使用城市名作为默认文件名，格式为 CityName.ip
time=$(date +%m%d%H%M)
ipfile=ip/${city}_ip.txt
good_ip=ip/good_${city}_ip.txt
result_ip=ip/result_${city}_ip.txt
echo "======== 开始检索 ${city} ========"
#echo "从 fofa 获取ip+端口"
#curl -o test.html $url_fofa
#grep -E '^\s*[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+:[0-9]+$' test.html | grep -oE '[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+:[0-9]+' > tmp_ipfile
echo "从 '${ipfile}' 读取ip并添加到检测列表"
cat $ipfile >> tmp_ipfile
sort tmp_ipfile | uniq | sed '/^\s*$/d' > $ipfile
rm -f tmp_ipfile

while IFS= read -r ip; do
    # 尝试连接 IP 地址和端口号，并将输出保存到变量中
    tmp_ip=$(echo -n "$ip" | sed 's/:/ /')
    output=$(nc -w 1 -v -z $tmp_ip 2>&1)
    # 如果连接成功，且输出包含 "succeeded"，则将结果保存到输出文件中
    if [[ $output == *"succeeded"* ]]; then
        # 使用 awk 提取 IP 地址和端口号对应的字符串，并保存到输出文件中
        echo "$output" | grep "succeeded" | awk -v ip="$ip" '{print ip}' >> $good_ip
    fi
done < $ipfile
lines=$(wc -l < $good_ip)
echo "连接成功 $lines 个,开始测速······"
i=0
while read line; do
    i=$((i + 1))
    ip=$line
    url="http://$ip/$stream"
    #echo $url
    curl $url --connect-timeout 5 --max-time 60 -o /dev/null >zubo.tmp 2>&1
    a=$(head -n 3 zubo.tmp | awk '{print $NF}' | tail -n 1)  
    echo "第$i/$lines个：$ip    $a"
    echo "$ip    $a" >> speedtest_${city}_$time.log
done < $good_ip
#cat $good_ip > $ipfile
rm -rf zubo.tmp $ipfile $good_ip

echo "测速结果排序"
awk '/M|k/{print $2"  "$1}' speedtest_${city}_$time.log | sort -n -r > $result_ip
cat $result_ip
ip1=$(awk 'NR==1{print $2}' $result_ip)
ip2=$(awk 'NR==2{print $2}' $result_ip)
ip3=$(awk 'NR==3{print $2}' $result_ip)
ip4=$(awk 'NR==4{print $2}' $result_ip)
ip5=$(awk 'NR==5{print $2}' $result_ip)
ip6=$(awk 'NR==6{print $2}' $result_ip)
ip7=$(awk 'NR==7{print $2}' $result_ip)
ip8=$(awk 'NR==8{print $2}' $result_ip)
ip9=$(awk 'NR==9{print $2}' $result_ip)
ip10=$(awk 'NR==10{print $2}' $result_ip)
ip11=$(awk 'NR==11{print $2}' $result_ip)
ip12=$(awk 'NR==12{print $2}' $result_ip)
ip13=$(awk 'NR==13{print $2}' $result_ip)
ip14=$(awk 'NR==14{print $2}' $result_ip)
ip15=$(awk 'NR==15{print $2}' $result_ip)
ip16=$(awk 'NR==16{print $2}' $result_ip)
ip17=$(awk 'NR==17{print $2}' $result_ip)
ip18=$(awk 'NR==18{print $2}' $result_ip)
ip19=$(awk 'NR==19{print $2}' $result_ip)
ip20=$(awk 'NR==20{print $2}' $result_ip)
ip21=$(awk 'NR==21{print $2}' $result_ip)
ip22=$(awk 'NR==22{print $2}' $result_ip)
ip23=$(awk 'NR==23{print $2}' $result_ip)
ip24=$(awk 'NR==24{print $2}' $result_ip)
ip25=$(awk 'NR==25{print $2}' $result_ip)
ip26=$(awk 'NR==26{print $2}' $result_ip)
ip27=$(awk 'NR==27{print $2}' $result_ip)
ip28=$(awk 'NR==28{print $2}' $result_ip)
ip29=$(awk 'NR==29{print $2}' $result_ip)
ip30=$(awk 'NR==30{print $2}' $result_ip)
rm -f speedtest_${city}_$time.log $result_ip    
# 用 30 个最快 ip 生成对应城市的 txt 文件
program=template/template_${city}.txt
sed "s/ipipip/$ip1/g" $program > tmp_1.txt
sed "s/ipipip/$ip2/g" $program > tmp_2.txt
sed "s/ipipip/$ip3/g" $program > tmp_3.txt
sed "s/ipipip/$ip4/g" $program > tmp_4.txt
sed "s/ipipip/$ip5/g" $program > tmp_5.txt
sed "s/ipipip/$ip6/g" $program > tmp_6.txt
sed "s/ipipip/$ip7/g" $program > tmp_7.txt
sed "s/ipipip/$ip8/g" $program > tmp_8.txt
sed "s/ipipip/$ip9/g" $program > tmp_9.txt
sed "s/ipipip/$ip10/g" $program > tmp_10.txt
sed "s/ipipip/$ip11/g" $program > tmp_11.txt
sed "s/ipipip/$ip12/g" $program > tmp_12.txt
sed "s/ipipip/$ip13/g" $program > tmp_13.txt
sed "s/ipipip/$ip14/g" $program > tmp_14.txt
sed "s/ipipip/$ip15/g" $program > tmp_15.txt
sed "s/ipipip/$ip16/g" $program > tmp_16.txt
sed "s/ipipip/$ip17/g" $program > tmp_17.txt
sed "s/ipipip/$ip18/g" $program > tmp_18.txt
sed "s/ipipip/$ip19/g" $program > tmp_19.txt
sed "s/ipipip/$ip20/g" $program > tmp_20.txt
sed "s/ipipip/$ip21/g" $program > tmp_21.txt
sed "s/ipipip/$ip22/g" $program > tmp_22.txt
sed "s/ipipip/$ip23/g" $program > tmp_23.txt
sed "s/ipipip/$ip24/g" $program > tmp_24.txt
sed "s/ipipip/$ip25/g" $program > tmp_25.txt
sed "s/ipipip/$ip26/g" $program > tmp_26.txt
sed "s/ipipip/$ip27/g" $program > tmp_27.txt
sed "s/ipipip/$ip28/g" $program > tmp_28.txt
sed "s/ipipip/$ip29/g" $program > tmp_29.txt
sed "s/ipipip/$ip30/g" $program > tmp_30.txt
cat tmp_1.txt >> tmp_all.txt
cat tmp_2.txt >> tmp_all.txt
cat tmp_3.txt >> tmp_all.txt
cat tmp_4.txt >> tmp_all.txt
cat tmp_5.txt >> tmp_all.txt
cat tmp_6.txt >> tmp_all.txt
cat tmp_7.txt >> tmp_all.txt
cat tmp_8.txt >> tmp_all.txt
cat tmp_9.txt >> tmp_all.txt
cat tmp_10.txt >> tmp_all.txt
cat tmp_11.txt >> tmp_all.txt
cat tmp_12.txt >> tmp_all.txt
cat tmp_13.txt >> tmp_all.txt
cat tmp_14.txt >> tmp_all.txt
cat tmp_15.txt >> tmp_all.txt
cat tmp_16.txt >> tmp_all.txt
cat tmp_17.txt >> tmp_all.txt
cat tmp_18.txt >> tmp_all.txt
cat tmp_19.txt >> tmp_all.txt
cat tmp_20.txt >> tmp_all.txt
cat tmp_21.txt >> tmp_all.txt
cat tmp_22.txt >> tmp_all.txt
cat tmp_23.txt >> tmp_all.txt
cat tmp_24.txt >> tmp_all.txt
cat tmp_25.txt >> tmp_all.txt
cat tmp_26.txt >> tmp_all.txt
cat tmp_27.txt >> tmp_all.txt
cat tmp_28.txt >> tmp_all.txt
cat tmp_29.txt >> tmp_all.txt
cat tmp_30.txt >> tmp_all.txt
grep -vE '/{3}' tmp_all.txt > "txt/${city}.txt"
rm -f tmp_1.txt tmp_2.txt tmp_3.txt tmp_4.txt tmp_5.txt tmp_6.txt tmp_7.txt tmp_8.txt tmp_9.txt tmp_10.txt tmp_11.txt tmp_12.txt tmp_13.txt tmp_14.txt tmp_15.txt tmp_16.txt tmp_17.txt tmp_18.txt tmp_19.txt tmp_20.txt tmp_21.txt tmp_22.txt tmp_23.txt tmp_24.txt tmp_25.txt tmp_26.txt tmp_27.txt tmp_28.txt tmp_29.txt tmp_30.txt tmp_all.txt
echo "${city} 测试完成，生成可用文件：'txt/${city}.txt'"
#--------合并所有城市的txt文件---------
