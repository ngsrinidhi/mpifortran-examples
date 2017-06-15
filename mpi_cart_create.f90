program main 
use mpi 

implicit none 

integer ierr, np, rank, procs
integer global_rank 
integer dims(1),outdims(1)
logical periods(1),outperiods(1)
logical,parameter::reorder=.false.  
integer cart2d
integer local 
integer nnodes 
integer maxdims 
integer coords(1),outcoords(1)
integer source,dest 

periods(1)=.false.;
local=mpi_comm_world

call mpi_init(ierr)
call mpi_comm_size (local, np, ierr)
call mpi_comm_rank (local, global_rank, ierr)

dims(:)=0; coords(:)=0; outcoords(:)=0
!dims(1)=2; dims(2)=3; 
call mpi_dims_create(np,1,dims,ierr) 

maxdims=1; 
 
call mpi_cart_create(local,1,dims,periods,reorder,cart2d,ierr) 

call mpi_cart_shift(cart2d,0,1,source,dest,ierr)
write(*,*) "source value is", source
write(*,*) "destination value is", dest 

call mpi_cart_get(cart2d,maxdims,outdims,outperiods,outcoords,ierr)
call mpi_cart_coords(cart2d,global_rank,1,coords,ierr) 

write(*,*) "writing the coordinates"
write(*,*) coords 
!write(*,*) "writing out coordinate"
!write(*,*) outcoords 

call mpi_finalize(ierr) 
end program 


