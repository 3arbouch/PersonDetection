
function indicesNonFacesToTake= test(indicesNonFaces, numberToTake)
indicesNonFacesToTake= zeros(1,numberToTake)  ; 
for i=1:numberToTake
    index = randi([1 length(indicesNonFaces)],1,1) ;
    indicesNonFacesToTake(i) = indicesNonFaces(index) ;   
    indicesNonFaces(index) = []  ; 
    
end


end