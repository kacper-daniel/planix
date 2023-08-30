double calculatedBalanceFromList(List<String> inputList){
  double value = 0;
  for (int i = 0; i < inputList.length; i++){
    value += double.parse(inputList[i].split(";")[1]);
  }
  return value;
}