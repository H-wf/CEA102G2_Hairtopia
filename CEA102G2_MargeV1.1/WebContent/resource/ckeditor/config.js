/**
 * @license Copyright (c) 2003-2021, CKSource - Frederico Knabben. All rights reserved.
 * For licensing, see https://ckeditor.com/legal/ckeditor-oss-license
 */

CKEDITOR.editorConfig = function( config ) {
	// Define changes to default configuration here. For example:
		config.language = 'zh';
	// config.uiColor = '#AADC6E';
		config.toolbarGroups = [
			{ name: 'document', groups: [ 'mode', 'document', 'doctools' ] },
			{ name: 'clipboard', groups: [ 'clipboard', 'undo' ] },
			{ name: 'editing', groups: [ 'find', 'selection', 'spellchecker', 'editing' ] },
			{ name: 'forms', groups: [ 'forms' ] },
			'/',
			{ name: 'basicstyles', groups: [ 'basicstyles', 'cleanup' ] },
			{ name: 'paragraph', groups: [ 'list', 'indent', 'blocks', 'align', 'bidi', 'paragraph' ] },
			{ name: 'links', groups: [ 'links' ] },
			{ name: 'insert', groups: [ 'insert' ] },
			'/',
			{ name: 'styles', groups: [ 'styles' ] },
			{ name: 'colors', groups: [ 'colors' ] },
			{ name: 'tools', groups: [ 'tools' ] },
			{ name: 'others', groups: [ 'others' ] },
			{ name: 'about', groups: [ 'about' ] }
		];

		config.removeButtons = 'Source,Save,NewPage,ExportPdf,Preview,Print,Templates,Cut,Copy,Paste,PasteText,Replace,Find,SelectAll,Scayt,Checkbox,Radio,TextField,Button,ImageButton,HiddenField,Superscript,Subscript,Strike,Indent,Outdent,CreateDiv,Blockquote,JustifyBlock,JustifyRight,JustifyCenter,JustifyLeft,Language,BidiRtl,BidiLtr,Anchor,Unlink,Link,Flash,SpecialChar,PageBreak,Iframe,Image,BGColor,ShowBlocks,Maximize,TextColor,About';
		
	

	
};
CKEDITOR.config.extraPlugins = "base64image,uicolor";



