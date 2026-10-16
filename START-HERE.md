# Video Workflow Kit

Bộ làm việc cho Windows: dùng Codex chỉnh video bằng video-use, duyệt bản dựng và đăng qua Zernio.

**Hướng dẫn chính:** [Tài liệu Word](docs/Huong-dan-su-dung.docx).

## Bắt đầu

1. Giải nén vào một thư mục cố định, ví dụ `C:\VideoWorkflow`. Mở cả thư mục đó làm project trong Codex.
2. Nhắn Codex: “Đọc START-HERE.md và thiết lập bộ workflow này trên Windows cho tôi. Chưa transcribe hoặc đăng video.”
3. Khi được hướng dẫn, tự chạy `powershell -ExecutionPolicy Bypass -File .\setup\configure.ps1` trong terminal để nhập key ẩn.
4. Kết nối tài khoản mạng xã hội trên Zernio, nhờ Codex liệt kê tài khoản rồi lưu ID đúng vào `local/accounts.json`.
5. Đặt video trong `projects/<ten-du-an>/input/`, yêu cầu Codex đề xuất phương án edit. Duyệt trước khi dựng và xem video trước khi đăng.

Không cần chạy monorepo Studio, MySQL hoặc API Gateway để dùng bộ này.

## Các lệnh

```powershell
powershell -ExecutionPolicy Bypass -File .\setup\setup.ps1
powershell -ExecutionPolicy Bypass -File .\setup\configure.ps1
powershell -ExecutionPolicy Bypass -File .\setup\doctor.ps1
node tools/publisher/dist/cli.js accounts
node tools/publisher/dist/cli.js check
```

`accounts` chỉ đọc danh sách tài khoản; `check` kiểm tra tài khoản đã chọn. Cả hai gọi Zernio nhưng không đăng bài. `doctor` chỉ kiểm tra máy và cấu hình cục bộ, không xác minh key từ xa.

## Cập nhật

Chỉ dùng tag phiên bản được người bảo trì thông báo. Ví dụ `v1.1.0` trong lệnh dưới là minh họa, không có nghĩa phiên bản đó đã phát hành.

```powershell
powershell -ExecutionPolicy Bypass -File .\setup\update.ps1 -Component video-use -Version v1.1.0
powershell -ExecutionPolicy Bypass -File .\setup\update.ps1 -Component video-use -Rollback
```

Có thể dùng `-Source C:\duong-dan\bo-kit-moi` để cập nhật từ folder đã giải nén. Xem `docs/MAINTAINER.md` cho người bảo trì.

## Phạm vi và dữ liệu

- Python 3.11 trở lên, Node.js 22 LTS trở lên, Git và FFmpeg có bộ lọc `subtitles`.
- Key ElevenLabs chỉ cần Speech to Text cho phiên âm. Các thao tác cắt, ghép hoặc trộn âm thanh bằng FFmpeg không bắt buộc cần key; edit theo lời thoại của video-use cần transcript có timestamp từng từ.
- Một hay nhiều Zernio API key tùy tài khoản/profile thực tế; không bắt buộc dùng hai key hoặc đăng cả bốn nền tảng.
- `local/`, `projects/`, `.venv/` không đi vào Git hoặc ZIP phát hành. Key trong `local/secrets.env` là plaintext trên ổ đĩa: giữ folder riêng tư và bảo vệ tài khoản Windows.
- Chưa bao gồm nhạc có bản quyền hoặc video của tác giả. Cung cấp nhạc bạn có quyền dùng hoặc yêu cầu Codex tìm nguồn và lưu thông tin giấy phép.

Mã bộ kit do nhóm quản lý nội bộ. `video-use` giữ giấy phép MIT riêng; xem `THIRD-PARTY-NOTICES.md`.
