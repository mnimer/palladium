<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE fusebox>
<!--
	fusebox.xml control file. Defines circuits, classes, parameters and global fuseactions.
-->
<fusebox>

	<circuits>
		<circuit alias="home" path="home/" parent="" />
		<circuit alias="entry" path="home/entry/" parent="home" />
		<circuit alias="comment" path="home/entry/comment/" parent="entry" />
		<circuit alias="bookmark" path="home/bookmark/" parent="" />
		<circuit alias="category" path="home/category/" parent="" />
		<circuit alias="login" path="home/login/" parent="home" />
	</circuits>

	<classes>
	</classes>

	<parameters>
		<parameter name="defaultFuseaction" value="entry.recent" />
		<parameter name="mode" value="development-full-load" />
		<parameter name="password" value="go" />
		<parameter name="fuseactionVariable" value="fuseaction" />
		<parameter name="precedenceFormOrUrl" value="form" />
		<parameter name="scriptFileDelimiter" value="cfm" />
		<parameter name="maskedFileDelimiters" value="htm,cfm,cfml,php,php4,asp,aspx" />
		<parameter name="characterEncoding" value="utf-8" />
		<paramater name="strictMode" value="false" />
		<parameter name="allowImplicitCircuits" value="false" />
		<parameter name="debug" value="false" />
	</parameters>

	<globalfuseactions>
		<appinit>
			<do action="home.initColdSpring" />
		</appinit>
		<preprocess>
			<do action="home.globalXFA" />
			<do action="category.getAll" />
			<do action="bookmark.getAll" />
			<do action="home.getSecurity" />
		</preprocess>
		<postprocess>
			<do action="home.output"/>
		</postprocess>
	</globalfuseactions>

	<plugins>
		<phase name="preProcess"></phase>
		<phase name="preFuseaction"></phase>
		<phase name="postFuseaction"></phase>
		<phase name="fuseactionException">
			<plugin name="CustomExceptionHandler" template="../plugins/CustomExceptionHandler.cfm">
				<parameter name="filePrefix" value="custom" />
				<parameter name="genericErrorTemplate" value="genericErrorMessage" />
			</plugin>
		</phase>
		<phase name="postProcess"></phase>
		<phase name="processError"></phase>
	</plugins>

</fusebox>
