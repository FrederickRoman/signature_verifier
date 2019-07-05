function cropSignaturesFromScans(signature_sheet_header, isReal, author, startPage, endPage)
%CROPSIGNATURESFROMSCANS Calls cropSignaturesFromScan for all signature
%sheets
%The signature files should be of the form: 'Will_p1.jpeg'
%Then call the function using: 
%cropSignaturesFromScans('Will', 'Real', 'Will', 1, 4) etc

for p = startPage:endPage
    file_name = [signature_sheet_header '_p' num2str(p) '.jpeg'];
    cropSignaturesFromScan(file_name, isReal, author, p)
end


end

