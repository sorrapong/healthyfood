//
//  NewsDetailViewController.swift
//  HealthyFood
//
//  Created by Sorrapong W on 13/3/2563 BE.
//  Copyright © 2563 Sorrapong W. All rights reserved.
//

import UIKit
import PDFKit

class NewsDetailViewController: UIViewController {

    var filename: String = ""
    var fileext: String = ""
    
    @IBOutlet weak var pdfView: PDFView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let url = Bundle.main.url(forResource: filename, withExtension: fileext)
        
        if let pdfDocument = PDFDocument(url: url!) {
            pdfView.autoScales = true
            pdfView.displayMode = .singlePageContinuous
            pdfView.displayDirection = .vertical
            pdfView.document = pdfDocument
        }
    }
    
    

}
