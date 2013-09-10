package org.act.od.impl.model
{
	/**
	 * The manager of FileID.
	 */
	public class FileIDManager{	
		
		private static var fileID:int = 0;

		public function FileIDManager(){
			
		}
		/**
		 * Create a new FileID and return it.
		 */
		public static function getAvailabelFileId() :String {
			return "File-" + ++fileID;
		}

	}
}