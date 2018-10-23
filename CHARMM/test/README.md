# Test

This folder provide an example of how to use solute tempering in CHARMM and a test script that verifies the solute tempering scales the potential energy appropriately.  To test if your CHARMM binary implements REST2 correctly, run `test.inp` file in the `test` folder.

    charmm < test.inp

If there is a problem with the REST2 implementation, you will see the following message.

    CHARMM>      assertion failed
    
          ***** LEVEL  0 WARNING FROM <CHARMM> *****
          ***** Unrecognized command: ASSE
          ******************************************
          BOMLEV (  0) IS REACHED - TERMINATING. WRNLEV IS  5
    
    
                                                      
                                /---------\           
                               /           \          
                              /             \         
                             /               \        
                             !  XXXX   XXXX  !        
                             !  XXXX   XXXX  !        
                             !  XXX     XXX  !        
                             !       X       !        
                              --\   XXX   /--         
                               ! !  XXX  ! !          
                               ! !       ! !          
                               ! I I I I I !          
                               !  I I I I  !          
                                \         /           
                                 --     --            
                                   \---/              
                            XXX             XXX       
                           XXXX             XXXX      
                           XXXXX           XXXXX      
                              XXX         XXX         
                                XXX     XXX           
                                   XXXXX              
                                  XXX XXX             
                                XXX     XXX           
                              XXX         XXX         
                           XXXXX           XXXXX      
                           XXXX             XXXX      
                            XXX             XXX       
    

# Command

CHARMM has a module named BLOCK, which provide a general syntax for scaling interaction energies.

    ! use BLOCK to scale the Hamiltonian
    set temp0 = 300
    set temp = 600
    calc scalepp = @temp0 / @temp
    calc scalepw = @scalepp ** 0.5
    
    block 2
      call 2 sele segid aglc end 
      coeff 1 1 1.0
      coeff 1 2 @scalepw
      coeff 2 2 @scalepp
    end
    
    
