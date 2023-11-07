<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
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
<title>가구 식별</title>
</head>
<body>
   <script type="text/javascript" src="https://translate.google.com/translate_a/element.js?cb=googleTranslateElementInit"></script>
	<div id="imageContainer"></div>
	<h2>AI 가구 식별</h2>
	<div id="buttonAndInput">
		<label for="fileInput" id="fileLabel"
			onmouseover="changeInput('mouseover')"
			onmouseout="changeInput('mouseout')" onclick="changeInput('click')">파일
			선택 </label> <input id="uploadName" placeholder="첨부파일" disabled />
			 <input type="file" id="fileInput" accept="img/*">
		<button id="uploadButton" onmouseover="changeUpload('mouseover')" onmouseout="changeUpload('mouseout')" onclick="changeUpload('click')">식별</button>
	</div>
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
    fileInput.style.position = "absolute";
    fileInput.style.width = "0";
    fileInput.style.height = "0";
    fileInput.style.padding = "0";
    fileInput.style.border = "0";

    // 새로 생성한 파일 선택 버튼(레이블)
    fileLabel.style.backgroundColor = '#f0f0f0';
    fileLabel.style.height = "20px";
    fileLabel.style.marginLeft = "10px";
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
    uploadName.style.color = "#d3d3d3";
    uploadName.style.fontSize = "16px";
    uploadName.style.border = "none";
    uploadName.style.display = "inline-block";
    uploadName.style.padding = "12px 20px";
    uploadName.style.marginLeft = "10px";

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
  	<button type="submit" id="submit">다음 화면으로</button>
	</form>
</body>
</html>
