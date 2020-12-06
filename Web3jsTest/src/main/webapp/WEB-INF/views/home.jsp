<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" %>
<html>
<head>
	<title>Home</title>
	<meta charset="UTF-8">
	<link rel="shortcut icon" href="resources/images/favicon.ico">
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/2.1.3/jquery.min.js"></script>
	<script src="resources/js/web3.min.js"></script>
	<script type="text/javascript">
		window.addEventListener('load', function () {
			if(typeof web3 !== 'undefined') {
				console.log('Web3 Detected! ' + web3.currentProvider.constructor.name);
				window.web3 = new Web3(web3.currentProvider);
			} else {
				console.log('No Web3 Detected.. using HTTP Provider!!');
				window.web3 = new Web3(new Web3.providers.HttpProvider("https://ropsten.infura.io/v3/c788b125a7fb4664a4b005fa600804d3"));
			}
		})
		function getBalance() {
			var address, wei, balance
			address = '0x7a16340630847246c440c9AD67437051B2C067E9';
			try{
				web3.eth.getBalance(address, function(error, wei) {
					if(!error) {
						var balance = web3.utils.fromWei(wei, 'ether');
						document.getElementById("output").innerHTML = balance + "ETH";
					}
				});
			} catch (err) {
				document.getElementById("output").innerHTML = err;
			}
		}
		function transfer(from, to, value, callback) {
			var web3 = new Web3(new Web3.providers.HttpProvider("https://ropsten.infura.io/v3/c788b125a7fb4664a4b005fa600804d3"));
			from = '0x7a16340630847246c440c9AD67437051B2C067E9';
			to = '0x3A64c0511c49E73040D4adB19C47dBb7e0567Aae';
			
			value = '1';
			
			var chgValue = web3.eth.toWei(value,'ether');
			console.log("chgValue : " + chgValue);
			
			var nonce = web3.eth.getTransactionCount("0x7a16340630847246c440c9AD67437051B2C067E9").then(console.log);
			console.log("nonce : " + nonce);
			
			
			var gas = 150000;
			var StrGas = gas.toString(16);
			console.log("StrGas : " + StrGas);
			
			var gasPrice = web3.eth.getGasPrice().then(console.log);
			console.log("gasPrice : " + gasPrice);
			var NumGasPrice = Number(gasPrice);
			console.log("NumGasPrice : " + NumGasPrice);
			var StrGasPrice = NumGasPrice.toString(16);
			console.log("StrGasPrice : " + StrGasPrice);
			
			web3.eth.sendTransaction({
				from: from,
				to: to,
				value: chgValue,
				gas: StrGas,
				gasPrice: StrGasPrice
			}, function (err, hash) {
				if (err) {
					return callback(err, '');
				} else {
					return callback(null, hash);
				}
			});
		}
		
		
	</script>
	
	
	
</head>
<body>
	
	<button type="button" onClick="getBalance();">get balance</button>
	<br/>
	<br/>
	<div id="output"></div>
	<br/>
	<br/>
	<br/>
	<br/>
	<br/>
	<button type="button" onClick="transfer();">Transfer</button>
	
	
	
</body>
</html>
