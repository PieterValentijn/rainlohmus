object fmMain: TfmMain
  Left = 0
  Top = 0
  Caption = 'Rain Lohmus Address Finder'
  ClientHeight = 473
  ClientWidth = 873
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Lucida Console'
  Font.Style = []
  Position = poScreenCenter
  OnCloseQuery = FormCloseQuery
  OnCreate = FormCreate
  DesignSize = (
    873
    473)
  TextHeight = 12
  object bGo: TButton
    Left = 20
    Top = 8
    Width = 75
    Height = 25
    Caption = 'Go'
    TabOrder = 0
    OnClick = bGoClick
  end
  object bStop: TButton
    Left = 136
    Top = 8
    Width = 75
    Height = 25
    Caption = 'Stop'
    Enabled = False
    TabOrder = 1
    OnClick = bStopClick
  end
  object bShowAccount: TButton
    Left = 288
    Top = 8
    Width = 281
    Height = 25
    Caption = 'Rain Lohmus account on the web'
    TabOrder = 2
    OnClick = bShowAccountClick
  end
  object pcMain: TPageControl
    Left = 16
    Top = 47
    Width = 841
    Height = 418
    ActivePage = tsSettings
    Anchors = [akLeft, akTop, akRight, akBottom]
    TabOrder = 3
    object tsLog: TTabSheet
      Caption = 'Log'
      object mlog: TMemo
        Left = 0
        Top = 0
        Width = 833
        Height = 390
        Align = alClient
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Lucida Console'
        Font.Style = []
        Lines.Strings = (
          'NOV 07, 2023'
          ''
          
            'LHV Bank founder has $470M worth of Ethereum, but lost his priva' +
            'te key'
          
            'Rain L'#245'hmus, founder of LHV Bank, told Estonian media last month' +
            ' that he'#8217's not made much effort to recover the funds '
          'but is '
          'willing to pay someone who can.'
          ''
          
            'LHV Bank founder has $470M worth of Ethereum, but lost his priva' +
            'te key'
          'Own this piece of crypto history'
          ''
          
            'The founder of Estonia-based LHV Bank, Rain L'#245'hmus, has been rev' +
            'ealed as the owner of a massive 250,000-Ether'
          
            'ETH stash bought during the Ethereum initial coin offering, whic' +
            'h is now worth an eye-watering $470 million.'
          ''
          'There'#8217's only one problem: He no longer has the keys.'
          
            'In February, Coinbase director Conor Grogan highlighted an Ether' +
            'eum whale wallet containing some $470 million worth '
          'of '
          'ETH, untouched since the blockchain'#8217's genesis.'
          
            'In an Nov. 6 update on X (Twitter), Conor highlighted L'#245'hmus'#8217' co' +
            'mments in a recent interview that now tie him to the '
          '$470 '
          'million worth of trapped ETH.'
          
            #8220'One mystery solved,'#8221' wrote Grogan, who shared an excerpt of an ' +
            'Oct. 31 ERR News report on an earlier Vikerraadio '
          'interview '
          'with L'#245'hmus.'
          ''
          
            'Rain Lohmus, founder of LHV Bank. He has offered to split the wa' +
            'llet holdings with anyone that can help recover the '
          'private '
          'keys of the address.')
        ParentFont = False
        ReadOnly = True
        TabOrder = 0
      end
    end
    object tsAbout: TTabSheet
      Caption = 'About'
      ImageIndex = 1
      object mabout: TMemo
        Left = 0
        Top = 0
        Width = 833
        Height = 390
        Align = alClient
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Lucida Console'
        Font.Style = []
        Lines.Strings = (
          
            'All do a 256 bit key is hard to find there is still a chance of ' +
            'luck.'
          ''
          
            'This program trys random private keys and sees if it matches the' +
            ' purblic key of Rain Lohmus.'
          
            'If its found the key will be writen to a textfile and also showe' +
            'd in the log window.'
          
            'If this program helps you find the key you are entitled to the h' +
            'alf of this account.'
          ''
          'Please also make a donation to me and Stefan :-)'
          
            'https://www.linkedin.com/in/pieter-valentijn-93567a/?originalSub' +
            'domain=nl'
          'https://www.linkedin.com/in/svanas/'
          ''
          'It works fully offchain and does not need internet.'
          
            'ITs like gambeling but with just the cost of the energy and hard' +
            'ware with the big pot of '
          '125.000 ETH'
          ''
          'This program is created with Delphi '
          'and '
          'Delphereum'
          
            'https://svanas.medium.com/connecting-delphi-to-the-ethereum-main' +
            '-net-5faf1feffd83')
        ParentFont = False
        ReadOnly = True
        TabOrder = 0
      end
    end
    object tsSettings: TTabSheet
      Caption = 'Settings'
      ImageIndex = 2
      object Label1: TLabel
        Left = 16
        Top = 24
        Width = 231
        Height = 12
        Caption = 'Sleep between jobs in miliseconds'
      end
      object Label2: TLabel
        Left = 16
        Top = 72
        Width = 49
        Height = 12
        Caption = 'Threads'
      end
      object Label3: TLabel
        Left = 16
        Top = 128
        Width = 63
        Height = 12
        Caption = 'Algorithm'
      end
      object spSleep: TSpinEdit
        Left = 16
        Top = 42
        Width = 195
        Height = 21
        MaxValue = 0
        MinValue = 0
        TabOrder = 0
        Value = 0
      end
      object spThreads: TSpinEdit
        Left = 16
        Top = 90
        Width = 195
        Height = 21
        MaxValue = 8
        MinValue = 1
        TabOrder = 1
        Value = 1
      end
      object cbAlgo: TComboBox
        Left = 16
        Top = 146
        Width = 337
        Height = 20
        Style = csDropDownList
        ItemIndex = 1
        TabOrder = 2
        Text = 'Random key generate then random byte changes'
        Items.Strings = (
          'Random key generate'
          'Random key generate then random byte changes')
      end
    end
  end
end
