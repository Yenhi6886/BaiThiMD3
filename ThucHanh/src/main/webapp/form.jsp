<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="org.example.thuchanh.model.PaymentMethod" %>
<%@ page import="java.util.*" %>
<%
    List<PaymentMethod> methods = (List<PaymentMethod>) request.getAttribute("methods");
%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Thêm phòng trọ</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css"/>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css"/>
    <style>
        body {
            background: linear-gradient(135deg, #e0eafc, #cfdef3 60%, #fff 100%);
        }
        .card {
            box-shadow: 0 4px 24px rgba(80,120,200,0.10), 0 1.5px 4px rgba(0,0,0,0.06);
            border: none;
        }
        label { font-weight: 500; }
    </style>
</head>
<body class="p-0">
<div class="container py-5">
    <div class="row justify-content-center">
        <div class="col-xl-5 col-lg-6 col-md-8 col-12">
            <div class="card p-4 animate-fadein">
                <div class="mb-3 text-center">
                    <h2 class="fw-bold text-primary mb-1">Tạo mới thuê phòng trọ</h2>
                    <p class="text-secondary mb-0">Điền đầy đủ thông tin vào biểu mẫu bên dưới</p>
                </div>
                <form action="rooms" method="post" autocomplete="off">
                    <div class="mb-3">
                        <label class="form-label">Tên người thuê <span class="text-danger">*</span></label>
                        <div class="input-group">
                            <span class="input-group-text bg-light"><i class="bi bi-person"></i></span>
                            <input type="text" name="tenantName" class="form-control" required
                                   pattern="^[\\p{L}\\s]{5,50}$"
                                   title="Tên phải từ 5–50 ký tự, chỉ chứa chữ và khoảng trắng"
                                   placeholder="Nguyễn Văn A"/>
                        </div>
                    </div>
                    <div class="mb-3">
                        <label class="form-label">Số điện thoại <span class="text-danger">*</span></label>
                        <div class="input-group">
                            <span class="input-group-text bg-light"><i class="bi bi-phone"></i></span>
                            <input type="text" name="phone" class="form-control" required
                                   pattern="0\d{9}"
                                   title="Số điện thoại phải gồm 10 chữ số, bắt đầu bằng 0"
                                   placeholder="0987654321"/>
                        </div>
                    </div>
                    <div class="mb-3">
                        <label class="form-label">Ngày bắt đầu thuê <span class="text-danger">*</span></label>
                        <div class="input-group">
                            <span class="input-group-text bg-light"><i class="bi bi-calendar-date"></i></span>
                            <input type="date" name="startDate" class="form-control" required
                                   min="<%= java.time.LocalDate.now().toString() %>"/>
                        </div>
                    </div>
                    <div class="mb-3">
                        <label class="form-label">Hình thức thanh toán <span class="text-danger">*</span></label>
                        <div class="input-group">
                            <span class="input-group-text bg-light"><i class="bi bi-wallet2"></i></span>
                            <select name="paymentMethodId" class="form-select" required>
                                <option value="">-- Chọn hình thức --</option>
                                <% for (PaymentMethod m : methods) { %>
                                <option value="<%= m.getId() %>"><%= m.getName() %></option>
                                <% } %>
                            </select>
                        </div>
                    </div>
                    <div class="mb-3">
                        <label class="form-label">Ghi chú</label>
                        <textarea name="note" class="form-control" maxlength="200"
                                  style="resize:vertical;min-height:60px"
                                  placeholder="Không bắt buộc, tối đa 200 ký tự"></textarea>
                    </div>
                    <div class="d-flex gap-2 justify-content-center">
                        <button type="submit" class="btn btn-success px-4">
                            <i class="bi bi-check-circle"></i> Tạo mới
                        </button>
                        <a href="rooms" class="btn btn-outline-secondary px-4">
                            <i class="bi bi-x-circle"></i> Hủy
                        </a>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>
</body>
</html>