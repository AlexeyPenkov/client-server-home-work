//
//  ControlFriendListTableView.swift
//  lesson1
//
//  Created by Алексей Пеньков on 22.04.2021.
//

import UIKit

enum Literal: Int {
    case a, b, v, g, d, e, yo, zh, z, i, k, l, m, n, o, p, r, s, t, oo, f, kh, tc, ch, sh, csh, ae, u, ya
    
    static let alfabet: [Literal] = [a, b, v, g, d, e, yo, zh, z, i, k, l, m, n, o, p, r, s, t, oo, f, kh, tc, ch, sh, csh, ae, u, ya]
    
    var title: String {
        switch self {
        case .a: return "А"
        case .b: return "Б"
        case .v: return "В"
        case .g: return "Г"
        case .d: return "Д"
        case .e: return "Е"
        case .yo: return "Ё"
        case .zh: return "Ж"
        case .z: return "З"
        case .i: return "И"
        case .k: return "К"
        case .l: return "Л"
        case .m: return "М"
        case .n: return "Н"
        case .o: return "О"
        case .p: return "П"
        case .r: return "Р"
        case .s: return "С"
        case .t: return "Т"
        case .oo: return "У"
        case .f: return "Ф"
        case .kh: return "Х"
        case .tc: return "Ц"
        case .ch: return "Ч"
        case .csh: return "Щ"
        case .ae: return "Э"
        case .u: return "Ю"
        case .ya: return "Я"
        case .sh: return "Ш"
        }
    }
}
    

protocol CustomControlProtocol: class {
    func setFindLiteral(literal: Literal?)
}


class ControlFriendListTableView: UIControl {
    var selectedLiteral: Literal? = nil {
        didSet {
            self.updateSelectedLiteral()
            self.sendActions(for: .valueChanged)
        }
    }
    
    private var buttons: [UIButton] = []
    private var stackView: UIStackView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.setupView()
    }
    
    private func setupView() {
        for literal in Literal.alfabet {
            let button = UIButton(type: .system)
            button.setTitle(literal.title, for: .normal)
            button.setTitleColor(.lightGray, for: .normal)
            button.setTitleColor(.white, for: .selected)
            button.addTarget(self, action: #selector(selectLiteral(_:)), for: .touchUpInside)
            self.buttons.append(button)
        }
        
        stackView = UIStackView(arrangedSubviews: self.buttons)
        
        self.addSubview(stackView)
        
        stackView.spacing = 20
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.distribution = .fillEqually
    }
    
    private func updateSelectedLiteral() {
        for (index, button) in self.buttons.enumerated() {
            guard let literal = Literal(rawValue: index) else { continue }
            button.isSelected = literal == self.selectedLiteral
        }
    }
    
    @objc private func selectLiteral(_ sender: UIButton) {
        guard let index = self.buttons.firstIndex(of: sender) else { return }
        guard let literal = Literal(rawValue: index) else { return }
        self.selectedLiteral = literal
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        stackView.frame = bounds
    }
    
}

