### Công cụ bung rom tạo bởi @chamchamfy

1. Cài termux, cấp quyền truy cập bộ nhớ. Sau đó chạy termux cài đặt các gói: 

pkg update -y && pkg upgrade -y && pkg install which brotli curl zip unzip zstd pzstd binutils android-tools proot proot-distro e2fsprogs python3 openjdk-17 p7zip -y && pkg update -y && pkg upgrade -y 
 
2. Cài gói phụ thuộc pip: 

pip3 install protobuf bsdiff4 six crypto construct google docopt pycryptodome zstandard

3. Tải tập tin sccf vào /sdcard

4. Cài công cụ nhập dòng lệnh thực thi tập tin sccf:

 sh /sdcard/sccf
(Xóa các tập tin trong: /sdcard/.ur/libcc nếu có). Sau đó nhập c để cập nhật dữ liệu.

5. Nhập tên tương ứng để chạy!

Vd: cct 

### Trong quá trình cài đặt gói dữ liệu ấn enter nếu không biết lựa chọn!
