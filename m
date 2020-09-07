Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D97E925FDFC
	for <lists+linux-api@lfdr.de>; Mon,  7 Sep 2020 18:04:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730318AbgIGQE0 (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 7 Sep 2020 12:04:26 -0400
Received: from mail-eopbgr30119.outbound.protection.outlook.com ([40.107.3.119]:32913
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730182AbgIGQEW (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Mon, 7 Sep 2020 12:04:22 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Wn+Nc8XzABJwM7ujnGmLjCxxP/JKastqx3UtuviLCNSYpl0Os+mbXfUYZWuqGnhpRssoozJLa5YDcpP7ggh1+BXW/rCOlvUpl4WY8dmCRcUgsW4Gp2bfFWkdPA4QyftR/asSRXQDhxM1cYxYgyjVL2rGGuN5tkwnt+PoEV2CuR6vt84SyWMqAhWm71LjJP0plM/dr1xKCe8FvEmw0a5Xu2uyZk85gsCW6klRufJeCGwY+42NZ+HggVWkFZwzZGac/YGP2kr9aTTPa0ru+HG/Sm9hyqxNct/JO5lHswcxU8tnA7y/XMKmvCnEdAIFiES6z5EGah615nKwWan4yz3w4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I/PLvm5WZ7gHwSit8xtPhH0Ey55r0J9Z3zVNkeknKbQ=;
 b=XXpzetmHU2lrYqbtTFDdhWGZIeZ33eQOneE0505a8pK6fLzSHRPW0IeGr1XsKUl8NQuuahbL1KngBsdpSNcjxWrE8EfGMqYy4FwkszV7eyesh9+MF/IBV+Fwz6RWhd2vAlqv9T9PuAIgoX2I/wauCR27Pi4E1WA6MV2QNInV2mGZ5+HZCi0pSLKM0j8xcalm4G6tWQ2eRtR4Max5Qu78LHQW1s+U3Ec9ebma5tMCwmCYCJzlhSWwmrvxmb4VXRlFORECDukGCU4FbO9Ngg84Gfcgk04SAqVxUGfejey0y7zP2jmZKFiOZSnVWEjAjPCESBigdAm0F631iepFYrEFdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bitdefender.com; dmarc=pass action=none
 header.from=bitdefender.com; dkim=pass header.d=bitdefender.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bitdefender.onmicrosoft.com; s=selector2-bitdefender-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I/PLvm5WZ7gHwSit8xtPhH0Ey55r0J9Z3zVNkeknKbQ=;
 b=XJ5ox4+EKBl1JlVNPo3XIE6HtqgoD5mu9atHyPx0A5oNlPf/iOLIHm4zYweesFolh5oNib3llxRcRDwgki9QMj/V3ijZdhgZ1/GfBNv4Wj0lK83B2Lj8RS5ilkdJE35WKmco40Jwj6hKApRuhegyislmv5BXOa/tnAuPi5dmWiU=
Received: from AM7PR02MB6082.eurprd02.prod.outlook.com (2603:10a6:20b:1af::16)
 by AM6PR02MB5303.eurprd02.prod.outlook.com (2603:10a6:20b:80::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3348.15; Mon, 7 Sep
 2020 16:04:18 +0000
Received: from AM7PR02MB6082.eurprd02.prod.outlook.com
 ([fe80::9dcc:d3cc:dbe:5b33]) by AM7PR02MB6082.eurprd02.prod.outlook.com
 ([fe80::9dcc:d3cc:dbe:5b33%8]) with mapi id 15.20.3348.019; Mon, 7 Sep 2020
 16:04:18 +0000
From:   Mircea CIRJALIU - MELIU <mcirjaliu@bitdefender.com>
To:     Christian Brauner <christian.brauner@ubuntu.com>,
        =?utf-8?B?QWRhbGJlcnQgTGF6xINy?= <alazar@bitdefender.com>
CC:     "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexander Graf <graf@amazon.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Jerome Glisse <jglisse@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        =?utf-8?B?TWloYWkgRG9uyJt1?= <mdontu@bitdefender.com>,
        Andy Lutomirski <luto@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Sargun Dhillon <sargun@sargun.me>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Oleg Nesterov <oleg@redhat.com>, Jann Horn <jannh@google.com>,
        Kees Cook <keescook@chromium.org>,
        Matthew Wilcox <willy@infradead.org>
Subject: RE: [RESEND RFC PATCH 4/5] mm/remote_mapping: use a pidfd to access
 memory belonging to unrelated process
Thread-Topic: [RESEND RFC PATCH 4/5] mm/remote_mapping: use a pidfd to access
 memory belonging to unrelated process
Thread-Index: AQHWgq7udc7sgvAgO02/se2hAi+LbKldSo8AgAANspA=
Date:   Mon, 7 Sep 2020 16:04:18 +0000
Message-ID: <AM7PR02MB6082315C8E87B1F8D3865C93BB280@AM7PR02MB6082.eurprd02.prod.outlook.com>
References: <20200904113116.20648-1-alazar@bitdefender.com>
 <20200904113116.20648-5-alazar@bitdefender.com>
 <20200907150254.isjrpr2eozoyg2uh@wittgenstein>
In-Reply-To: <20200907150254.isjrpr2eozoyg2uh@wittgenstein>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: ubuntu.com; dkim=none (message not signed)
 header.d=none;ubuntu.com; dmarc=none action=none header.from=bitdefender.com;
x-originating-ip: [31.5.46.39]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 051a3fc6-7448-4c12-e3db-08d85347ad05
x-ms-traffictypediagnostic: AM6PR02MB5303:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM6PR02MB5303E09815E0C7CA0917D89BBB280@AM6PR02MB5303.eurprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5236;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: xj3VSl4/vSRzV9SfjMgbf3di8lRtI/FduJKDbf1A33HJm7sn+sbSq3RyESZb2y/4lBv4rSjRvz/B2P5ajYXTJ1Llb++yEyCVhzcmvzdoPCexsdGUaMvwCk4q3X8bmR5ZRW9AwHt8M6+YprKlOuxHvHhNKqxJ55Oy2BvUhWmwjmIGY1eL7b06k4opYkKDu217cJDR4i+Wc1PhGGmMguYKUVp7UgrQw9HVNLzz+RPNttmxZIxiSf29F6KSl/GzVTeTa6PzrXkxUMfwDUQEGT/rwnzUwDx24LkbkbLfkWljikPtYw3DJgmC4HS5FgcQrdEoBt2mPtozuX7z7TtLL7lRSg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM7PR02MB6082.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(136003)(396003)(366004)(346002)(39850400004)(52536014)(71200400001)(9686003)(7696005)(8936002)(7416002)(4326008)(8676002)(110136005)(5660300002)(4744005)(54906003)(6506007)(86362001)(33656002)(478600001)(64756008)(66946007)(66446008)(66556008)(76116006)(55016002)(316002)(186003)(26005)(2906002)(6636002)(66476007)(83380400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: La8MF74GGuYU0XLg/wpo4W9VXEBGxywril5xXM1js2Opn6b2jGP8g6jaklQz9PaB618Ic5PvAROEah2jyVfFURkcVPd40Q4P7mssgrvv+exJz9uZzak6OQIic14NC9enTG4IrcvsCH2vSPOWPdl7wJXnBiVglnrik2l8YpJqhImnMdLgyAdbaLZKlzYWnI6oMsJONjMnn8tm/Dx/OFJ/vidLxPkCrHqOMqBz5YEo/C/P0e6depL+G0sm2cyB1frQMKLJJlDpXml8L2rog6tJ5ncgUHRULCf41Tzun9NVowLCv1kgUxOo68CV27GxeZ5Qsp9LyBT3O/qwoIDuZDGtKDW5+6BJYcK0N8yDPNseKyjHGrRJRrkB+uwjuNnhR5MyEgzKCtiNxR84npXZiWzGrIeidf9dpJMRCnakC+fLVKHS1pP6WxzpLNWbb/SBQ9A/v61zu42Ln7UDxvdJn0qwI5iDUOoUblklgXRCTYvljpN8ALWelb7tTAUzgsuqyvf6aaiRZ2r4sMqhl5KhTXDWj4FEeEkeO2cu5pGd7WbGveuOevqz7ro3PUyGBzMQoo3P7tgRhRgHG2AGvk9IZvStFi0lqJMENO+y9r0wHuWOgIzOMu4rNCOoe7bctJ1mibkVRZOCeuiBdcXGz+MaYH9z5Q==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: bitdefender.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM7PR02MB6082.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 051a3fc6-7448-4c12-e3db-08d85347ad05
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Sep 2020 16:04:18.1243
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 487baf29-f1da-469a-9221-243f830c36f3
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Xa0gj3deyyCgId6Sou+kNos2qlwrbDxBc7JxxT0O0SafvkQMx1WVcvZme5cvI9ONqX+UZt/qUUZnh2ByBpOb6AR9CfIi5hDAF1MlbWWEvBw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR02MB5303
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

PiBGcm9tOiBDaHJpc3RpYW4gQnJhdW5lciA8Y2hyaXN0aWFuLmJyYXVuZXJAdWJ1bnR1LmNvbT4N
Cj4gDQo+IFJlYWRpbmcgdGhpcywgaXQgcmVhbGx5IGRvZXNuJ3QgZmVlbCBsaWtlIGEgY2xlYW4g
QVBJLiBJIHRoaW5rIGl0IHdvdWxkIGJlIGdyZWF0IGlmDQo+IHlvdSBjb3VsZCBpbnZlc3RpZ2F0
ZSB3aGV0aGVyIHlvdSBjYW4gZ2V0IGEgbW9yZSBmbGV4aWJsZSBhbmQgY2xlYW5lciBkZXNpZ24N
Cj4gb24gdG9wIG9mIG1lbWZkcyBhcyBzdWdnZXN0ZWQgZWxzZXdoZXJlIGluIHRoZSB0aHJlYWQu
DQoNClRoZSBBUEkgbWF5IGJlIGRpcnR5LCBhbmQgdGhhdCBjYW4gYmUgZml4ZWQuIEFueSBzdWdn
ZXN0aW9uIGlzIGFwcHJlY2lhdGVkLg0KQnV0IHRoZSBpbXBsZW1lbnRhdGlvbiB1bmRlcm5lYXRo
IGhhcyBhIHdob2xlIG90aGVyIHB1cnBvc2UgdGhhbiBqdXN0IHNoYXJpbmcgDQptZW1vcnkuDQoN
CkRvaW5nIGEgZGVzaWduIG9uIHRvcCBvZiBtZW1mZCB3aWxsIHN1cmVseSBtYWtlIHNvbWUgcGVv
cGxlIGhhcHB5Lg0KRG9uJ3Qga25vdyB3aGF0IHRvIHNheSBhYm91dCByZXBsYWNpbmcgdGhlIFFF
TVUgYWxsb2NhdG9yIHRob3VnaC4NCg0KTWlyY2VhDQo=
