* ToolCC

* Tác giả: chamchamfy
* Phiên bản: V1.230131
* Sửa một số lỗi khi chạy tool
* Hỗ trợ các phiên bản android chạy được termux.
* Dùng được cho các thiết bị không root
* Hỗ trợ giải nén các loại rom như: payload, super, dat, br, zstd, ...
* Hỗ trợ apktool chỉnh sửa apk, patch boot,...

* Cài đặt ban đầu: 
1. Chép file sccf vào /sdcard 
2. Chạy termux nhập lệnh: 
 sh /sdcard/sccf
-> Hiện thông báo Tải dữ liệu mới thì nhập vào c nó sẽ tự chạy. 
3. Cập nhật các gói và thư viện nhập lệnh: 
 pkg update -y && pkg upgrade -y && pkg install curl zip unzip zstd binutils android-tools proot-distro e2fsprogs python3 openjdk-17 p7zip -y && pkg update -y && pkg upgrade -y 

-> Cài xong chạy tiếp lệnh: 

 pip3 install protobuf bsdiff4 six crypto construct google docopt pycryptodome

=> Trên termux nhập cct để chạy công cụ.