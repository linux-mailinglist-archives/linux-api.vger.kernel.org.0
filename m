Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD7A725F80E
	for <lists+linux-api@lfdr.de>; Mon,  7 Sep 2020 12:26:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728811AbgIGK0B (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 7 Sep 2020 06:26:01 -0400
Received: from mail-eopbgr40096.outbound.protection.outlook.com ([40.107.4.96]:32894
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728525AbgIGKZy (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Mon, 7 Sep 2020 06:25:54 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Pzo+WvnaC6+qZO/pvrClw276mEfXmlsYjFes+N7GtCj6GpRhjMWEdG8W3j668rGqznY0ks5ZTW0mpbu0DQajsheQqpKXyQ+zmJGcJGa1vQopWv/NxLWgljdKbFNqsx77eG/WOl+OlrEWrQuSy6Q/smzfoxUr4qrLOTGHkdKzuCmsJyc+lWEyqhN+SYSW5CI+MS7M+LiUBZ/1fKSIdalGFcRiahp/nM2NCJ9E5LKzs4rB90hpYYlKcI2SGJlROoeHU8VjpiUTyFhUnx8S9LmwY7FAPC9jv6BchfLA+yHsoCxH7kLPcFXTqBsZzsbakCtGMnnPcYEqf/3XCY6Fy+IGCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XOTJHRkLc06PNbfrHoSfnobwRGTa7tX+ibuiGbU+Sw8=;
 b=EjGm30qT2gyH31m1KQp5lw1ljm5S9V5LiT5vbpINBUKxi+g/4o4Ri3RkH3aOtpGHKTSpR8wIXpb3ZVZ+g1hhrbjDBPBfV6j12eZ8VAUvG3UafQN6H9oXq4K1NYe3JIWaJQ25YTNHc/gbqwvquX/FbJgrINXRoHFJpMPVmP/w72ziVyTKpB4ppg7PjELnqfvIQzXcE4EQ7SowNQ5HycQXz7i5lAjy3DaYPyIF6/S2HoqKogYcWRuXYbCN1kpU+6Ir6ghCKogoGdkTmgt5koGOqykoXcVjty4gkca/Ej5VQvBaM2mbVwvM9sX5XkdPHBisqne7GAgmg7VXMBute7rx4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bitdefender.com; dmarc=pass action=none
 header.from=bitdefender.com; dkim=pass header.d=bitdefender.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bitdefender.onmicrosoft.com; s=selector2-bitdefender-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XOTJHRkLc06PNbfrHoSfnobwRGTa7tX+ibuiGbU+Sw8=;
 b=FxkquCZkUCEh9LFgWGsye2N4HYaozlzkc9UZO1GiMnOuU3Z+T/51KwcNA1QQj4wS8ze4VwbDw0rC8cICx7vhPzKL6ggwhlINWqjMWyHZDpUlp3cSyoTp/IJj4F+x9uXW43eY/6lj/yeZRZzZuShlAyf9erpf35IaX5jrnpY/ncs=
Received: from AM7PR02MB6082.eurprd02.prod.outlook.com (2603:10a6:20b:1af::16)
 by AM6PR02MB4549.eurprd02.prod.outlook.com (2603:10a6:20b:62::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3348.15; Mon, 7 Sep
 2020 10:25:50 +0000
Received: from AM7PR02MB6082.eurprd02.prod.outlook.com
 ([fe80::9dcc:d3cc:dbe:5b33]) by AM7PR02MB6082.eurprd02.prod.outlook.com
 ([fe80::9dcc:d3cc:dbe:5b33%8]) with mapi id 15.20.3348.019; Mon, 7 Sep 2020
 10:25:50 +0000
From:   Mircea CIRJALIU - MELIU <mcirjaliu@bitdefender.com>
To:     Andy Lutomirski <luto@kernel.org>,
        =?utf-8?B?QWRhbGJlcnQgTGF6xINy?= <alazar@bitdefender.com>
CC:     Linux-MM <linux-mm@kvack.org>,
        Linux API <linux-api@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexander Graf <graf@amazon.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Jerome Glisse <jglisse@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        =?utf-8?B?TWloYWkgRG9uyJt1?= <mdontu@bitdefender.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Sargun Dhillon <sargun@sargun.me>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Oleg Nesterov <oleg@redhat.com>, Jann Horn <jannh@google.com>,
        Kees Cook <keescook@chromium.org>,
        Matthew Wilcox <willy@infradead.org>,
        Christian Brauner <christian.brauner@ubuntu.com>
Subject: RE: [RESEND RFC PATCH 0/5] Remote mapping
Thread-Topic: [RESEND RFC PATCH 0/5] Remote mapping
Thread-Index: AQHWgq7sJAwNYCdpy0yn8gtG4wotq6lY4MAAgAQXCeA=
Date:   Mon, 7 Sep 2020 10:25:50 +0000
Message-ID: <AM7PR02MB6082589CFC5C0C2848495553BB280@AM7PR02MB6082.eurprd02.prod.outlook.com>
References: <20200904113116.20648-1-alazar@bitdefender.com>
 <CALCETrVc0RCcvVhxL=x2ics-Snhh1F6o5M7EVsA2rPYcaynMyA@mail.gmail.com>
In-Reply-To: <CALCETrVc0RCcvVhxL=x2ics-Snhh1F6o5M7EVsA2rPYcaynMyA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=bitdefender.com;
x-originating-ip: [31.5.46.39]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0183a4de-b0ca-4c19-da6e-08d8531864b2
x-ms-traffictypediagnostic: AM6PR02MB4549:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM6PR02MB4549A8861CA4BD647E911194BB280@AM6PR02MB4549.eurprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: dcqLI43yoYXx6HreFOC3iBqJZvFlupQf9Vz4yzDOmTtqoiovl/tZuhSTNJYf9x82cw9oruZbAZDgojWEl8ZiCWAxECeoh/MHBu5Ouu+/bgE196wn9Euax6+ZjOMGh3ILiet/jlxP/6BrrCvDmwBFDojyAbigECzWcmTwUCUfqjmdSkwoI7laEzk1+qjJ4Zk2YHnwwPe3ptrENxo34+wogZn1hUdXh+H0JyPHPPgxIwioNLUfZb1hoe1DRsnR8axcGraEa2CFCplBRjzgTp/bjZ4UDIYI2hN/NkLEZK4/+Hj8JHFa4YYnbpwxlKbt3t682jRdvET9L/TFnabd7j2zbA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM7PR02MB6082.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(396003)(39850400004)(136003)(346002)(376002)(6636002)(66446008)(186003)(52536014)(71200400001)(86362001)(478600001)(2906002)(55016002)(64756008)(9686003)(66556008)(76116006)(66476007)(66946007)(54906003)(33656002)(7416002)(316002)(5660300002)(83380400001)(4744005)(110136005)(8936002)(8676002)(7696005)(26005)(4326008)(6506007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: iaCgljNWgWAQPEikejLO4mY1byAqgVZHlTGHKWLGcKzxQxquroljTKg21H3l4phIseXO86IqGN7V1TETSM76MZSNFuVkezymp16V4gqmZRBO9xg/pyPQ5SRtvzij6faOGZ6M/EA83SrEcZe7sjt++uZkPKsR4aXcPXUQwujLCp7NBiM2Gu5S93yMlK0V1Xh21we51p0HMwH/YpUdJh1v+SS8nfyjc9G1sj5lmA9aU533dtZmEQuFpm85YMFZIoxOmM6LNEvOy3lN8cPDT8pS8DJ/+1Qd59S1FKB2XHJyK7h0AEzILDkl6p6yzt3h2hIm19jhmOeN/NND+QZRE9/aDvXHuvmXWea4/98K3EgA5L7IWb/BoOD4Lstq8eTVej0XwticjRzXsi7XhqEhfZ/zfklGEPBlN2WGIHZNMKY4mgsk/8NVt91JAQy24hgso+d4lHugXvHsBVVDH70X/2Pvz2iEX10N6GJPoNGDUzx1O9rjggZyRIa/0EPxU29+MOLRJeTgFJBO+UsYbwSIgfebj6o7UY1ZcwSxxbJylZTvgL5xpFggUX6Ll/ASHLM5or3SN7282t6f+Qn2WO2+S1wTAuIw+JcCaJP8d4+IS+4SZ2HRm4C5muwL7Q/634c3UZNNTkphNSs62orbpNFKcnIN2A==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: bitdefender.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM7PR02MB6082.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0183a4de-b0ca-4c19-da6e-08d8531864b2
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Sep 2020 10:25:50.5991
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 487baf29-f1da-469a-9221-243f830c36f3
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: axyNqPkPeK36ydjWVhcWyQzerhNTAjDyoHkUxHhrJO9IWdFI8Kkeb7ueVuTJUKNLfPHwBf3gBNIQgLYDeotkc4jt5y99anKZ/W4L4707UKk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR02MB4549
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

PiBGcm9tOiBBbmR5IEx1dG9taXJza2kgPGx1dG9Aa2VybmVsLm9yZz4NCj4gSSB0aGluayB0aGlz
IGlzIHZlcnkgY2xldmVyLCBidXQgSSBmaW5kIG15c2VsZiB3b25kZXJpbmcgd2hhdCBoYXBwZW5z
IGlmIHBlb3BsZQ0KPiBzdGFydCB0cnlpbmcgdG8gYWJ1c2UgdGhpcyBieSwgZm9yIGV4YW1wbGUs
IHNldHRpbmcgdXAgYSByZW1vdGUgbWFwcGluZw0KPiBwb2ludGluZyB0byBmdW4gcmVnaW9ucyBs
aWtlIHVzZXJmYXVsdGZkIG9yIGFub3RoZXIgcmVtb3RlIG1hcHBpbmcuDQoNCkNhbiBwdHJhY2Uo
KSBiZSB1c2VkIHRvIGFidXNlIGZ1biByZWdpb25zIG9mIGEgcHJvY2VzcyBhZGRyZXNzIHNwYWNl
Pw0KUmVtb3RlIG1hcHBpbmcgcmVjdXJzaXZlbmVzcyBjYW4gYmUgZWxpbWluYXRlZCBieSBjaGVj
a2luZyB0aGUgVk1BIHRoZQ0KcmVtb3RlIHBhZ2UgaXMgZXh0cmFjdGVkIGZyb20uIChOWUkpDQoN
Cj4gSSdtIGEgbGl0dGxlIGNvbmNlcm5lZCB0aGF0IGl0J3MgYWN0dWFsbHkgdG9vIGNsZXZlciBh
bmQgdGhhdCBtYXliZSBhIG1vcmUNCj4gc3RyYWlnaHRmb3J3YXJkIHNvbHV0aW9uIHNob3VsZCBi
ZSBpbnZlc3RpZ2F0ZWQuICBJIHBlcnNvbmFsbHkgcmF0aGVyIGRpc2xpa2UNCj4gdGhlIEtWTSBt
b2RlbCBpbiB3aGljaCB0aGUgZ3Vlc3QgYWRkcmVzcyBzcGFjZSBtaXJyb3JzIHRoZSBob3N0IChR
RU1VKQ0KPiBhZGRyZXNzIHNwYWNlIHJhdGhlciB0aGFuIGJlaW5nIGl0cyBvd24gdGhpbmcuDQoN
CkkndmUgc2VlbiBhIGZldyBpbnRlcm5hbCBtbWFwKClzIHRocm91Z2hvdXQgdGhlIGtlcm5lbC4g
SnVzdCB3b25kZXJpbmcgaG93DQptZW1vcnkgYWNjb3VudGluZyBpcyBpbXBsZW1lbnRlZCBmb3Ig
dGhlc2UgY2FzZXMuIFdpbGwgdGhpcyBiZSByZWZsZWN0ZWQgaW4NCnRoZSBtZW1vcnkgdXNhZ2Ug
b2YgdGhlIHByb2Nlc3MgdGhhdCBjb250cm9scyBzdWNoIGEgbW9kdWxlPyBFc3BlY2lhbGx5IGlu
DQp0aGUgY2FzZSBvZiBhIHZpcnR1YWwgbWFjaGluZSB0aGF0IG5lZWRzIGEgZmV3IEdCcyBvZiBt
ZW1vcnkuDQoNCk1pcmNlYQ0KDQo=
