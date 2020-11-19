
import SwiftUI

struct HKCBannerView: UIViewControllerRepresentable {
    @State var banner_url: [String]
    @State var banner_images : [UIImage?]
    func makeUIViewController(context: UIViewControllerRepresentableContext<HKCBannerView>) -> HKCBannerController {
        let HBC = HKCBannerController()
        if banner_url.count == 0 {
            HBC.createCyclePicture1(pic: banner_images)
        }else{
            HBC.createCyclePicture1(pic: banner_url)
        }
        return HBC
    }

    func updateUIViewController(_ uiViewController: HKCBannerController, context: Context) {}

}



