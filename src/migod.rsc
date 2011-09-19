module migod

// Libs
import List;
import IO;

// Locals
import Statistics;
import experiments::scm::Scm;
import experiments::scm::git::Git;
import experiments::scm::svn::Svn;
import experiments::scm::cvs::Cvs;

// Some constants
public str homeDir = "/Users/migod";
public str workspace = homeDir + "Documents/workspace";
str linuxVID = "2.6";
public str linuxGitLocation = homeDir + "/Desktop/linux-" + linuxVID;
public list[ChangeSet] migodChanges;

// Below line should prbably get put into experiment::cscm::cvs
data Connection = pserver(str url, str host, str username, str password);

public void getGitExample () {
	println (linuxGitLocation);
	Repository repo = git(fs(linuxGitLocation), "", {});
	// the below crashes
	list[ChangeSet] resourceChanges = getChanges(repo); 
	println(size(resourceChanges));
}

public void getSvnExample () {
    Repository repo = svn(ssh("svn+ssh://svn.cwi.nl", "migod", "", |file:///Users/migod/.ssh/migod_rascal_rsa|), "", |file:///Users/migod/Rascal/svnWorkingCopy|,{});
	
	// This seems to work, the number of changes reported is the same 
	// as SVN reports withing Eclipse.
	list[ChangeSet] resourceChanges = getChanges(repo);
	println ("\nNumber of resource changes: <size(resourceChanges)>");
	// print (resourceChanges);
	migodChanges = {cs | cs <- resourceChanges, cs.committer.name=="migod"};
}

public void getSvnExample2 () {
    Repository repo = svn(ssh("svn+ssh://sulphur.cs.uvic.ca/var/svn/papersJulius/2011/msrJese2011paper", "migod", "", |file:///Users/migod/.ssh/migod_rascal_rsa|), "", |file:///Users/migod/Rascal/svnWorkingCopy|,{});
	list[ChangeSet] resourceChanges = getChanges(repo);
	println ("\nNumber of resource changes: <size(resourceChanges)>");
	// print (resourceChanges);
	migodChanges = {cs | cs <- resourceChanges, cs.committer.name=="migod"};
}

public void getCvsExample () {
       // Probably I am not using the right parameters here.
       // pserver(str url, str repname, str host, str username, str password);
       // Connection cvsConnection = pserver("tortoisecvs.cvs.sourceforge.net/TortoiseCVS", "TortoiseCVS",
            //    "tortoisecvs.cvs.sourceforge.net", "anonymous", " ");
       	
       // data Connection = pserver(str url, str host, str username, str password);
       Connection cvsConnection = pserver("tortoisecvs.cvs.sourceforge.net:/cvsroot/tortoisecvs","tortoisecvs.cvs.sourceforge.net","anonymous", "");
       Repository repo = cvs(cvsConnection, "TortoiseCVS", |file:///Users/migod/Rascal/cvsWorkingCopy|,{});
       list[ChangeSet] resourceChanges = getChanges(repo);
       // This returns zero, but shouldn't
       println ("\nNumber of resource changes: <size(resourceChanges)>");
}


public void getCvsExample2 () {    	
       // data Connection = pserver(str url, str host, str username, str password);
       Connection cvsConnection = pserver("pserver.samba.org/cvsroot","pserver.samba.org","cvs", "");
       Repository repo = cvs(cvsConnection, "SambaCVS", |file:///Users/migod/Rascal/cvsWorkingCopy|,{});
       list[ChangeSet] resourceChanges = getChanges(repo);
       // This returns zero, but shouldn't
       println ("\nNumber of resource changes: <size(resourceChanges)>");
}

public void main () {
}