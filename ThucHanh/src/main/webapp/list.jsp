<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.*, org.example.thuchanh.model.Room" %>
<%@ page import="org.example.thuchanh.dao.PaymentDAO, org.example.thuchanh.model.PaymentMethod" %>
<%
    List<Room> rooms = (List<Room>) request.getAttribute("rooms");
    String keyword = request.getAttribute("keyword") != null ? (String) request.getAttribute("keyword") : "";
    PaymentDAO paymentDAO = new PaymentDAO();
    Map<Integer, String> paymentMap = new HashMap<>();
    for (PaymentMethod m : paymentDAO.findAll()) {
        paymentMap.put(m.getId(), m.getName());
    }
%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Quản Lý Thuê Phòng Trọ</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css"/>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css"/>
    <style>
        body {
            background: linear-gradient(135deg, #e0eafc, #cfdef3 60%, #fff 100%);
            min-height: 100vh;
        }
        .card {
            box-shadow: 0 4px 24px rgba(80,120,200,0.08), 0 1.5px 4px rgba(0,0,0,0.05);
            border: none;
        }
        th {
            background: #4169e1;
            color: #fff !important;
        }
        .table-striped>tbody>tr:nth-of-type(odd) {
            background-color: #f3f7fb;
        }
        .badge-thang { background: #0d6efd; }
        .badge-quy   { background: #20c997; }
        .badge-nam   { background: #ffb300; color: #333;}
        .animate-fadein { animation: fadeIn .5s; }
        @keyframes fadeIn { from { opacity: 0; } to { opacity: 1; } }
        .btn-floating {
            border-radius: 50%; width: 48px; height: 48px; padding: 0;
            display: flex; align-items: center; justify-content: center;
            font-size: 1.4rem;
        }
    </style>
</head>
<body class="p-0">
<div class="container py-5">
    <div class="row mb-4">
        <div class="col-12 text-center">
            <h1 class="fw-bold text-primary mb-1">QUẢN LÝ THUÊ PHÒNG TRỌ</h1>
            <p class="text-secondary">Hệ thống quản lý chuyên nghiệp, hiện đại, dễ sử dụng</p>
        </div>
    </div>

    <div class="card p-4 mb-4">
        <form method="get" action="rooms" class="row g-2 align-items-center">
            <div class="col-md-5">
                <input type="text" name="search" value="<%= keyword %>" class="form-control shadow-sm" placeholder="Tìm theo mã, tên, SĐT..."/>
            </div>
            <div class="col-md-2">
                <button class="btn btn-outline-primary w-100" type="submit">
                    <i class="bi bi-search"></i> Tìm kiếm
                </button>
            </div>
            <div class="col-md-2">
                <a href="rooms?action=createForm" class="btn btn-success w-100">
                    <i class="bi bi-plus-circle"></i> Tạo mới
                </a>
            </div>
        </form>
    </div>

    <div class="card p-3 animate-fadein">
        <form id="deleteForm" method="post" action="rooms" onsubmit="return showConfirmPopup();" autocomplete="off">
            <div class="table-responsive">
                <table class="table table-striped table-hover align-middle">
                    <thead class="align-middle">
                    <tr>
                        <th style="width:36px"><input type="checkbox" onclick="toggleAll(this)"/></th>
                        <th style="width:80px">Mã phòng</th>
                        <th>Tên người thuê</th>
                        <th>SĐT</th>
                        <th>Ngày bắt đầu</th>
                        <th>Thanh toán</th>
                        <th>Ghi chú</th>
                    </tr>
                    </thead>
                    <tbody>
                    <% if (rooms != null && !rooms.isEmpty()) {
                        for (Room r : rooms) {
                            String badge = "badge-thang";
                            String payName = paymentMap.get(r.getPaymentMethodId());
                            if (payName != null) {
                                if (payName.toLowerCase().contains("quý")) badge = "badge-quy";
                                else if (payName.toLowerCase().contains("năm")) badge = "badge-nam";
                            }
                    %>
                    <tr>
                        <td><input type="checkbox" name="deleteIds" value="<%= r.getId() %>"/></td>
                        <td class="fw-bold text-primary">PT-<%= String.format("%03d", r.getId()) %></td>
                        <td class="text-capitalize"><i class="bi bi-person-badge text-info"></i> <%= r.getTenantName() %></td>
                        <td><i class="bi bi-telephone"></i> <%= r.getPhone() %></td>
                        <td><i class="bi bi-calendar2-date"></i> <%= r.getStartDate() %></td>
                        <td><span class="badge <%= badge %> px-3 py-2"><%= payName %></span></td>
                        <td><%= r.getNote() != null ? r.getNote() : "" %></td>
                    </tr>
                    <% }} else { %>
                    <tr>
                        <td colspan="7" class="text-center text-muted">Không có dữ liệu phòng trọ.</td>
                    </tr>
                    <% } %>
                    </tbody>
                </table>
            </div>
            <div class="d-flex gap-2 mt-3">
                <button type="submit" class="btn btn-danger px-4" style="font-weight:500;">
                    <i class="bi bi-trash"></i> Xóa đã chọn
                </button>
            </div>
        </form>
    </div>
</div>

<!-- Modal xác nhận xóa -->
<div id="confirmModal" class="modal d-none position-fixed top-0 start-0 w-100 h-100 bg-dark bg-opacity-50 justify-content-center align-items-center">
    <div class="bg-white p-4 rounded shadow text-center" style="min-width:340px;">
        <div class="mb-3">
            <i class="bi bi-exclamation-triangle text-danger" style="font-size: 2.5rem;"></i>
        </div>
        <p id="confirmText" class="fw-semibold mb-4" style="font-size:1.15rem"></p>
        <div class="d-flex justify-content-center gap-3">
            <button class="btn btn-secondary px-4" type="button" onclick="hideModal()">Không</button>
            <button class="btn btn-danger px-4" type="button" onclick="submitForm()">Có</button>
        </div>
    </div>
</div>

<script>
    function toggleAll(source) {
        const checkboxes = document.querySelectorAll('input[name="deleteIds"]');
        checkboxes.forEach(cb => cb.checked = source.checked);
    }
    function showConfirmPopup() {
        const selected = [...document.querySelectorAll('input[name="deleteIds"]:checked')];
        if (selected.length === 0) return false;
        const ids = selected.map(cb => `PT-${cb.value.padStart(3,"0")}`).join(", ");
        document.getElementById("confirmText").innerText = `Bạn có muốn xoá thông tin thuê trọ ${ids}?`;
        document.getElementById("confirmModal").classList.remove("d-none");
        document.getElementById("confirmModal").classList.add("d-flex");
        return false;
    }
    function hideModal() {
        document.getElementById("confirmModal").classList.add("d-none");
        document.getElementById("confirmModal").classList.remove("d-flex");
    }
    function submitForm() {
        document.getElementById("deleteForm").submit();
    }
</script>
</body>
</html>