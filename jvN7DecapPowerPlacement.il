* Author       Joel Viray
 * Language     SKILL
 * Date         July 7, 2019
 *
 * Auto remove decap_power power pcell (tsmcN7_Inphi_pCells/powergrid_v2/layout). 
 *
 *  
 */


procedure(abGetOverlapShape(overlap)
  if(listp(overlap) then
      abGetOverlapShape(cadr(overlap))
  else
      overlap
  );if
);procedure

cv=geGetEditCellView()

procedure(jvN7DecapPowerPlacement_remove()


    foreach(decap_power geGetSelSet()

        decapPowerBbox=decap_power~>bBox

        x1bbox=xCoord(lowerLeft(decapPowerBbox))
		y1bbox=yCoord(lowerLeft(decapPowerBbox))
        x2bbox=xCoord(upperRight(decapPowerBbox))
		y2bbox=yCoord(upperRight(decapPowerBbox))

        reduced_decapPowerBbox=list(x1bbox+0.1:y1bbox+0.1 x2bbox-0.1:y2bbox-0.1)

        
        M10_overlaps=dbProduceOverlap(cv reduced_decapPowerBbox 32 list("M10" "drawing"))
        M11_overlaps=dbProduceOverlap(cv reduced_decapPowerBbox 32 list("M11" "drawing"))
        M12_overlaps=dbProduceOverlap(cv reduced_decapPowerBbox 32 list("M12" "drawing"))
        M13_overlaps=dbProduceOverlap(cv reduced_decapPowerBbox 32 list("M13" "drawing"))




        flattened_M10_overlaps=foreach(mapcar overlap M10_overlaps
                              srcShape=abGetOverlapShape(overlap)
                              ;dbCopyFig(srcShape cv dbGetHierPathTransform(overlap))
                              );foreach

        flattened_M11_overlaps=foreach(mapcar overlap M11_overlaps
                              srcShape=abGetOverlapShape(overlap)
                              ;dbCopyFig(srcShape cv dbGetHierPathTransform(overlap))
                              );foreach

        flattened_M12_overlaps=foreach(mapcar overlap M12_overlaps
                              srcShape=abGetOverlapShape(overlap)
                              ;dbCopyFig(srcShape cv dbGetHierPathTransform(overlap))
                              );foreach

        flattened_M13_overlaps=foreach(mapcar overlap M13_overlaps
                              srcShape=abGetOverlapShape(overlap)
                              ;dbCopyFig(srcShape cv dbGetHierPathTransform(overlap))
                              );foreach




        if(length(flattened_M10_overlaps)>2||length(flattened_M11_overlaps)>2||length(flattened_M12_overlaps)>2||length(flattened_M13_overlaps)>2
            then
            dbDeleteObject(decap_power)
        );if
      
               
    );foreach

);procedure


