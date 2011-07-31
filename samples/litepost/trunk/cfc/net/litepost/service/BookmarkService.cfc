<!--- 
	  
  Copyright (c) 2006, Chris Scott, Matt Woodward, Adam Wayne Lehman, Dave Ross
  All rights reserved.
	
  Licensed under the Apache License, Version 2.0 (the "License");
  you may not use this file except in compliance with the License.
  You may obtain a copy of the License at
  
       http://www.apache.org/licenses/LICENSE-2.0
  
  Unless required by applicable law or agreed to in writing, software
  distributed under the License is distributed on an "AS IS" BASIS,
  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
  See the License for the specific language governing permissions and
  limitations under the License.

  $Id: BookmarkService.cfc 2 2006-10-16 20:42:26Z mpwoodward $

--->

<cfcomponent displayname="BookmarkService" hint="Abstract service for Bookmark">

	<cffunction name="init" returntype="void">
		<cfthrow type="InvalidConstructor" message="abstract component 'BookmarkService' cannot be instantiated"/>
	</cffunction>
	
</cfcomponent>