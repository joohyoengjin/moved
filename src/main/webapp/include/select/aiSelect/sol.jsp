<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.util.Enumeration"%>
<%@ page import="java.util.*"%>
<%@ page import="human.dao.MemberDao" %>
<%@ page import="human.vo.MemberVo" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>머신러닝-가구식별</title>
    <meta content="width=device-width, initial-scale=1.0" name="viewport">
    
    <meta content="" name="keywords">
    <meta content="" name="description">

    <!-- Favicon -->
    <link href="../../../assets/img/favicon.ico" rel="icon">

    <!-- Google Web Fonts -->
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Open+Sans:wght@400;600&family=Ubuntu:wght@500;700&display=swap"
        rel="stylesheet">

    <!-- Icon Font Stylesheet -->
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.10.0/css/all.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.4.1/font/bootstrap-icons.css" rel="stylesheet">

    <!-- Libraries Stylesheet -->
    <link href="lib/animate/animate.min.css" rel="stylesheet">
    <link href="lib/owlcarousel/assets/owl.carousel.min.css" rel="stylesheet">

    <!-- Customized Bootstrap Stylesheet -->
    <link href="../../../assets/css/bootstrap.min.css" rel="stylesheet">

    <!-- Template Stylesheet -->
    <link href="../../../assets/css/style.css" rel="stylesheet">
    
	<!-- upload -->
    <link rel="preconnect" href="https://fonts.gstatic.com">
  	<link rel="stylesheet" href='https://unpkg.com/boxicons@2.0.7/css/boxicons.min.css'>
  	<link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500&display=swap">
	<link rel="stylesheet" href="./upload.css">
	
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
</head>

<body style="">
    <!-- Spinner Start -->
    <div id="spinner"
        class="show bg-white position-fixed translate-middle w-100 vh-100 top-50 start-50 d-flex align-items-center justify-content-center">
        <div class="spinner-grow text-primary" style="width: 3rem; height: 3rem;" role="status">
            <span class="sr-only">Loading...</span>
        </div>
    </div>
    <!-- Spinner End -->


    <!-- Navbar Start -->
    <div class="container-fluid sticky-top">
        <div class="container">
            <nav class="navbar navbar-expand-lg navbar-dark p-0">
                <a href="../../../include/index.jsp" class="navbar-brand">
                    <h1 class="text-white">M<span style="color:skyblue;">O</span><span class="text-white">VED</span></h1>
                </a>
                <button type="button" class="navbar-toggler ms-auto me-0" data-bs-toggle="collapse"
                    data-bs-target="#navbarCollapse">
                    <span class="navbar-toggler-icon"></span>
                </button>
                <div class="collapse navbar-collapse" id="navbarCollapse">
                    <div class="navbar-nav ms-auto">
                        <a href="../../../include/index.jsp" class="nav-item nav-link active">Home</a>
                        <a href="../../../moved/movedint.jsp" class="nav-item nav-link">Moved 소개</a>
                        <a href="../../../include/calendar/cal.jsp" class="nav-item nav-link">Moved 이사견적</a>
                        <a href="../../../moved/statusBoard.jsp" class="nav-item nav-link">신청현황</a>
                        <a href="../../../moved/board.jsp" class="nav-item nav-link">고객센터</a>
                        <div class="nav-item dropdown">
                            <a href="#" class="nav-link dropdown-toggle" data-bs-toggle="dropdown">Pages</a>
                            <div class="dropdown-menu bg-light mt-2">
                                <a href="../../../html/feature.html" class="dropdown-item">Features</a>
                                <a href="../../../html/team.html" class="dropdown-item">Our Team</a>
                                <a href="../../../html/faq.html" class="dropdown-item">FAQs</a>
                                <a href="../../../html/testimonial.html" class="dropdown-item">Testimonial</a>
                                <a href="../../../html/404.html" class="dropdown-item">404 Page</a>
                            </div>
                        </div>
                        <a href="../../../html/contact.html" class="nav-item nav-link">Contact</a>
                    </div>

                    <butaton type="button" class="btn text-white p-0 d-none d-lg-block" data-bs-toggle="modal"
                        data-bs-target="#searchModal"><i class="fa fa-search"></i></butaton>
                </div>
            </nav>
        </div>
    </div>
    <!-- Navbar End -->


    <!-- Hero Start -->
    <div class="container-fluid pt-5 bg-primary hero-header">
        <div class="container pt-5">
            <div class="row g-5 pt-5">
                <div class="col-lg-6 align-self-center text-center text-lg-start mb-lg-5">
                    <h1 class="display-4 text-white mb-4 animated slideInRight">M<span style="color:skyblue;">O</span>VED 이사견적</h1>
                    <nav aria-label="breadcrumb">
                        <ol class="breadcrumb justify-content-center justify-content-lg-start mb-0">
                            <li class="breadcrumb-item"><a class="text-white" href="#">Home</a></li>
                            <li class="breadcrumb-item"><a class="text-white" href="#">Pages</a></li>
                            <li class="breadcrumb-item text-white active" aria-current="page">Our Projects</li>
                        </ol>
                    </nav>
                </div>
                <div class="col-lg-6 align-self-end text-center text-lg-end">
<!--                    <img class="img-fluid" src="../../../assets/img/hero-img.png" alt="" style="max-height: 300px;">-->
                </div>
            </div>
        </div>
    </div>
    <!-- Hero End -->


    <!-- Full Screen Search Start -->
    <div class="modal fade" id="searchModal" tabindex="-1">
        <div class="modal-dialog modal-fullscreen">
            <div class="modal-content" style="background: rgba(20, 24, 62, 0.7);">
                <div class="modal-header border-0">
                    <button type="button" class="btn btn-square bg-white btn-close" data-bs-dismiss="modal"
                        aria-label="Close"></button>
                </div>
                <div class="modal-body d-flex align-items-center justify-content-center">
                    <div class="input-group" style="max-width: 600px;">
                        <input type="text" class="form-control bg-transparent border-light p-3"
                            placeholder="Type search keyword">
                        <button class="btn btn-light px-4"><i class="bi bi-search"></i></button>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!-- Full Screen Search End -->


<!-- Case Start -->
    <div class="container-fluid bg-light py-5">
        <div class="container py-5">
            <div class="mx-auto text-center wow fadeIn" data-wow-delay="0.1s" style="max-width: 500px;">
                <div class="btn btn-sm border rounded-pill text-primary px-3 mb-3">A.I </div>
                <h1 class="mb-4">AI 가구  식별 </h1>

   <div style="margin-top: 20px;" id="imageContainer"></div>
   <br>
   <p>가구사진을 업로드 하세요.</p>



  <script src="https://cdn.jsdelivr.net/npm/axios/dist/axios.min.js"></script>
<script>
    var goodsData = [];
    <%
        try {
            Class.forName("oracle.jdbc.driver.OracleDriver");
            Connection conn = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:ORCL", "jsp", "123456");
            PreparedStatement pstmt = conn.prepareStatement("SELECT NAME, PRICE FROM GOODS");
            ResultSet rst = pstmt.executeQuery();
            while (rst.next()) {
                String name = rst.getString("NAME");
                double price = rst.getDouble("PRICE");
    %>
                goodsData.push({
                    name: '<%= name %>',
		price :
<%= price %>
	});
<%
            }
            rst.close();
            pstmt.close();
            conn.close();
        } catch (Exception e) {
            out.println("오류: " + e.getMessage());
        }
    %>
	
</script>
<script type="text/javascript" src="https://translate.google.com/translate_a/element.js?cb=googleTranslateElementInit"></script>
	<div id="imageContainer"></div>
	<h2></h2>

<!-- 버튼 영역 -->
<div id="buttonAndInput">

<!-- 업로드영역 -->
<div id="uploadArea" class="upload-area">	

<!-- 업로드영역 Header -->
  <div class="upload-area__header">
    <h1 class="upload-area__title">Upload your file</h1>
    <p class="upload-area__paragraph">
      File should be an image
      <strong class="upload-area__tooltip">
        Like
        <span class="upload-area__tooltip-data"></span> <!-- Data Will be Comes From Js -->
      </strong>
    </p>
  </div>

  	<!-- 파일선택 박스 -->
  	<div id="dropZoon" class="upload-area__drop-zoon drop-zoon">
	    <!-- 사진미리보기 -->
    <div class="" id="image_container"></div> 
  		
	    <label for="fileInput" id="fileLabel">
	    <span class="drop-zoon__icon" style="justify-content: center">
	      <i class='bx bxs-file-image'></i>
	    </span>
	    <p class="drop-zoon__paragraph">Drop your file here or Click to browse</p>
	    <span id="loadingText" class="drop-zoon__loading-text">Please Wait</span>
	    
	    <img src="" alt="Preview Image" id="previewImage" class="drop-zoon__preview-image" draggable="false">
	  	
	  	<!-- 파일선택,선택된 파일없음 -->
<!-- 	  	<input type="file" id="fileInput" accept="img/*" onchange="changeUpload()"> -->	  	
	  	</label>	
		<style>
		#image_container {
			position: absolute;
		  	z-index: 1;
		}
		
		</style>
  	</div>



  
<!-- 업로드파일 디테일 -->
  <div id="fileDetails" class="upload-area__file-details file-details">
    <h3 class="file-details__title">Uploaded File</h3>

    <div id="uploadedFile" class="uploaded-file">
      <div class="uploaded-file__icon-container">
        <i class='bx bxs-file-blank uploaded-file__icon'></i>
        <span class="uploaded-file__icon-text"></span> <!-- Data Will be Comes From Js -->
      </div>

      <div id="uploadedFileInfo" class="uploaded-file__info">
        <span class="uploaded-file__name">Proejct 1</span>
        <span class="uploaded-file__counter">0%</span>
      </div>
    </div>
  </div>
  
  

	
	
	
    <br>
	<!-- 파일선택,선택된 파일없음 -->
	<input type="file" id="fileInput" accept="img/*" onchange="changeUpload()">
	
	
    
    
  
	<!-- 식별 버튼 -->
	  <button type="button" id="uploadButton" onmouseover="changeUpload('mouseover')" onmouseout="changeUpload('mouseout')" onclick="changeUpload('click')">식별</button>


	
	<div id="resultContainer" style='text-align: center;'></div>
	<form action="../../../include/select/aiSelect/solsubmit.jsp">
		<input type="hidden" name="totalPrice" value="">
		<input type="hidden" name="PROD1" value="">
		<input type="hidden" name="PROD1_PRICE" value="">
		<input type="hidden" name="PROD2" value="">
		<input type="hidden" name="PROD2_PRICE" value="">
		<input type="hidden" name="PROD3" value="">
		<input type="hidden" name="PROD3_PRICE" value="">
		<input type="hidden" name="PROD4" value="">
		<input type="hidden" name="PROD4_PRICE" value="">
		<input type="hidden" name="PROD5" value="">
		<input type="hidden" name="PROD5_PRICE" value="">
		<input type="hidden" name="PROD6" value="">
		<input type="hidden" name="PROD6_PRICE" value="">
    <script>
    const fileInput = document.getElementById("fileInput");
    const fileLabel = document.getElementById("fileLabel");
    const uploadName = document.getElementById("uploadName");
    const uploadButton = document.getElementById("uploadButton");
    const resultContainer = document.getElementById("resultContainer");
    const h2Element = document.querySelector("h2");
    const body = document.body;

    // 로고 표시
    const imageContainer = document.getElementById('imageContainer');
    const imageElement = document.createElement('img');
    imageElement.src = '../../../assets/img/logo.png';

    // 이미지를 imageContainer에 추가
    imageContainer.appendChild(imageElement);

    // body
    body.style.display = 'flex';
    body.style.flexDirection = 'column';
    body.style.alignItems = 'center';
    body.style.justifyContent = 'center';

    // h2
    h2Element.style.fontSize = "24px";
    h2Element.style.color = "#5C5D5D";
    h2Element.style.textAlign = 'center';

    // 파일 선택과 식별 버튼을 같은 줄에
    const buttonAndInput = document.createElement('div');
    buttonAndInput.style.display = 'flex';
    buttonAndInput.style.alignItems = 'center';

    // 기존에 있던 '파일 선택' 버튼과 파일명 표시하는 부분은 숨김
//     fileInput.style.position = "absolute";
//     fileInput.style.width = "0";
//     fileInput.style.height = "0";
//     fileInput.style.padding = "0";
//     fileInput.style.border = "0";

    // 새로 생성한 파일 선택 버튼(레이블)
//     fileLabel.style.backgroundColor = '#f0f0f0';
    fileLabel.style.width = "500px";
    fileLabel.style.height = "100px";
    fileLabel.style.marginLeft = "0px";
    fileLabel.style.padding = "10px 20px";

    // 호버, 클릭 시 색 변경 함수
    function changeInput(eventType) {
      if (eventType === 'mouseover') {
        fileLabel.style.backgroundColor = '#e0e0e0';
      } else if (eventType === 'mouseout') {
        fileLabel.style.backgroundColor = '#f0f0f0';
      } else if (eventType === 'click') {
        fileLabel.style.backgroundColor = '#d0d0d0';
      }
    }
   
    // 새로 생성한 파일명 표시하는 부분
//     uploadName.style.color = "#d3d3d3";
//     uploadName.style.fontSize = "16px";
//     uploadName.style.border = "none";
//     uploadName.style.display = "inline-block";
//     uploadName.style.padding = "12px 20px";
//     uploadName.style.marginLeft = "10px";
    

    // 업로드 버튼
    uploadButton.style.backgroundColor = "#7ABDE9";
    uploadButton.style.color = "white";
    uploadButton.style.fontSize = "16px";
    uploadButton.style.fontFamily = "malgunGothic";
    uploadButton.style.border = "none";
    uploadButton.style.margin = '10px 0';
    uploadButton.style.padding = "10px 20px";

    // 호버, 클릭 시 색 변경 함수
    function changeUpload(eventType) {
      if (eventType === 'mouseover') {
        uploadButton.style.backgroundColor = '#A4D1F0';
      } else if (eventType === 'mouseout') {
        uploadButton.style.backgroundColor = '#7ABDE9';
      } else if (eventType === 'click') {
        uploadButton.style.backgroundColor = '#A4D1F0';
        
      }
    }
    
    // 이미지 미리보기
	 function changeUpload() {
	    const reader = new FileReader();
	
	    reader.onload = function(event) {
	      const img = document.createElement('img');
	      img.setAttribute('src', event.target.result);
	      document.querySelector('#image_container').appendChild(img);
	   
	    };
	
	    reader.readAsDataURL(event.target.files[0]);
	  }
    // 이미지 미리보기 크기
    function changeUpload() {
	  const reader = new FileReader();
	
	  reader.onload = function(event) {
	    const img = document.createElement('img');
	    img.setAttribute('src', event.target.result);
	    img.style.width = '175px';
	    
	    document.querySelector('#image_container').appendChild(img);
	  };
	
	  reader.readAsDataURL(event.target.files[0]);
	}
    
    
    

    // 결과창
    resultContainer.style.fontFamily = "malgunGothic";
    resultContainer.style.textAlign ="center";

    // 클래스 이름 번역 함수
    async function translateClassName(className) {
      try {
        const response = await fetch(`https://translation.googleapis.com/language/translate/v2?key=AIzaSyAudjpTypPWJYwQeCpwwifiwJPWFpRmML8`, {
          method: 'POST',
          headers: {
            'Content-Type': 'application/json',
          },
          body: JSON.stringify({
            q: className,
            target: 'ko',
          }),
        });

        const data = await response.json();
        if (data && data.data && data.data.translations && data.data.translations[0]) {
          return data.data.translations[0].translatedText;
        } else {
          return className;
        }
      } catch (error) {
        console.error('번역 오류:', error);
        return className;
      }
    }

    async function loadImageBase64(file) {
      return new Promise((resolve, reject) => {
        const reader = new FileReader();
        reader.readAsDataURL(file);
        reader.onload = () => resolve(reader.result);
        reader.onerror = (error) => reject(error);
      });
    }

    const classPrices = {};

    goodsData.forEach(item => {
      classPrices[item.name] = item.price;
    });

    document.getElementById("uploadButton").addEventListener("click", async () => {
      const fileInput = document.getElementById("fileInput");
      const file = fileInput.files[0];
      const resultContainer = document.getElementById("resultContainer");

      if (!file) {
        alert("이미지 파일을 선택해주세요.");
        return;
      }

      try {
        const image = await loadImageBase64(file);

        const response = await axios({
          method: "POST",
          url: "https://detect.roboflow.com/indoor-zrujv/1",
          params: {
            api_key: "xWix8kvq3rK2f2b3ljxR"
          },
          data: image,
          headers: {
            "Content-Type": "application/x-www-form-urlencoded"
          }
        });

        const classValues = response.data.predictions.map(prediction => prediction.class);

        const classCount = {};
        let totalPrice = 0;

        classValues.forEach(classValue => {
          if (classCount[classValue]) {
            classCount[classValue]++;
          } else {
            classCount[classValue] = 1;
          }
          totalPrice += classPrices[classValue] || 0;
                const totalValueInput = document.querySelector('input[name="totalPrice"]');
    	        if (totalValueInput) {
    	          totalValueInput.value = totalPrice;
    	        }
        });

        let resultHTML = "<p style='font-weight: bold; font-size: 24px; font-family: malgunGothic; color: #5C5D5D;'>분석 결과</p><ul>";
        const classNameArray = []; // 클래스 이름을 저장할 배열
        const classTotalPriceArray = []; // 클래스 총 가격을 저장할 배열
        for (const className in classCount) {
          const translatedClassName = await translateClassName(className);
          const classPrice = classPrices[className] || 0;
          const classTotalPrice = classPrice * classCount[className];
          
          // 배열에 값을 추가
          classNameArray.push(className);
          classTotalPriceArray.push(classTotalPrice);
          
          resultHTML += "<li>" + translatedClassName + ": " + classCount[className] + "개, " + classTotalPrice + "원&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</li>";
        }
        resultHTML += "</ul>";
        resultHTML += "<p style='font-family: malgunGothic;'>합계 : " + totalPrice + "원</p>";
        console.log(classNameArray);
        console.log(classTotalPriceArray);
        
        const classNameInput1 = document.querySelector('input[name="PROD1"]');
        const classNameInput2 = document.querySelector('input[name="PROD2"]');
        const classNameInput3 = document.querySelector('input[name="PROD3"]');
        const classNameInput4 = document.querySelector('input[name="PROD4"]');
        const classNameInput5 = document.querySelector('input[name="PROD5"]');
        const classNameInput6 = document.querySelector('input[name="PROD6"]');
        
        classNameInput1.value = classNameArray[0];
        classNameInput2.value = classNameArray[1];
        classNameInput3.value = classNameArray[2];
        classNameInput4.value = classNameArray[3];
        classNameInput5.value = classNameArray[4];
        classNameInput6.value = classNameArray[5];
        
        const classTotalPriceInput1 = document.querySelector('input[name="PROD1_PRICE"]');
        const classTotalPriceInput2 = document.querySelector('input[name="PROD2_PRICE"]');
        const classTotalPriceInput3 = document.querySelector('input[name="PROD3_PRICE"]');
        const classTotalPriceInput4 = document.querySelector('input[name="PROD4_PRICE"]');
        const classTotalPriceInput5 = document.querySelector('input[name="PROD5_PRICE"]');
        const classTotalPriceInput6 = document.querySelector('input[name="PROD6_PRICE"]');
        
        classTotalPriceInput1.value = classTotalPriceArray[0];
        classTotalPriceInput2.value = classTotalPriceArray[1];
        classTotalPriceInput3.value = classTotalPriceArray[2];
        classTotalPriceInput4.value = classTotalPriceArray[3];
        classTotalPriceInput5.value = classTotalPriceArray[4];
        classTotalPriceInput6.value = classTotalPriceArray[5];
        
        resultContainer.innerHTML = resultHTML;
      } catch (error) {
        console.error(error.message);
      }
    });
 	
    
    
    </script>
    </div>
</div>
    <br>
  	<button type="submit" id="submit" style="height:40px; background-color:#1363c6; color:white; border:0;">다음 화면으로</button>
	</form>  
  	
	               
            </div>
        </div>
    </div>
 


    
    <!-- Case End -->


    <!-- FAQs Start -->
    <div class="container-fluid py-5">
        <div class="container py-5">
            <div class="mx-auto text-center wow fadeIn" data-wow-delay="0.1s" style="max-width: 500px;">
                <div class="btn btn-sm border rounded-pill text-primary px-3 mb-3">Popular FAQs</div>
                <h1 class="mb-4">Frequently Asked Questions</h1>
            </div>
            <div class="row">
                <div class="col-lg-6">
                    <div class="accordion" id="accordionFAQ1">
                        <div class="accordion-item wow fadeIn" data-wow-delay="0.1s">
                            <h2 class="accordion-header" id="headingOne">
                                <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse"
                                    data-bs-target="#collapseOne" aria-expanded="false" aria-controls="collapseOne">
                                    How to build a website?
                                </button>
                            </h2>
                            <div id="collapseOne" class="accordion-collapse collapse" aria-labelledby="headingOne"
                                data-bs-parent="#accordionFAQ1">
                                <div class="accordion-body">
                                    Dolor nonumy tempor elitr et rebum ipsum sit duo duo. Diam sed sed magna et magna diam aliquyam amet dolore ipsum erat duo. Sit rebum magna duo labore no diam.
                                </div>
                            </div>
                        </div>
                        <div class="accordion-item wow fadeIn" data-wow-delay="0.2s">
                            <h2 class="accordion-header" id="headingTwo">
                                <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse"
                                    data-bs-target="#collapseTwo" aria-expanded="false" aria-controls="collapseTwo">
                                    How long will it take to get a new website?
                                </button>
                            </h2>
                            <div id="collapseTwo" class="accordion-collapse collapse" aria-labelledby="headingTwo"
                                data-bs-parent="#accordionFAQ1">
                                <div class="accordion-body">
                                    Dolor nonumy tempor elitr et rebum ipsum sit duo duo. Diam sed sed magna et magna diam aliquyam amet dolore ipsum erat duo. Sit rebum magna duo labore no diam.
                                </div>
                            </div>
                        </div>
                        <div class="accordion-item wow fadeIn" data-wow-delay="0.3s">
                            <h2 class="accordion-header" id="headingThree">
                                <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse"
                                    data-bs-target="#collapseThree" aria-expanded="false" aria-controls="collapseThree">
                                    Do you only create HTML websites?
                                </button>
                            </h2>
                            <div id="collapseThree" class="accordion-collapse collapse" aria-labelledby="headingThree"
                                data-bs-parent="#accordionFAQ1">
                                <div class="accordion-body">
                                    Dolor nonumy tempor elitr et rebum ipsum sit duo duo. Diam sed sed magna et magna diam aliquyam amet dolore ipsum erat duo. Sit rebum magna duo labore no diam.
                                </div>
                            </div>
                        </div>
                        <div class="accordion-item wow fadeIn" data-wow-delay="0.4s">
                            <h2 class="accordion-header" id="headingFour">
                                <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse"
                                    data-bs-target="#collapseFour" aria-expanded="true" aria-controls="collapseFour">
                                    Will my website be mobile-friendly?
                                </button>
                            </h2>
                            <div id="collapseFour" class="accordion-collapse collapse" aria-labelledby="headingFour"
                                data-bs-parent="#accordionFAQ1">
                                <div class="accordion-body">
                                    Dolor nonumy tempor elitr et rebum ipsum sit duo duo. Diam sed sed magna et magna diam aliquyam amet dolore ipsum erat duo. Sit rebum magna duo labore no diam.
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-lg-6">
                    <div class="accordion" id="accordionFAQ2">
                        <div class="accordion-item wow fadeIn" data-wow-delay="0.5s">
                            <h2 class="accordion-header" id="headingFive">
                                <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse"
                                    data-bs-target="#collapseFive" aria-expanded="false" aria-controls="collapseFive">
                                    Will you maintain my site for me?
                                </button>
                            </h2>
                            <div id="collapseFive" class="accordion-collapse collapse" aria-labelledby="headingFive"
                                data-bs-parent="#accordionFAQ2">
                                <div class="accordion-body">
                                    Dolor nonumy tempor elitr et rebum ipsum sit duo duo. Diam sed sed magna et magna diam aliquyam amet dolore ipsum erat duo. Sit rebum magna duo labore no diam.
                                </div>
                            </div>
                        </div>
                        <div class="accordion-item wow fadeIn" data-wow-delay="0.6s">
                            <h2 class="accordion-header" id="headingSix">
                                <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse"
                                    data-bs-target="#collapseSix" aria-expanded="false" aria-controls="collapseSix">
                                    I’m on a strict budget. Do you have any low cost options?
                                </button>
                            </h2>
                            <div id="collapseSix" class="accordion-collapse collapse" aria-labelledby="headingSix"
                                data-bs-parent="#accordionFAQ2">
                                <div class="accordion-body">
                                    Dolor nonumy tempor elitr et rebum ipsum sit duo duo. Diam sed sed magna et magna diam aliquyam amet dolore ipsum erat duo. Sit rebum magna duo labore no diam.
                                </div>
                            </div>
                        </div>
                        <div class="accordion-item wow fadeIn" data-wow-delay="0.7s">
                            <h2 class="accordion-header" id="headingSeven">
                                <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse"
                                    data-bs-target="#collapseSeven" aria-expanded="false" aria-controls="collapseSeven">
                                    Will you maintain my site for me?
                                </button>
                            </h2>
                            <div id="collapseSeven" class="accordion-collapse collapse" aria-labelledby="headingSeven"
                                data-bs-parent="#accordionFAQ2">
                                <div class="accordion-body">
                                    Dolor nonumy tempor elitr et rebum ipsum sit duo duo. Diam sed sed magna et magna diam aliquyam amet dolore ipsum erat duo. Sit rebum magna duo labore no diam.
                                </div>
                            </div>
                        </div>
                        <div class="accordion-item wow fadeIn" data-wow-delay="0.8s">
                            <h2 class="accordion-header" id="headingEight">
                                <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse"
                                    data-bs-target="#collapseEight" aria-expanded="false" aria-controls="collapseEight">
                                    I’m on a strict budget. Do you have any low cost options?
                                </button>
                            </h2>
                            <div id="collapseEight" class="accordion-collapse collapse" aria-labelledby="headingEight"
                                data-bs-parent="#accordionFAQ2">
                                <div class="accordion-body">
                                    Dolor nonumy tempor elitr et rebum ipsum sit duo duo. Diam sed sed magna et magna diam aliquyam amet dolore ipsum erat duo. Sit rebum magna duo labore no diam.
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!-- FAQs Start -->


    <!-- Newsletter Start -->
    <div class="container-fluid bg-primary newsletter py-5">
        <div class="container">
            <div class="row g-5 align-items-center">
                <div class="col-md-5 ps-lg-0 pt-5 pt-md-0 text-start wow fadeIn" data-wow-delay="0.3s">
                    <img class="img-fluid" src="../../../assets/img/newsletter.png" alt="">
                </div>
                <div class="col-md-7 py-5 newsletter-text wow fadeIn" data-wow-delay="0.5s">
                    <div class="btn btn-sm border rounded-pill text-white px-3 mb-3">Newsletter</div>
                    <h1 class="text-white mb-4">Let's subscribe the newsletter</h1>
                    <div class="position-relative w-100 mt-3 mb-2">
                        <input class="form-control border-0 rounded-pill w-100 ps-4 pe-5" type="text"
                            placeholder="Enter Your Email" style="height: 48px;">
                        <button type="button" class="btn shadow-none position-absolute top-0 end-0 mt-1 me-2"><i
                                class="fa fa-paper-plane text-primary fs-4"></i></button>
                    </div>
                    <small class="text-white-50">Diam sed sed dolor stet amet eirmod</small>
                </div>
            </div>
        </div>
    </div>
    <!-- Newsletter End -->


    <!-- Footer Start -->
    <div class="container-fluid bg-dark text-white-50 footer pt-5">
        <div class="container py-5">
            <div class="row g-5">
                <div class="col-md-6 col-lg-3 wow fadeIn" data-wow-delay="0.1s">
                    <a href="../../../include/index.jsp" class="d-inline-block mb-3">
                        <h1 class="text-white">AI<span class="text-primary">.</span>Tech</h1>
                    </a>
                    <p class="mb-0">Tempor erat elitr rebum at clita. Diam dolor diam ipsum et tempor sit. Aliqu diam
                        amet diam et eos labore. Clita erat ipsum et lorem et sit, sed stet no labore lorem sit. Sanctus
                        clita duo justo et tempor</p>
                </div>
                <div class="col-md-6 col-lg-3 wow fadeIn" data-wow-delay="0.3s">
                    <h5 class="text-white mb-4">Get In Touch</h5>
                    <p><i class="fa fa-map-marker-alt me-3"></i>123 Street, New York, USA</p>
                    <p><i class="fa fa-phone-alt me-3"></i>+012 345 67890</p>
                    <p><i class="fa fa-envelope me-3"></i>info@example.com</p>
                    <div class="d-flex pt-2">
                        <a class="btn btn-outline-light btn-social" href=""><i class="fab fa-twitter"></i></a>
                        <a class="btn btn-outline-light btn-social" href=""><i class="fab fa-facebook-f"></i></a>
                        <a class="btn btn-outline-light btn-social" href=""><i class="fab fa-youtube"></i></a>
                        <a class="btn btn-outline-light btn-social" href=""><i class="fab fa-instagram"></i></a>
                        <a class="btn btn-outline-light btn-social" href=""><i class="fab fa-linkedin-in"></i></a>
                    </div>
                </div>
                <div class="col-md-6 col-lg-3 wow fadeIn" data-wow-delay="0.5s">
                    <h5 class="text-white mb-4">Popular Link</h5>
                    <a class="btn btn-link" href="">About Us</a>
                    <a class="btn btn-link" href="">Contact Us</a>
                    <a class="btn btn-link" href="">Privacy Policy</a>
                    <a class="btn btn-link" href="">Terms & Condition</a>
                    <a class="btn btn-link" href="">Career</a>
                </div>
                <div class="col-md-6 col-lg-3 wow fadeIn" data-wow-delay="0.7s">
                    <h5 class="text-white mb-4">Our Services</h5>
                    <a class="btn btn-link" href="">Robotic Automation</a>
                    <a class="btn btn-link" href="">Machine learning</a>
                    <a class="btn btn-link" href="">Predictive Analysis</a>
                    <a class="btn btn-link" href="">Data Science</a>
                    <a class="btn btn-link" href="">Robot Technology</a>
                </div>
            </div>
        </div>
        <div class="container wow fadeIn" data-wow-delay="0.1s">
            <div class="copyright">
                <div class="row">
                    <div class="col-md-6 text-center text-md-start mb-3 mb-md-0">
                        &copy; <a class="border-bottom" href="#">Your Site Name</a>, All Right Reserved.

                        <!--/*** This template is free as long as you keep the footer author’s credit link/attribution link/backlink. If you'd like to use the template without the footer author’s credit link/attribution link/backlink, you can purchase the Credit Removal License from "https://htmlcodex.com/credit-removal". Thank you for your support. ***/-->
                        Designed By <a class="border-bottom" href="https://htmlcodex.com">HTML Codex</a> Distributed By <a class="border-bottom" href="https://themewagon.com">ThemeWagon</a>
                    </div>
                    <div class="col-md-6 text-center text-md-end">
                        <div class="footer-menu">
                            <a href="">Home</a>
                            <a href="">Cookies</a>
                            <a href="">Help</a>
                            <a href="">FAQs</a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!-- Footer End -->


    <!-- Back to Top -->
    <a href="#" class="btn btn-lg btn-primary btn-lg-square back-to-top pt-2"><i class="bi bi-arrow-up"></i></a>


    <!-- JavaScript Libraries -->
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0/dist/js/bootstrap.bundle.min.js"></script>
    <script src="lib/wow/wow.min.js"></script>
    <script src="lib/easing/easing.min.js"></script>
    <script src="lib/waypoints/waypoints.min.js"></script>
    <script src="lib/counterup/counterup.min.js"></script>
    <script src="lib/owlcarousel/owl.carousel.min.js"></script>
	
    <!-- Template Javascript -->
    <script src="../../../assets/js/main.js"></script>
</body>

</html>