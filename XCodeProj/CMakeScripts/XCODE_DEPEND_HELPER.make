# DO NOT EDIT
# This makefile makes sure all linkable targets are
# up-to-date with anything they link to
default:
	echo "Do not invoke directly"

# Rules to remove targets that are older than anything to which they
# link.  This forces Xcode to relink the targets from scratch.  It
# does not seem to check these dependencies itself.
PostBuild.mpc.Debug:
/Users/Chili/Desktop/CarND-MPC-Project/XCodeProj/Debug/mpc:
	/bin/rm -f /Users/Chili/Desktop/CarND-MPC-Project/XCodeProj/Debug/mpc


PostBuild.mpc.Release:
/Users/Chili/Desktop/CarND-MPC-Project/XCodeProj/Release/mpc:
	/bin/rm -f /Users/Chili/Desktop/CarND-MPC-Project/XCodeProj/Release/mpc


PostBuild.mpc.MinSizeRel:
/Users/Chili/Desktop/CarND-MPC-Project/XCodeProj/MinSizeRel/mpc:
	/bin/rm -f /Users/Chili/Desktop/CarND-MPC-Project/XCodeProj/MinSizeRel/mpc


PostBuild.mpc.RelWithDebInfo:
/Users/Chili/Desktop/CarND-MPC-Project/XCodeProj/RelWithDebInfo/mpc:
	/bin/rm -f /Users/Chili/Desktop/CarND-MPC-Project/XCodeProj/RelWithDebInfo/mpc




# For each target create a dummy ruleso the target does not have to exist
