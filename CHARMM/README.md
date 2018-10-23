# CHARMM REST2 Examples

To use REST2 in CHARMM, BLOCK module and REPDSTR module can be used. BLOCK module allows arbitrary scaling of energy terms and REPDSTR allows replica-exchange simulation. The CHARMM binary needs to be compiled with options that activates REPDSTR module.

    ./install.com gnu xlarge X86_64 M mpif90 +REPDSTR +ASYNC_PME +GENCOMM

# Test

To test if your CHARMM binary implements REST2 correctly, run `test.inp` file in the `test` folder.

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
    
# Examples

* `drude`: Simulation of `AAAAKAAAA` in Drude force field using REST2. The input/system files are provided courtesy of Fang-Yu Lin, Huang Jing, and Alex MacKerell.
