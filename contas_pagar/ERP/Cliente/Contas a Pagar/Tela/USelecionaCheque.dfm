object FSelecionaCheque: TFSelecionaCheque
  Left = 366
  Top = 220
  BorderStyle = bsDialog
  Caption = 'Sele'#231#227'o de Cheque para Pagamento'
  ClientHeight = 404
  ClientWidth = 583
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object PanelCabecalho: TPanel
    Left = 0
    Top = 0
    Width = 583
    Height = 65
    Align = alTop
    Color = 14537936
    ParentBackground = False
    TabOrder = 0
    DesignSize = (
      583
      65)
    object Bevel1: TBevel
      Left = 61
      Top = 50
      Width = 515
      Height = 6
      Anchors = [akLeft, akTop, akRight]
      ExplicitWidth = 415
    end
    object Image1: TImage
      Left = 7
      Top = 7
      Width = 48
      Height = 49
      ParentShowHint = False
      Picture.Data = {
        0B54504E474772617068696336240000424D3624000000000000360000002800
        0000300000003000000001002000000000000024000000000000000000000000
        000000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF003E3E3D518080
        7F957B7A79947B7B79947C7B79947C7B7A9478777A946F6F7B947E7D7A947C7B
        7B947C7C7B947D7C7A947D7C7B947D7C7B947D7C7B947D7D7C947D7D7C947D7D
        7C947D7D7C947E7D7C947E7D7D947E7D7D947E7E7D947E7E7D947E7E7D947E7E
        7D947E7E7D947F7E7E947F7E7E947F7E7E947F7E7E947F7F7E947F7F7E947F7F
        7E947F7F7E94807F7E948080809555555564FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0084838194FFFF
        FFFFFFFFFBFFFFFFFDFFFFFFFDFFFFFFFEFFFDFAFFFFECE9FFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFB6B6B6B8FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF007B7A798CFFFF
        FBFFF2EFEAFFF3EFECFFF3EFECFFF4F1ECFFEDEAEFFFD9D5ECFFF1EDE4FFEEEA
        E5FFEFEBE6FFEFECE7FFF0EDE7FFF0EDE8FFF1EDE8FFF1EDE8FFF1EEE9FFF1EF
        EAFFF2EFEAFFF2EFEAFFF3EFEBFFF3EFEBFFF3F0ECFFF3F1EDFFF4F1ECFFF4F1
        EDFFF5F1EEFFF5F2EEFFF5F2EEFFF6F2EFFFF6F3EFFFF6F3EFFFF6F4F0FFF6F4
        F0FFF6F4F0FFF6F4F0FFF9F7F4FFA7A6A5ADFFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF007B7B798CFFFF
        FCFFF3F0ECFFF7F4F1FFF6F3EEFFF5F2EDFFEDEBEFFFDBD9F1FFF6F3EDFFF4F1
        EDFFF5F2EEFFF6F3F0FFF6F3F0FFF7F3F0FFF6F4F0FFF7F5F2FFF7F5F2FFF8F6
        F3FFF8F6F3FFF9F6F4FFF9F7F4FFF9F8F5FFF9F8F6FFFAF9F5FFFAF9F6FFFBF9
        F7FFFBF9F7FFFCFAF8FFFCFAF8FFFCFBF8FFFCFBF8FFFCFCF9FFFCFCF9FFFDFC
        FAFFFDFCFAFFFDFCFAFFFEFDFDFFA9A9A8ADFFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF007C7B798CFFFF
        FEFFEBE8E4FFBAB6B0FFE0DDD8FFF9F6F1FFEEEBF0FFDAD8EFFFF4F1E9FFF2EF
        EAFFF2EFEBFFF6F2EEFFF7F3EEFFF4F0ECFFF4F1EEFFF4F2EEFFF5F2EEFFF5F2
        EEFFF6F3EFFFF6F3F0FFF6F4F0FFF6F5F1FFF7F5F1FFF7F5F1FFF8F5F2FFF8F6
        F3FFF8F6F3FFF9F6F4FFF9F7F3FFF9F7F4FFF9F8F4FFF9F8F4FFFAF8F5FFFAF8
        F6FFFAF8F6FFFAF8F5FFFBFAF8FFA7A8A6ADFFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF007C7B7A8CFFFF
        FFFFE7E4E0FFA09B92FFD7D3CEFFFBF8F4FFEEEBF0FFDBD9F0FFF6F3ECFFF4F2
        EDFFF7F5F1FFD4D1CEFFE2DFDBFFFBF8F4FFF6F4F1FFF7F4F1FFF7F4F1FFF8F4
        F2FFF8F5F2FFF8F5F3FFF8F6F3FFF9F7F3FFF9F7F3FFFAF7F4FFFAF7F5FFFAF8
        F6FFFBF8F6FFFBF9F6FFFBF9F6FFFBFAF7FFFBFAF7FFFCFAF8FFFCFAF8FFFCFA
        F8FFFCFAF8FFFBFAF7FFFCFCFBFFA9A8A7ADFFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF007C7B7A8CFFFF
        FEFFF4F1EDFFF3F0ECFFF5F2EFFFF6F3EFFFEEECF1FFDBD9F0FFF5F2EBFFF3F0
        ECFFF9F5F1FFC8C7C5FF7C8286FFDEDCD8FFFAF7F2FFF5F3EFFFF6F2EFFFF6F3
        F0FFF6F4F1FFF6F4F1FFF7F5F1FFF7F5F1FFF8F5F2FFF8F5F3FFF8F6F3FFF9F6
        F3FFF9F7F3FFF9F7F3FFF9F7F4FFF9F8F4FFFAF8F5FFFAF8F5FFFAF8F5FFFAF8
        F5FFF9F8F4FFF9F7F4FFFBFAF8FFA8A7A5ADFFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF007C7B7A8CFFFF
        FFFFF5F2EEFFF6F3F0FFF5F2EFFFF7F4EFFFEFEDF1FFDDDBF3FFFAF7F1FFF7F4
        F1FFFAF6F3FFEBEBE9FF85A5BCFF8BA9BDFFE4E1DCFFFFFCF8FFFAF8F6FFFAF8
        F6FFFAF9F7FFFBF9F7FFFBFAF7FFFCFAF8FFFCFAF9FFFCFBF9FFFDFBFAFFFDFC
        F9FFFDFCFAFFFDFDFAFFFDFDFAFFFEFDFBFFFEFDFCFFFEFDFCFFFEFDFBFFFDFD
        FAFFFDFDFAFFFDFCF9FFFEFEFEFFAAA9A7ADFFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF007C7B7A8CFFFF
        FFFFF5F2EFFFF6F3F0FFF6F3F0FFF7F5F0FFF0EEF2FFDCD9F1FFF6F2EBFFF3F0
        ECFFF4F1EDFFF1EEEAFFBAD7EAFF88BCE0FF84A3BAFFD7D5D2FFFBF7F2FFF6F4
        F1FFF6F5F0FFF7F5F1FFF7F5F2FFF7F5F2FFF8F6F3FFF9F6F3FFF9F7F3FFF9F7
        F3FFF8F7F4FFF9F7F4FFF9F7F4FFFAF7F5FFFAF7F5FFF9F7F4FFF9F7F4FFF8F7
        F4FFF9F7F3FFF9F6F3FFFBFAF8FFA7A7A5ADFFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF007C7B7A8CFFFF
        FFFFF5F2EFFFF3F0EDFFF6F4F0FFF8F6F1FFF0EEF3FFDEDBF3FFFAF7F1FFF7F6
        F3FFF8F6F3FFFDF8F3FFC1D6E4FFAFD6F1FF67A4D1FF8BADC3FFE4E3DFFFFEFD
        FAFFFBFAF7FFFCFAF8FFFCFAF8FFFCFBF9FFFDFBFAFFFDFCF9FFFDFCFAFFFDFD
        FAFFFDFDFAFFFEFDFBFFFEFDFCFFFEFDFCFFFEFDFBFFFDFDFAFFFDFDFAFFFDFC
        FAFFFDFCF9FFFDFBFAFFFEFEFEFFA9A8A7ADFFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF007C7C7B8CFFFF
        FFFFE9E6E2FF9A958DFFD6D3CEFFFDFBF7FFF0EEF3FFDCDAF1FFF6F4ECFFF4F2
        EEFFF5F2EEFFFAF6F0FFC6D5DFFFB6DBF2FF9ACDE5FF4D83C2FF676BA9FFF7F4
        EBFFF9F8F3FFF7F5F2FFF8F6F3FFF9F6F3FFF9F7F3FFF9F7F3FFF8F7F4FFF9F7
        F4FFF9F7F4FFFAF7F5FFFAF7F5FFF9F7F4FFF9F7F4FFF8F7F4FFF9F7F3FFF9F7
        F3FFF9F6F3FFF8F5F2FFFBFAF8FFA7A6A4ADFFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF007D7C7B8CFFFF
        FFFFEFEDE9FFBFBBB6FFE5E2DEFFFCF9F5FFF0EEF4FFDEDDF5FFFBF9F3FFF9F7
        F4FFF9F7F4FFFEFAF6FFE0E6E9FF9FC5E3FF819CE8FF141EC7FF090899FFC7C6
        D1FFFFFFFDFFFDFBF9FFFDFBFAFFFDFCF9FFFDFCFAFFFDFCFAFFFDFDFAFFFEFD
        FBFFFEFDFCFFFEFDFCFFFEFDFBFFFDFDFAFFFDFDFAFFFDFCFAFFFDFCF9FFFDFB
        FAFFFCFBF9FFFCFAF9FFFEFEFEFFA9A8A7ADFFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF007D7C7B8CFFFF
        FFFFF7F5F2FFFDFBF8FFFAF7F4FFF9F7F2FFF0EFF5FFDCDBF3FFF7F5EDFFF5F2
        EEFFF5F2EFFFF7F3F0FFF8F7F2FF7F83C2FF0505B3FF0D0BD5FF0303B9FF4F4E
        9EFFF1EFE7FFFAF8F6FFF8F6F3FFF9F7F3FFF8F7F4FFF9F7F4FFF9F7F4FFFAF7
        F5FFFAF7F5FFF9F7F4FFF9F7F4FFF8F7F4FFF9F7F3FFF9F7F3FFF9F6F3FFF8F6
        F2FFF7F5F2FFF7F5F2FFFBFAF8FFA7A6A4ADFFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF007D7C7B8CFFFF
        FFFFF7F5F2FFF8F5F2FFF8F5F3FFF9F7F4FFF1F0F5FFDFDEF5FFFCFAF4FFFAF7
        F4FFFAF8F6FFFAF8F6FFFEFDFAFFE1DFEAFF1D1DA1FF1010C8FF1010D2FF0202
        9EFFA8A6C4FFFFFFFFFFFDFCFAFFFDFDFAFFFDFDFAFFFEFDFBFFFEFDFCFFFEFD
        FCFFFEFDFBFFFDFDFAFFFDFDFAFFFDFCFAFFFDFCF9FFFDFBFAFFFCFBF9FFFCFA
        F9FFFCFAF8FFFBFAF7FFFEFEFEFFA8A7A6ADFFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF007D7C7B8CFFFF
        FFFFF8F5F2FFFBF9F6FFF9F7F5FFFAF8F4FFF2F0F5FFDDDCF3FFF8F5EEFFF6F3
        F0FFF6F4F0FFF6F4F0FFF7F5F0FFFDFBF6FF8A89C5FF0A0AADFF1818D6FF0808
        C2FF35349AFFE6E4DDFFFAF9F7FFF9F7F4FFF9F7F4FFFAF7F5FFFAF7F5FFF9F7
        F4FFF9F7F4FFF8F7F4FFF9F7F3FFF9F7F3FFF9F6F3FFF8F6F2FFF7F5F2FFF7F5
        F2FFF7F5F0FFF6F5F0FFFBFAF8FFA6A5A3ADFFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF007D7C7B8CFFFF
        FFFFF7F4F1FFE5E3DFFFF5F3F0FFFBFAF6FFF2F0F5FFE0DEF6FFFDFBF5FFFAF8
        F6FFFAF9F7FFFBF9F7FFFBFAF7FFFEFDFAFFF5F3F3FF3939ABFF1616C5FF1919
        D8FF0303ABFF7D7DB2FFFFFFFBFFFEFDFCFFFEFDFCFFFEFDFCFFFEFDFBFFFDFD
        FAFFFDFDFAFFFDFCFAFFFDFCF9FFFDFBFAFFFCFBF9FFFCFAF9FFFCFAF8FFFBFA
        F7FFFBFAF7FFFAF9F7FFFEFEFEFFA8A7A6ADFFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF007D7D7C8CFFFF
        FFFFEBE8E5FF959087FFD6D4CFFFFFFEFAFFF3F0F6FFDFDCF4FFF9F7F0FFF6F4
        F1FFF7F5F1FFF7F5F1FFF8F5F2FFF8F6F3FFFEFDF8FFA7A5D3FF0E0EA8FF1F1F
        D6FF1112CBFF17179AFFC8C7CEFFFCFBF9FFFAF8F6FFFAF8F5FFF9F8F5FFF9F8
        F5FFF9F7F4FFF9F7F4FFF9F6F4FFF8F6F3FFF8F5F3FFF8F5F2FFF7F5F1FFF7F5
        F1FFF6F5F1FFF6F4F1FFFBFAF8FFA7A5A4ADFFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF007D7D7C8CFFFF
        FFFFF6F4F1FFDAD7D3FFF1EFECFFFDFAF7FFF3F1F7FFDFDCF5FFF9F7F1FFF7F5
        F1FFF7F5F1FFF8F5F2FFF8F5F3FFF8F6F3FFF9F8F5FFFBF9F4FF5857B3FF1818
        C0FF2121DCFF0606B8FF5252A6FFF8F6F0FFFAF9F7FFF9F8F5FFF9F8F5FFF9F7
        F4FFF9F7F4FFF9F6F4FFF9F6F4FFF8F6F3FFF8F5F3FFF7F5F2FFF7F5F1FFF6F5
        F1FFF6F4F1FFF6F4F0FFFBFAF8FFA6A5A3ADFFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF007E7D7C8CFFFF
        FFFFFAF8F5FFFFFDFAFFFCF9F7FFFCFAF6FFF3F2F8FFE1E0F8FFFEFDF7FFFBFA
        F7FFFCFAF8FFFCFAF9FFFDFBFAFFFDFBFAFFFDFCFAFFFFFFFEFFD8D7EAFF1E1E
        A9FF2626D2FF1D1DD5FF0B0BA3FFB6B6CAFFFFFFFFFFFEFDFBFFFDFCFAFFFDFC
        FAFFFDFBFAFFFDFBF9FFFCFAF9FFFCFAF9FFFBFAF7FFFBFAF7FFFAF9F7FFFAF8
        F7FFFAF8F6FFF9F7F5FFFEFEFEFFA7A6A5ADFFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF007E7D7C8CFFFF
        FFFFFAF8F5FFFBF8F5FFFBF8F7FFFCFBF8FFF4F3F9FFDDDCF3FFF7F4ECFFF4F2
        EDFFF5F2EEFFF5F3EFFFF6F3EFFFF6F3EFFFF6F3EFFFF6F5F0FFFCFAF2FF6463
        B7FF1616B9FF2B2BE2FF1717CCFF4242A1FFECEAE3FFF8F6F2FFF6F3EFFFF6F3
        EFFFF6F3EFFFF5F2EEFFF5F2EEFFF4F2EDFFF4F2EDFFF3F1EDFFF3F1EDFFF3F0
        ECFFF3EFEBFFF3F0EAFFF9F7F4FFA4A3A2ADFFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF007E7D7C8CFFFF
        FFFFFBF9F6FFFFFFFEFFFDFBFAFFFCFBF8FFF4F3F8FFE1E0F8FFFDFCF6FFFBF9
        F7FFFCFAF8FFFCFAF8FFFCFBF8FFFCFBF8FFFCFBF9FFFCFCF9FFFEFEFCFFE3E2
        EFFF3233B1FF3333DCFF3030E7FF0808AAFF9897BDFFFFFFFCFFFDFAF9FFFCFA
        F8FFFBF9F7FFFBF9F7FFFAF9F6FFFAF9F5FFF9F8F6FFF9F7F5FFF9F7F5FFF9F6
        F3FFF8F6F3FFF7F6F3FFFEFDFDFFA6A5A4ADFFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF007E7D7D8CFFFF
        FFFFF5F3F1FFCDC9C5FFECEAE8FFFEFDFAFFF4F3F9FFE0DEF6FFFAF7F1FFF8F6
        F3FFF9F6F3FFF9F7F3FFF9F7F3FFF9F7F4FFF9F7F4FFFAF7F4FFFAF8F5FFFFFE
        F9FF8786C6FF1D1DB8FF3E3EEDFF2323D6FF3332A2FFE8E5E0FFFBFAF6FFF7F5
        F2FFF8F5F2FFF7F5F1FFF7F5F0FFF6F4F1FFF6F4F1FFF6F3EFFFF6F3EFFFF5F2
        EEFFF5F2EEFFF4F2EEFFFBFAF8FFA5A4A3ADFFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF007E7D7D8CFFFF
        FFFFECE9E7FF948F87FFD6D4CFFFFFFFFEFFF5F3F9FFE2E1FAFFFEFEF9FFFDFB
        FAFFFDFCFAFFFDFCFAFFFDFDFBFFFDFDFBFFFEFDFCFFFEFDFCFFFEFDFCFFFFFF
        FDFFEAEAF3FF3334AFFF3C3CD8FF3F3FEEFF1211B6FF8180B3FFFFFFFAFFFDFB
        F9FFFBFAF7FFFBFAF7FFFAF9F7FFFAF9F7FFFAF8F6FFFAF8F5FFF9F7F4FFF9F7
        F4FFF8F7F4FFF7F6F3FFFEFEFEFFA6A5A4ADFFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF007E7E7D8CFFFF
        FFFFFBF9F8FFF3F1EEFFFAF9F6FFFEFCF9FFF6F4FBFFDEDDF5FFF7F5EEFFF6F3
        EFFFF6F3EFFFF6F4F0FFF6F4F0FFF6F4F0FFF6F4F1FFF6F4F1FFF7F4F1FFF6F4
        F0FFFBF9F3FFA6A4CFFF1C1DB1FF4848EDFF3131DFFF1C1CA1FFD5D2D4FFF9F8
        F2FFF4F1EDFFF3F1EDFFF3F1ECFFF3F0ECFFF3F0EBFFF3EFEAFFF2F0EAFFF2EF
        EAFFF1EEEAFFF1EDE9FFF9F7F4FFA4A2A1ADFFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF007E7E7D8CFFFF
        FFFFFBFAF8FFFEFDFAFFFDFCFAFFFEFCFAFFF6F4FBFFE2E1FAFFFDFDF8FFFCFB
        F8FFFCFBF9FFFCFCF9FFFDFCFAFFFDFCFAFFFDFCFAFFFDFCFAFFFDFCF9FFFCFC
        F9FFFDFCF9FFFAF9F9FF5B5ABBFF3D3DD3FF4D4CF4FF1E1EC5FF6867A9FFF9F8
        EEFFFBFAF8FFF9F7F5FFF9F7F4FFF9F6F3FFF8F6F3FFF8F6F3FFF7F6F3FFF6F5
        F2FFF6F4F0FFF7F3F0FFFEFDFBFFA6A4A3ADFFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF007E7E7D8CFFFF
        FFFFFCFBF8FFFDFCFAFFFDFBFAFFFFFDFAFFF6F4FBFFE1DFF7FFFAF9F3FFF9F7
        F4FFF9F8F5FFFAF8F5FFFAF8F6FFFAF8F6FFFAF8F5FFF9F8F4FFF9F8F5FFF9F7
        F4FFF9F7F3FFFCFBF7FFCCCAE0FF2A2AB1FF5353ECFF4545ECFF1010A6FFAEAD
        C4FFFDFCF5FFF6F3F0FFF6F3EFFFF5F2EEFFF5F2EEFFF4F2EEFFF4F1EDFFF4F0
        EDFFF4F0ECFFF3F0ECFFFBFAF7FFA4A3A1ADFFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF007E7E7D8CFFFF
        FFFFFDFCFAFFFEFCFBFFFEFDFBFFFFFDFBFFF6F5FBFFE1E0F9FFFCFBF7FFFBFA
        F7FFFCFAF7FFFCFAF8FFFCFAF8FFFCFAF8FFFBFAF7FFFBFAF7FFFBF9F7FFFBF9
        F6FFFBF9F6FFFBFAF7FFFEFCF8FF6160BBFF3636CAFF5A5AF8FF2B2BD1FF4746
        A6FFF5F2E8FFFBF8F4FFF7F4F1FFF7F4F1FFF6F4F1FFF5F4F0FFF5F2EFFFF5F2
        EEFFF5F2EEFFF4F1EDFFFCFCF8FFA5A4A2ADFFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF007E7E7E8CFFFF
        FFFFF2F0EEFFAAA59EFFE1DEDBFFFFFEFEFFF6F5FBFFE1DFF8FFFAF9F4FFF9F8
        F5FFFAF8F5FFFAF8F6FFFAF8F5FFF9F8F5FFF9F8F4FFF9F7F4FFF9F7F3FFF9F6
        F4FFF9F6F3FFF8F5F3FFFBF9F4FFE3E2E9FF3E3DB5FF5B5BE7FF5858F5FF1A1A
        B5FF9392B7FFFDFCF1FFF5F3EFFFF5F2EEFFF4F2EEFFF4F0EDFFF4F0ECFFF4F0
        ECFFF3F0EBFFF2EFEBFFFBFAF5FFA4A3A1ADFFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF007F7E7E8CFFFF
        FFFFF3F1EFFFB3AEA8FFE4E1DEFFFFFFFEFFF6F6FCFFE2E2FBFFFDFDF9FFFDFC
        FAFFFDFCFAFFFDFCFAFFFDFCF9FFFCFCF9FFFCFBF8FFFCFBF8FFFCFAF8FFFCFA
        F8FFFBF9F8FFFBF9F7FFFBF9F6FFFFFFFBFF9190CCFF2E2EBDFF6767F8FF3D3E
        DEFF292AA4FFE4E3E1FFFCFBF6FFF6F5F2FFF6F4F1FFF7F3F0FFF6F3F0FFF6F3
        EFFFF5F2EFFFF4F1EDFFFEFCF8FFA4A3A1ADFFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF007F7E7E8CFFFF
        FFFFFFFDFCFFFFFFFEFFFFFFFDFFFFFFFCFFF7F7FDFFE0DEF6FFF6F5F0FFF6F4
        F1FFF7F4F1FFF6F4F0FFF6F4F0FFF6F3F0FFF6F3EFFFF6F3EFFFF6F3EFFFF5F2
        EEFFF5F2EEFFF4F2EDFFF4F1EDFFF6F4EEFFEBE9E9FF4141B4FF5A5AE3FF6565
        FAFF1F1FC0FF7876AEFFF9F6EAFFF2EEEAFFF1EDE8FFF1EDE8FFF0EDE8FFF0EC
        E7FFEFECE6FFEFEBE6FFF9F6F1FFA3A19FADFFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF007F7E7E8CFFFF
        FFFFFEFCFBFFFFFEFCFFFEFEFCFFFFFFFCFFF6F6FCFFE4E3FCFFFEFEFCFFFEFD
        FCFFFEFDFBFFFDFDFBFFFDFCFAFFFDFCFAFFFDFCFAFFFDFBFAFFFCFBF9FFFCFA
        F9FFFCFAF7FFFBFAF7FFFBF9F7FFFAF9F7FFFFFFFAFFB0AFD7FF3737BDFF6969
        F7FF5A5AEDFF8282C0FFE1DFD8FFFCFAF5FFF7F4F1FFF7F4F1FFF6F3F0FFF5F3
        EFFFF4F2EEFFF5F1EEFFFEFDF9FFA5A3A2ADFFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF007F7F7E8CFFFF
        FFFFFEFDFBFFFFFFFFFFFFFFFDFFFFFFFCFFF7F6FDFFE1E0F9FFFAF8F4FFF9F7
        F4FFF9F7F4FFF9F7F4FFF9F7F3FFF9F6F3FFF9F6F3FFF8F5F3FFF8F5F2FFF7F5
        F1FFF7F5F0FFF6F4F1FFF6F4F0FFF6F3F0FFF8F4F0FFF6F4EEFF5757BBFF8C8C
        EBFFD9D9F7FF696966FF615F5FFFFAF7F3FFF4F1EDFFF2EFEAFFF1EEE9FFF1ED
        E9FFF1EDE9FFF1EDE8FFFBF8F2FFA4A1A0ADFFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF007F7F7E8CFFFF
        FFFFFDFDFBFFEFEEEBFFFBFBF9FFFFFFFEFFF7F6FDFFE3E2FBFFFDFDF9FFFCFC
        F9FFFCFBF9FFFCFBF8FFFCFAF8FFFCFAF8FFFBF9F8FFFBF9F7FFFAF9F6FFFAF9
        F5FFF9F8F6FFF9F7F5FFF9F7F5FFF9F6F4FFF8F6F3FFFCFAF6FFE9E7E8FF8281
        81FF6A6A65FF424242FF1A1A1AFFBAB9B6FFFEFBF7FFF4F2EEFFF3F1EDFFF4F0
        EDFFF4F0EDFFF3F0EBFFFEFAF5FFA5A2A0ADFFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF007F7F7E8CFFFF
        FFFFEFEEECFF928C83FFD8D5D1FFFFFFFFFFF8F7FDFFDFDEF6FFF6F5EFFFF6F3
        EFFFF6F3EFFFF6F3EFFFF6F3EFFFF5F2EFFFF5F2EEFFF4F2EDFFF4F2EDFFF3F1
        EDFFF3F0EDFFF3F0ECFFF3F0EBFFF3EFEAFFF2EFEAFFF3F0ECFFF8F7F2FF5A59
        56FF161617FF676767FF2E2E2FFF3C3C39FFEDEAE4FFF1EDE8FFEFEBE6FFEFEB
        E5FFEEEAE4FFEDE9E4FFF9F4EEFFA2A19EADFFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF007F7F7E8CFFFF
        FFFFF9F8F6FFC7C5C0FFEFECEBFFFFFFFEFFF7F6FCFFE3E3FCFFFEFEFAFFFDFC
        FAFFFDFCFAFFFDFBFAFFFCFBF9FFFCFAF9FFFCFAF7FFFBFAF7FFFBF9F7FFFAF9
        F7FFFAF8F6FFFAF8F6FFF9F7F4FFF9F7F4FFF9F7F4FFF7F6F3FFFDFCFAFFD1CF
        CCFF161615FF575757FF676767FF161616FFA8A6A4FFFDFAF7FFF5F1EEFFF4F1
        EDFFF4F0EBFFF2EFEBFFFDFAF6FFA4A2A1ADFFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00807F7E8CFFFF
        FFFFFFFFFDFFFFFFFFFFFFFFFFFFFFFFFCFFF6F6FCFFE1DFF8FFFAF9F3FFF9F6
        F4FFF9F6F4FFF8F6F3FFF8F5F3FFF7F5F1FFF7F5F1FFF6F5F1FFF6F4F1FFF6F3
        F0FFF6F3EFFFF5F3EEFFF5F3EEFFF5F2EEFFF4F2EEFFF4F1EDFFF4F0ECFFFDFC
        F9FF868582FF222222FF767676FF4C4C4DFF8D8B88FFFBF8F3FFF1EDE8FFF0EC
        E7FFF0EBE7FFEFEBE6FFFBF6F1FFA3A09FADFFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00807F7F8CFFFF
        FFFFFFFEFDFFFFFEFDFFFFFEFCFFFFFFFCFFF6F5FCFFE1DFF8FFFAF9F3FFF9F6
        F4FFF8F6F3FFF8F5F3FFF7F5F1FFF7F5F1FFF6F5F1FFF6F4F1FFF6F4F0FFF6F3
        EFFFF5F3EEFFF5F3EEFFF5F3EEFFF4F2EEFFF4F1EDFFF4F0ECFFF4F0ECFFF7F5
        F0FFE6E3DEFF2E2D2CFF6B6A6AFFC6C3C0FFEEEBE6FFF2EEE9FFF0EDE7FFF0EC
        E7FFEFEBE7FFEFEBE6FFFAF6F0FFA2A09FADFFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00807F7F8CFFFF
        FFFFFFFFFDFFFFFFFFFFFFFFFEFFFFFEFBFFF6F5FBFFE3E1FAFFFEFEF9FFFCFA
        F9FFFCFAF8FFFBFAF7FFFBFAF7FFFBF9F7FFFAF8F6FFFAF8F6FFFAF7F5FFF9F7
        F4FFF9F7F4FFF8F6F4FFF8F6F3FFF7F5F2FFF7F4F1FFF7F4F1FFF6F4F0FFF5F3
        F0FFF9F7F2FFDFDDDAFFE8E5E2FFFDF9F6FFF5F2EEFFF3F0EBFFF2EFEBFFF2EE
        EBFFF1EEEAFFF1EEE8FFFCF8F3FFA3A2A0ADFFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00807F7F8CFFFF
        FFFFFBFAF8FFDEDCD8FFF5F4F1FFFFFFFCFFF6F5FBFFE0DFF7FFFAF8F2FFF7F5
        F2FFF7F5F1FFF7F5F0FFF6F4F0FFF6F4F0FFF6F3F0FFF6F3EFFFF5F2EEFFF5F2
        EEFFF4F2EEFFF3F1EDFFF3F1EDFFF3F0EBFFF3F0EBFFF2EFEBFFF2EFEBFFF1EE
        EAFFF1EDE8FFF5F2EDFFF4F0ECFFF0EDE7FFF0ECE7FFEFEBE6FFEEEAE6FFEEEA
        E6FFEEEAE5FFEEEAE3FFF9F4EFFFA2A09EADFFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00807F7E8CFFFF
        FFFFEFEEEBFF938D85FFD7D5D0FFFFFFFFFFF6F4FBFFE1E0F9FFFDFCF6FFFAF9
        F6FFFAF9F6FFF9F8F6FFF9F8F6FFF9F7F5FFF9F6F4FFF9F6F3FFF8F6F3FFF8F6
        F3FFF7F5F2FFF7F4F1FFF7F3F0FFF7F3F0FFF6F3F0FFF5F2EFFFF5F2EEFFF4F1
        EDFFF4F0EDFFF4F1EDFFF3F0ECFFF3F0EAFFF2EEEAFFF1EEEAFFF1EEE9FFF1EE
        E8FFF1EDE7FFF0ECE7FFFAF7F2FFA3A19EADFFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF007F7F7E8CFFFF
        FFFFFCFBFAFFE6E4E1FFF8F6F4FFFFFEFBFFF5F3FAFFE2E1FAFFFFFEF9FFFCFB
        F8FFFCFAF8FFFBFAF8FFFBF9F7FFFBF8F7FFFAF8F5FFFAF8F5FFF9F8F5FFF9F7
        F4FFF8F6F4FFF8F5F2FFF8F5F2FFF7F5F2FFF7F4F1FFF6F4F0FFF5F3EFFFF5F2
        EFFFF5F2EFFFF5F2EEFFF4F1ECFFF3F0ECFFF3EFECFFF2EFEBFFF2EFEAFFF2EE
        E9FFF1EEE9FFF0EDE8FFFBF7F3FFA3A19FADFFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF007F7F7E8CFFFF
        FFFFFEFDFBFFFFFFFFFFFFFDFCFFFEFCFAFFF5F3FAFFE2E1F9FFFFFEF8FFFCFA
        F8FFFBFAF8FFFBF9F7FFFBF8F6FFFAF8F5FFFAF8F5FFF9F8F5FFF8F7F4FFF8F6
        F3FFF8F5F2FFF8F5F2FFF7F5F2FFF7F4F1FFF6F4F0FFF5F2EFFFF5F2EFFFF5F2
        EFFFF5F2EEFFF3F0ECFFF3F0ECFFF2EFECFFF2EFEBFFF2EFEAFFF2EEE9FFF1EE
        E9FFF1ECE9FFEFECE8FFFBF7F2FFA3A19FADFFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF007F7F7E8CFFFF
        FFFFFEFCFBFFFEFCFBFFFDFBFAFFFEFCF9FFF4F3F9FFE2E0F9FFFFFDF8FFFBFA
        F8FFFBF9F7FFFBF8F6FFFAF8F5FFFAF8F5FFF9F7F5FFF8F7F4FFF8F6F3FFF8F5
        F2FFF8F5F2FFF7F5F2FFF6F5F1FFF6F4F0FFF5F2EFFFF5F2EFFFF5F2EFFFF4F1
        EDFFF4F1ECFFF3F0ECFFF2EFECFFF2EFEBFFF2EFEAFFF2EEE9FFF1EDE9FFF0EC
        E8FFEFECE8FFEFECE6FFFAF7F1FFA2A19EADFFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0081818090FFFF
        FFFFFFFFFFFFFFFFFEFFFFFFFEFFFFFFFDFFF8F7FCFFE5E4FDFFFFFFFCFFFFFD
        FBFFFFFCFBFFFEFCF9FFFEFCF9FFFDFCF9FFFDFBF8FFFCFAF8FFFCF9F6FFFCF9
        F6FFFBF9F6FFFBF8F5FFFAF8F4FFF9F7F3FFF9F6F3FFF9F6F2FFFDFAF6FFFCF9
        F4FFFCF9F4FFFBF8F4FFFBF7F3FFFBF7F2FFF6F2EDFFF5F2EDFFF9F5F1FFF8F4
        F0FFF7F4EFFFF7F4EEFFFFFFF9FFA8A7A4B4FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00706F6F72E0E0
        E0D5DEDEDCD5DEDDDCD5DEDDDCD5DFDEDCD5D7D6DCD5C6C5DBD5DFDFDBD5DDDC
        DBD5DDDCDAD5DCDBDAD5DCDBDAD5DCDBDAD5DCDAD9D5DBDAD9D5DBDAD9D5DBDA
        D8D5DADAD8D5DAD9D8D5DAD9D7D5DAD9D6D5DAD8D6D5DAD8D6D5BAB8B7BBBAB8
        B6BBB9B8B6BBB9B8B5BBB9B7B5BBB9B7B5BBD8D6D4D5D8D6D4D5B8B6B4BBB8B6
        B4BBB8B6B4BBB7B5B3BBBEBCBABB7B7B797DFFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00}
      ShowHint = False
      Transparent = True
    end
    object Label2: TLabel
      Left = 62
      Top = 24
      Width = 340
      Height = 23
      Caption = 'Sele'#231#227'o de Cheque para Pagamento'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -19
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
  end
  object ActionToolBarPrincipal: TActionToolBar
    AlignWithMargins = True
    Left = 3
    Top = 377
    Width = 577
    Height = 26
    ActionManager = ActionManagerLocal
    Align = alBottom
    BiDiMode = bdRightToLeft
    Caption = 'ActionToolBarPrincipal'
    ColorMap.BtnSelectedColor = clBtnFace
    ColorMap.UnusedColor = 15660791
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    Orientation = boRightToLeft
    ParentBiDiMode = False
    ParentFont = False
    Spacing = 5
    ExplicitHeight = 24
  end
  object PageControlItens: TPageControl
    Left = 0
    Top = 65
    Width = 583
    Height = 307
    ActivePage = tsDados
    Align = alClient
    TabOrder = 2
    ExplicitWidth = 483
    ExplicitHeight = 225
    object tsDados: TTabSheet
      Caption = 'Informa'#231#227'o dos dados e sele'#231#227'o do cheque'
      ExplicitHeight = 281
      object PanelDados: TPanel
        Left = 0
        Top = 0
        Width = 575
        Height = 279
        Align = alClient
        BevelOuter = bvNone
        TabOrder = 0
        ExplicitHeight = 281
        DesignSize = (
          575
          279)
        object Bevel2: TBevel
          Left = 3
          Top = 3
          Width = 569
          Height = 270
          Anchors = [akLeft, akTop, akRight, akBottom]
          ExplicitHeight = 241
        end
        object GridCheques: TJvDBUltimGrid
          Left = 9
          Top = 139
          Width = 556
          Height = 128
          Anchors = [akLeft, akBottom]
          DataSource = DSChequesEmSer
          ReadOnly = True
          TabOrder = 4
          TitleFont.Charset = DEFAULT_CHARSET
          TitleFont.Color = clWindowText
          TitleFont.Height = -11
          TitleFont.Name = 'Tahoma'
          TitleFont.Style = []
          TitleButtons = True
          AlternateRowColor = 15593713
          TitleArrow = True
          SelectColumnsDialogStrings.Caption = 'Select columns'
          SelectColumnsDialogStrings.OK = '&OK'
          SelectColumnsDialogStrings.NoSelectionWarning = 'At least one column must be visible!'
          CanDelete = False
          EditControls = <>
          RowsHeight = 17
          TitleRowHeight = 17
          SortWith = swFields
          Columns = <
            item
              Expanded = False
              FieldName = 'NOME_CONTA_CAIXA'
              Title.Caption = 'Conta Caixa'
              Width = 300
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'TALAO'
              Title.Caption = 'Tal'#227'o'
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'NUMERO_TALAO'
              Title.Caption = 'N'#250'mero Tal'#227'o'
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'NUMERO_CHEQUE'
              Title.Caption = 'N'#250'mero Cheque'
              Visible = True
            end>
        end
        object EditBomPara: TLabeledDateEdit
          Left = 9
          Top = 67
          Width = 138
          Height = 21
          TabOrder = 1
          DateEditLabel.Width = 89
          DateEditLabel.Height = 13
          DateEditLabel.Caption = 'Cheque Bom Para:'
        end
        object EditValorCheque: TLabeledCalcEdit
          Left = 9
          Top = 112
          Width = 138
          Height = 21
          DisplayFormat = ',0.00##'
          TabOrder = 2
          DecimalPlacesAlwaysShown = False
          CalcEditLabel.Width = 83
          CalcEditLabel.Height = 13
          CalcEditLabel.Caption = 'Valor do Cheque:'
        end
        object MemoHistorico: TLabeledMemo
          Left = 153
          Top = 67
          Width = 412
          Height = 66
          Anchors = [akLeft, akBottom]
          ScrollBars = ssVertical
          TabOrder = 3
          MemoLabel.Width = 45
          MemoLabel.Height = 13
          MemoLabel.Caption = 'Hist'#243'rico:'
          ExplicitTop = 69
        end
        object EditNominalA: TLabeledEdit
          Left = 9
          Top = 24
          Width = 556
          Height = 21
          EditLabel.Width = 90
          EditLabel.Height = 13
          EditLabel.Caption = 'Cheque Nominal a:'
          TabOrder = 0
        end
      end
    end
  end
  object ActionManagerLocal: TActionManager
    ActionBars.ShowHints = False
    ActionBars = <
      item
      end
      item
        Items = <
          item
            Caption = '-'
          end
          item
            Caption = '-'
          end
          item
            Caption = '-'
          end>
      end
      item
      end
      item
        Items = <
          item
            Action = ActionCancelar
            Caption = '&Cancelar [F11]'
            ImageIndex = 10
            ShortCut = 122
          end>
      end
      item
      end
      item
        Items = <
          item
            Action = ActionConfirmar
            Caption = 'C&onfirmar [F12]'
            ImageIndex = 9
          end
          item
            Action = ActionCancelar
            Caption = '&Cancelar [F11]'
            ImageIndex = 10
            ShortCut = 122
          end>
        ActionBar = ActionToolBarPrincipal
      end
      item
      end
      item
      end
      item
      end
      item
        Items = <
          item
            Caption = '-'
          end
          item
            Caption = '-'
          end>
      end>
    DisabledImages = FDataModule.ImagensCadastrosD
    Images = FDataModule.ImagensCadastros
    Left = 488
    Top = 16
    StyleName = 'Ribbon - Silver'
    object ActionCancelar: TAction
      Category = 'Geral'
      Caption = 'Cancelar [F11]'
      ImageIndex = 10
      ShortCut = 122
      OnExecute = ActionCancelarExecute
    end
    object ActionConfirmar: TAction
      Category = 'Geral'
      Caption = 'Confirmar [F12]'
      ImageIndex = 9
      OnExecute = ActionConfirmarExecute
    end
  end
  object CDSChequesEmSer: TClientDataSet
    Active = True
    Aggregates = <>
    FieldDefs = <
      item
        Name = 'ID_CONTA_CAIXA'
        DataType = ftInteger
      end
      item
        Name = 'NOME_CONTA_CAIXA'
        DataType = ftString
        Size = 50
      end
      item
        Name = 'TALAO'
        DataType = ftString
        Size = 10
      end
      item
        Name = 'NUMERO_TALAO'
        DataType = ftInteger
      end
      item
        Name = 'NUMERO_CHEQUE'
        DataType = ftInteger
      end
      item
        Name = 'ID_TALAO'
        DataType = ftInteger
      end
      item
        Name = 'ID_CHEQUE'
        DataType = ftInteger
      end>
    IndexDefs = <>
    PacketRecords = 0
    Params = <>
    StoreDefs = True
    Left = 385
    Top = 248
    Data = {
      BE0000009619E0BD010000001800000007000000000003000000BE000E49445F
      434F4E54415F43414958410400010000000000104E4F4D455F434F4E54415F43
      4149584101004900000001000557494454480200020032000554414C414F0100
      490000000100055749445448020002000A000C4E554D45524F5F54414C414F04
      000100000000000D4E554D45524F5F4348455155450400010000000000084944
      5F54414C414F04000100000000000949445F4348455155450400010000000000
      0000}
    object CDSChequesEmSerID_CONTA_CAIXA: TIntegerField
      FieldName = 'ID_CONTA_CAIXA'
    end
    object CDSChequesEmSerNOME_CONTA_CAIXA: TStringField
      FieldName = 'NOME_CONTA_CAIXA'
      Size = 50
    end
    object CDSChequesEmSerTALAO: TStringField
      FieldName = 'TALAO'
      Size = 10
    end
    object CDSChequesEmSerNUMERO_TALAO: TIntegerField
      FieldName = 'NUMERO_TALAO'
    end
    object CDSChequesEmSerNUMERO_CHEQUE: TIntegerField
      FieldName = 'NUMERO_CHEQUE'
    end
    object CDSChequesEmSerID_TALAO: TIntegerField
      FieldName = 'ID_TALAO'
    end
    object CDSChequesEmSerID_CHEQUE: TIntegerField
      FieldName = 'ID_CHEQUE'
    end
  end
  object DSChequesEmSer: TDataSource
    DataSet = CDSChequesEmSer
    Left = 281
    Top = 248
  end
end
