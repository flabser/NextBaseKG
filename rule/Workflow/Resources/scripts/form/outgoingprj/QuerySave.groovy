package form.outgoingprj
import kz.nextbase.script._Document
import kz.nextbase.script._Helper
import kz.nextbase.script._Session
import kz.nextbase.script._WebFormData
import kz.nextbase.script.constants._BlockStatusType
import kz.nextbase.script.constants._BlockType
import kz.nextbase.script.constants._CoordStatusType
import kz.nextbase.script.coordination._BlockCollection
import kz.nextbase.script.events._FormQuerySave

class QuerySave extends _FormQuerySave {

	@Override
	public void doQuerySave(_Session session, _Document doc, _WebFormData webFormData, String lang) {

		//println(webFormData)

		def action = webFormData.getValueSilently('action')
		def status
		def	blocksCollection  = (_BlockCollection)doc.getValueObject("coordination")

		if(blocksCollection == null){
			blocksCollection = new _BlockCollection(session)
		}



		status = blocksCollection.getStatus()

		if (doc.isNewDoc && action != "draft" || !doc.isNewDoc && status == _CoordStatusType.DRAFT && (action == "startcoord" || action == "send")){
			if(validate(webFormData, action) == false){
				stopSave()
				return
			}
		}else if(doc.isNewDoc && action == "draft" || !doc.isNewDoc && status == _CoordStatusType.DRAFT && (action != "startcoord" || action != "send")){
			if(validateprj(webFormData) == false){
				stopSave()
				return
			}
		}

		doc.setForm("outgoingprj")
		doc.addNumberField("category", webFormData.getNumberValueSilently("category",-1))
		doc.addNumberField("project", webFormData.getNumberValueSilently("project",-1))
		doc.addDateField("projectdate", _Helper.convertStringToDate(webFormData.getValue("projectdate")))
		doc.addNumberField("corr",webFormData.getNumberValueSilently("corr",-1))
		doc.addNumberField("docversion", webFormData.getNumberValueSilently("docversion",-1))
		doc.addStringField("briefcontent", webFormData.getValue("briefcontent"))
		doc.addFile("rtfcontent", webFormData)
		doc.addNumberField("nomentype", webFormData.getNumberValueSilently("nomentype",0))
		doc.addNumberField("deliverytype", webFormData.getNumberValueSilently("deliverytype",0))
		doc.addStringField("contentsource", webFormData.getValue("contentsource"))

		def struct = session.getStructure()
		String authorRus = ""
		def author = struct.getEmployer(doc.authorID)
		if (author){
			authorRus = author.getShortName()
		}

        def new_blocks = [];
        try{
            def bl = webFormData.getListOfValues("coordblock")
            for(String blockVal: bl) {
                def block = session.createBlock(blockVal)
                new_blocks.add(block);
            }
            blocksCollection.setBlocks(new_blocks);
        }catch(Exception e){
        }
		//Выбираем необходимое действие над документом
		//Для сохранения в качестве черновика мы просто изменяем статус проекта и всех блоков


		if (action == "draft"){
			blocksCollection.setCoordStatus(_CoordStatusType.DRAFT)
			def blockCol = blocksCollection.getBlocks()
			for (b in blockCol){
				b.setBlockStatus(_BlockStatusType.AWAITING)
			}
			doc.addEditor(author.getUserID())
		}else{
            //doc.clearEditors();
			//Для отправки на согласование
			def coordBlocks = blocksCollection.getCoordBlocks()
			if (action == "send"){
				if (!coordBlocks.empty){
					blocksCollection.setCoordStatus(_CoordStatusType.COORDINATING)
					def blockNum = 0
					def block = coordBlocks.get(blockNum)
					//Присваиваем первому согласовательному блоку статус "На согласовании"
					if (block && block.getBlockType() != _BlockType.TO_SIGN){
						block.setBlockStatus(_BlockStatusType.COORDINATING)
						if (block.getBlockType() == _BlockType.SERIAL_COORDINATION){
							def coord = block.getFirstCoordinator()
							if (coord){
								coord.setCurrent(true)
								doc.addReader(coord.getUserID())
							}
						}else if (block.getBlockType() == _BlockType.PARALLEL_COORDINATION){
							def coords = block.getCoordinators()
							coords.each{coord ->
								coord.setCurrent(true)
								doc.addReader(coord.getUserID())
							}
						}

					}

					blockNum ++
					try{
						block = coordBlocks.get(blockNum)
						while (block){
							block.setBlockStatus(_BlockStatusType.AWAITING)
							blockNum ++
							block = coordBlocks.get(blockNum)
						}
					}catch(IndexOutOfBoundsException e){

					}
				}else{
					//Для отправки на подпись
					println("Документ  № "+ doc.getValueString("vn") +" отправлен на подпись");
					/*в том случае, если мы создали блоки согласования, но документ сразу же был отправлен
					 на подпись*/
					def signBlock = blocksCollection.getSignBlock()
					blocksCollection.setCoordStatus(_CoordStatusType.SIGNING)
					if (signBlock){
						signBlock.setBlockStatus(_BlockStatusType.COORDINATING);
					}
					def signer = signBlock.getFirstCoordinator();
					if (signer){
						signer.setCurrent(true);
						doc.addReader(signer.getUserID());
					}
				}
			}
		}

		doc.addField("coordination", blocksCollection)

		def vt
		Date dDate = new Date()
		def returnURL = session.getURLOfLastPage()
		def db = session.getCurrentDatabase()

		if (blocksCollection.getStatus() == _CoordStatusType.DRAFT){			
			if (doc.isNewDoc || doc.getViewNumber() == 0){
				returnURL.changeParameter("page", "0");
				localizedMsgBox("Документ сохранен как черновик");
			}
			vt = ' ' + author.getShortName() + ' ' + doc.getValueString('briefcontent')
		}else{
            if (doc.getViewNumber()== -1 && blocksCollection.getStatus() != _CoordStatusType.DRAFT){

                int num = db.getRegNumber("outgoingprj")
				String vnAsText = Integer.toString(num)
				def nomenvalue = doc.getGlossaryValue("n", "docid#number=" + doc.getValueInt("nomentype"), "ndelo")
				def depid = session.getCurrentAppUser().getDepartmentID();
				def depindex  = session.getStructure().getDepartment(depid, session).getValueString("index");
				if (nomenvalue != ''){
					nomenvalue = nomenvalue + "/"
				}
				if (depindex != ''){
					depindex = depindex + "-"
				}
				vnAsText = depindex + nomenvalue + vnAsText
                doc.addStringField("vn",vnAsText)
				doc.setViewNumber(num)

				doc.setViewDate(doc.getRegDate())
				returnURL.changeParameter("page", "0");
				localizedMsgBox("Документ № "+ doc.getValueString("vn") +" сохранен")
			}else{
				dDate = doc.getRegDate()
			}
			vt = ' № ' + doc.getValueString("vn") + ' ' + _Helper.getDateAsStringShort(dDate) + ' ' + author.getShortName() + ' ' + doc.getValueString('briefcontent')
		}


        doc.setViewDate(dDate)
		doc.setViewText(vt)
		doc.addViewText(doc.getValueString('briefcontent'))
		doc.addViewText("")
		doc.addViewText(blocksCollection.getStatus())
		doc.addViewText(blocksCollection.getSignBlock().getFirstCoordinator().getUserID())
		dDate = doc.getRegDate()
		def cBlock = blocksCollection.getCurrentBlock()
        if (cBlock)	{
            doc.addViewText(cBlock.getCurrentCoordinatorsAsText())
            doc.addViewText(cBlock.getCoordinatorsAsText())
        }
        doc.addViewText(doc.getValueString('corr'))

        setRedirectURL(returnURL)
	}

	def validate(_WebFormData webFormData, String action){

		if (webFormData.getValueSilently("briefcontent") == ""){
			localizedMsgBox("Поле \"Краткое содержание\" не заполнено.")
			return false
		}else if (webFormData.getValueSilently('briefcontent').length() > 2046){
			localizedMsgBox('Поле \'Краткое содержание\' содержит значение превышающее 2046 символов');
			return false;
		}else if (webFormData.getValueSilently("corr") == ""){
			localizedMsgBox("Поле \"Корреспондент\" не заполнено.")
			return false
		}else if (webFormData.getValueSilently("signer") == ""){
			localizedMsgBox("Поле \"Кем будет подписан\" не выбрано.")
			return false
		}else if(action == "startcoord" && (webFormData.getListOfValuesSilently("coordBlock").length == 0)){
			localizedMsgBox("В список согласования не включен ни один участник.")
			return false
		}
        if (webFormData.getValueSilently("project") == "" || !webFormData.containsField("project")){
            localizedMsgBox("Поле \"Связан с проектом\" не выбрано.")
            return false
        }
	}

	def validateprj(_WebFormData webFormData){

		if (webFormData.getValueSilently("briefcontent") == ""){
			localizedMsgBox("Поле \"Краткое содержание\" не заполнено.")
			return false
		}
		if (webFormData.getValueSilently('briefcontent').length() > 2046){
			localizedMsgBox('Поле \'Краткое содержание\' содержит значение превышающее 2046 символов');
			return false;
		}

		if (webFormData.getValueSilently("corr") == "" || !webFormData.containsField("corr")){
			localizedMsgBox("Поле \"Корреспондент\" не выбрано.")
			return false
		}

		if (webFormData.getValueSilently("signer") == "" || !webFormData.containsField("signer")){
			localizedMsgBox("Поле \"Кем будет подписан\" не выбрано.")
			return false
		}
		if (webFormData.getValueSilently('contentsource').length() > 2046){
			localizedMsgBox('Поле \'Содержание\' содержит значение превышающее 2046 символов');
			return false;
		}
        if (webFormData.getValueSilently("project") == "" || !webFormData.containsField("project")){
            localizedMsgBox("Поле \"Связан с проектом\" не выбрано.")
            return false
        }
	}
}
