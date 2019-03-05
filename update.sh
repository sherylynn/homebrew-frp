version="0.24.1"
url="https://github.com/fatedier/frp/releases/download/v"${version}"/frp_"${version}"_darwin_amd64.tar.gz"
curl -o frp.tar.gz -L ${url}
sha256=$(openssl dgst -sha256 frp.tar.gz)
echo ${sha256}
sha256_string=${sha256##*= }
echo ${sha256_string}
rm frp.tar.gz
vi ./Formula/frp.rb -c '/version' -c 'normal ddOversion ""' -c "normal i${version}" -c 'wq!'
vi ./Formula/frp.rb -c '/sha256' -c 'normal ddOsha256 ""' -c "normal i${sha256_string}" -c 'wq!'
