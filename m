Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E95E5F348A
	for <lists+linux-api@lfdr.de>; Thu,  7 Nov 2019 17:21:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726810AbfKGQVV (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 7 Nov 2019 11:21:21 -0500
Received: from mail-eopbgr00087.outbound.protection.outlook.com ([40.107.0.87]:21730
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726231AbfKGQVV (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Thu, 7 Nov 2019 11:21:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2hEXGtCOnImziRYCIXufE3Ys3UnlJTh1AcB9xxjxrC4=;
 b=lju4yXxK9ZUjo8XQJVqU98NcJ455cNN5sE+XSHkDUOMJGFsg7FMDxscGQ+gvwhbNsUj0HhOZe9N9jwNmXm6LD21cUkIOcqUz1AbYbMXgH4IMjv6KOWUspt8yQB9QwG6klyB3zCB/ufEkltgAWrg6nOE7OjqnkY2G+KFQCDHSUlI=
Received: from DB6PR0801CA0044.eurprd08.prod.outlook.com (2603:10a6:4:2b::12)
 by AM0PR08MB4194.eurprd08.prod.outlook.com (2603:10a6:208:130::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2430.23; Thu, 7 Nov
 2019 16:21:12 +0000
Received: from AM5EUR03FT052.eop-EUR03.prod.protection.outlook.com
 (2a01:111:f400:7e08::201) by DB6PR0801CA0044.outlook.office365.com
 (2603:10a6:4:2b::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2430.22 via Frontend
 Transport; Thu, 7 Nov 2019 16:21:12 +0000
Authentication-Results: spf=fail (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=none action=none
 header.from=arm.com;
Received-SPF: Fail (protection.outlook.com: domain of arm.com does not
 designate 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 AM5EUR03FT052.mail.protection.outlook.com (10.152.17.161) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2430.21 via Frontend Transport; Thu, 7 Nov 2019 16:21:11 +0000
Received: ("Tessian outbound 3fba803f6da3:v33"); Thu, 07 Nov 2019 16:21:11 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: e50c456522bba983
X-CR-MTA-TID: 64aa7808
Received: from c66ed2669a78.1 (cr-mta-lb-1.cr-mta-net [104.47.10.53])
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id E98BE515-F985-4FD3-8CD8-D896EDB84FB7.1;
        Thu, 07 Nov 2019 16:21:06 +0000
Received: from EUR03-DB5-obe.outbound.protection.outlook.com (mail-db5eur03lp2053.outbound.protection.outlook.com [104.47.10.53])
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id c66ed2669a78.1
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Thu, 07 Nov 2019 16:21:06 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hJL0GaQyud/SERIfOHwQRO5ql5CH8JVlQjgUV39rcpn4h07Jfd743h+lexEou9swYCkUhhvyGtmFwoeE36t7TrYZCh0nFsVwokwGUPHMcByghjXmxVqvpFaHNvgo35T7TuS4W5BHagsgiaOxRNyS0Dd9Tas1oSXQBnIwOIrQrAiW03ZSGbyYG1UDYvtARquYCCEj78gZXSwfHT0tProXwWBUQHEQt5NCtrj+Bgwz68PM26amn9GR0DxVQggM+bSGseHnIC5Z7S4Qv7yE8+K8XF6GVOUIzHzlW65RIsZlEtOeDHL+0FMOxZ6i2HVi4OIHafq3x6IjFo1Fsr10GaeFDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2hEXGtCOnImziRYCIXufE3Ys3UnlJTh1AcB9xxjxrC4=;
 b=BHmbY9fCND08ljQmHvex0rx/8w1bFyWDb7cER/0GcqkPBgKUTCG6d+irNYvCqr2PygffUVojg0ML0yVjaghnJdPbLaTsHWwWTXHIFMQkdF2w0lkZwpAGxUZOtANR15itvosOZLX66ovi4UK/PELA7E5h7hEaYb8Tm9i1YjvpzzICHAidBsN/T3yIGiETLhWsbfUyvYD7yrkS4DcENpoxt5JsXG7To2/gEL/JAXq70Z+9f8qjpdEESWcAEb01uTXIJWD/HbVwq9ZcsfJyQ5YUkEDfN7wfYRkVPvqLXU2u6lXg8/2c9uIiFbcB2w0l+OR9jnagt2yHmVi7Rf/DQxFKoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2hEXGtCOnImziRYCIXufE3Ys3UnlJTh1AcB9xxjxrC4=;
 b=lju4yXxK9ZUjo8XQJVqU98NcJ455cNN5sE+XSHkDUOMJGFsg7FMDxscGQ+gvwhbNsUj0HhOZe9N9jwNmXm6LD21cUkIOcqUz1AbYbMXgH4IMjv6KOWUspt8yQB9QwG6klyB3zCB/ufEkltgAWrg6nOE7OjqnkY2G+KFQCDHSUlI=
Received: from DB7PR08MB3292.eurprd08.prod.outlook.com (52.134.111.30) by
 DB7PR08MB3211.eurprd08.prod.outlook.com (52.135.131.32) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2408.24; Thu, 7 Nov 2019 16:21:05 +0000
Received: from DB7PR08MB3292.eurprd08.prod.outlook.com
 ([fe80::21ec:f698:b78e:d4b8]) by DB7PR08MB3292.eurprd08.prod.outlook.com
 ([fe80::21ec:f698:b78e:d4b8%7]) with mapi id 15.20.2408.028; Thu, 7 Nov 2019
 16:21:05 +0000
From:   Szabolcs Nagy <Szabolcs.Nagy@arm.com>
To:     Elichai Turkel <elichai.turkel@gmail.com>,
        Florian Weimer <fweimer@redhat.com>
CC:     nd <nd@arm.com>, Christian Brauner <christian.brauner@ubuntu.com>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        libc-alpha <libc-alpha@sourceware.org>
Subject: Re: Continuing the UAPI split
Thread-Topic: Continuing the UAPI split
Thread-Index: AQHVlWOmBu2Mk0taqkiXBVM0GOE6gqd/nhucgAAOiQCAADdGAA==
Date:   Thu, 7 Nov 2019 16:21:05 +0000
Message-ID: <facb4d0d-4e20-41f0-4c01-b210c677c24c@arm.com>
References: <CALN7hCK0EXLXjPRPr+tuuF2-uQvkLMCFDNzGhv9HS-jrAz6Hmg@mail.gmail.com>
 <0B17C6F2-DC2B-4192-B4AD-BD11D6B9F2B6@ubuntu.com>
 <87zhh7j38y.fsf@oldenburg2.str.redhat.com>
 <CALN7hCJ_umFqC1L0T19CuiGiGoVwac5807NDw4LiDqSD-VJL=Q@mail.gmail.com>
In-Reply-To: <CALN7hCJ_umFqC1L0T19CuiGiGoVwac5807NDw4LiDqSD-VJL=Q@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux aarch64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
x-originating-ip: [217.140.106.54]
x-clientproxiedby: LO2P265CA0278.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a1::26) To DB7PR08MB3292.eurprd08.prod.outlook.com
 (2603:10a6:5:1f::30)
Authentication-Results-Original: spf=none (sender IP is )
 smtp.mailfrom=Szabolcs.Nagy@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 537193d0-3815-476c-518c-08d7639e813d
X-MS-TrafficTypeDiagnostic: DB7PR08MB3211:|AM0PR08MB4194:
X-Microsoft-Antispam-PRVS: <AM0PR08MB4194B849D1DC1D9CB86B664FED780@AM0PR08MB4194.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
x-ms-oob-tlc-oobclassifiers: OLM:9508;OLM:9508;
x-forefront-prvs: 0214EB3F68
X-Forefront-Antispam-Report-Untrusted: SFV:NSPM;SFS:(10009020)(4636009)(346002)(39860400002)(396003)(366004)(136003)(376002)(199004)(189003)(51444003)(26005)(6116002)(2906002)(54906003)(81166006)(58126008)(99286004)(31686004)(386003)(6506007)(110136005)(186003)(53546011)(6246003)(52116002)(66556008)(316002)(71200400001)(7736002)(305945005)(8936002)(66476007)(76176011)(66946007)(71190400001)(66446008)(64756008)(81156014)(478600001)(8676002)(4326008)(6436002)(11346002)(446003)(86362001)(65806001)(25786009)(102836004)(65956001)(14454004)(256004)(6486002)(31696002)(486006)(5660300002)(44832011)(2616005)(476003)(36756003)(6512007)(3480700005)(229853002)(66066001)(3846002);DIR:OUT;SFP:1101;SCL:1;SRVR:DB7PR08MB3211;H:DB7PR08MB3292.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: k/92UqbKNKOyawAuDd+nuoDtLxHebxqsf280bZpKw06X0EY1OoIUPOhitvTHR8hLyUArRm2Az57bsMi6KCQfvl/G6QDWWUaWocJpJLIWzOAjkW7HZe2WxqIPjIkx1S4p+Ck5b8xhmGrfB/OrUGdH3DD6Zcoapsm5k+k0S0fn9OHV1IXYSUL9nsNcM4FOK8E6Bb5fok4yTDRIwQowoPFkXqBPR7TuSqIs495g/FGXs6In6PyVuz0RF1ew5Y4JtLnzQRLksmmAcrAj2BVEv/ZQsPUcKbevs0k3qkeV8KFq2T0merVerzF7EN2AnWZW5cGa0UzHvCnhqUkpt9qzjd9zrkI38ue4V3qvUzLVdhRqG1UxITyls4LmZvTxJ4g/vLiLa37Zou09OywHlYP/QwxVPULC/W74B9xxqKSr5qmRZUkY1Z0iBHp299wh9n1m63b1
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <7259AF935704D94F85E0736EA8EE530F@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR08MB3211
Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Szabolcs.Nagy@arm.com; 
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: AM5EUR03FT052.eop-EUR03.prod.protection.outlook.com
X-Forefront-Antispam-Report: CIP:63.35.35.123;IPV:CAL;SCL:-1;CTRY:IE;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(376002)(396003)(39860400002)(136003)(346002)(1110001)(339900001)(199004)(189003)(51444003)(478600001)(6116002)(3846002)(110136005)(76130400001)(26826003)(50466002)(107886003)(53546011)(7736002)(102836004)(105606002)(31686004)(8936002)(6486002)(2906002)(36906005)(8676002)(47776003)(65806001)(316002)(6512007)(31696002)(65956001)(81156014)(81166006)(436003)(66066001)(58126008)(6506007)(305945005)(22756006)(26005)(54906003)(36756003)(25786009)(86362001)(14454004)(229853002)(2486003)(6246003)(356004)(486006)(23676004)(70586007)(70206006)(76176011)(446003)(11346002)(2616005)(476003)(99286004)(3480700005)(386003)(186003)(336012)(4326008)(5660300002)(126002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR08MB4194;H:64aa7808-outbound-1.mta.getcheckrecipient.com;FPR:;SPF:Fail;LANG:en;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;A:1;MX:1;
X-MS-Office365-Filtering-Correlation-Id-Prvs: a8c7cffd-6f1b-40d9-ffa9-08d7639e7d46
NoDisclaimer: True
X-Forefront-PRVS: 0214EB3F68
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +1S+ZoKw/uXGdgOd09pBtm6RC5NzE29OfoW6bD2fMTJefWzgL+E/YQiqYerdFgwQbnAAQY1k3Qyf4F0EwFIzHRmMg5s8g8Q3UmAiWeXdGLhhcSBfP7HQZPlnYp2BbzlefTFsFuYxFF3WNqpLxJiGdnUkbIs99s9xmMZcsV7pWT5PEsL0AGc/x84th1Cuzp1gaQB20zJSfovToWt10uPemjb5tukRbEd4x1k5Wis/1KYuWsZiRcURHtDV8CVKm4e3TBCTsq7MJsxxfNFqAXrv75yeig+F83kMOCZxZwnIijSKFkVc+TXEAGeoiMJ78rETbuqtuB+wampH6qquaoluMUPzC9tOItZoQvOuRyORXCEsOZQUylidS0H36SizIhwmcoXO0oKzm0UyiOLEoWyn7A4ccVaDQbAtKY8IeKVDTemb0AsKr/L5GnLY2rT91D2B
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2019 16:21:11.9826
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 537193d0-3815-476c-518c-08d7639e813d
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB4194
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

T24gMDcvMTEvMjAxOSAxMzowMywgRWxpY2hhaSBUdXJrZWwgd3JvdGU6DQo+IEEgcmVuYW1lIHRv
IHRoZSBzdHJ1Y3RzL3R5cGVzIHNvIHRoZXkgd29uJ3QgY29sbGlkZSB3aXRoIGxpYmM/DQo+IFBy
aW9yaXRpemluZyBQT1NJWCBjb25mb3JtYW5jZSBpbiB0aGUga2VybmVsKEkgdGhpbmsgdGhhdCBz
aGlwIGhhcyBsb25nIHNhaWxlZCk/DQoNCmhvc3RlZCBjIGNvZGUgY2FuIG9ubHkgdXNlIGxpbnV4
IGFwaSBoZWFkZXJzIHJlbGlhYmx5DQppZiB0aG9zZSByZXNwZWN0IHRoZSBpc28gYyBhbmQgcG9z
aXggcnVsZXMuDQoNCmxpbnV4IHNob3VsZCBtYWludGFpbiBhIGNsZWFuIHNldCBvZiBjIGhlYWRl
cnMgKG9yDQppbnRlcmZhY2UgZGVzY3JpcHRpb25zIGZyb20gd2hpY2ggc3VjaCBoZWFkZXJzIGNh
biBiZQ0KZ2VuZXJhdGVkKS4NCg0KcHJvdmlkaW5nIGNsZWFuIGhlYWRlcnMgdGhhdCB3b3JrIGlu
IGJvdGggaG9zdGVkIGFuZA0KZnJlZXN0YW5kaW5nIGVudmlyb25tZW50cyBpcyBub3QgdHJpdmlh
bDogZS5nLiB0aGUNCmZvcm1lciByZXF1aXJlcyB0eXBlIGRlZmluaXRpb25zIHRvIHVzZSBsaWJj
IHR5cGVzLA0KdGhlIGxhdHRlciByZXF1aXJlcyB0eXBlIGRlZmluaXRpb25zIHRoYXQgZG9uJ3Qg
ZGVwZW5kDQpvbiB0aGUgbGliYy4NCg0KZS5nLiBhIHBvc3NpYmxlIGFwcHJvYWNoIGlzIHRvIHVz
ZSBpc28gYyBpbXBsZW1lbnRhdGlvbg0KcmVzZXJ2ZWQgbmFtZXNwYWNlIGZvciBhbGwgbGludXgg
YXBpIGlkZW50aWZpZXJzLCBzbw0KaXQncyBlbnRpcmVseSBpbmRlcGVuZGVudCBvZiBsaWJjIGFu
ZCBub24tY29uZmxpY3RpbmcsDQp0aGVuIGxpYmMgaGVhZGVycyBjYW4gcmVwbGljYXRlIGRlY2xh
cmF0aW9ucyB0aGF0IGl0DQp3YW50cyB0byBleHBvc2UgKHdpdGggZGlmZmVyZW50IG5hbWVzIGFu
ZCBsaWJjIHR5cGVzKS4NCih0aGVyZSBhcmUgb3RoZXIgd2F5cywgYnV0IHRoZSBjdXJyZW50IGhl
YWRlcnMgYXJlIGhhcmQNCnRvIHVzZSB3aGljaCBhZmZlY3RzIGEgbG90IG9mIHVzZXJzKQ0KDQo+
IE9yIGp1c3QgZ2l2aW5nIHVwIGFuZCB0ZWxsaW5nIHVzZXJzIHRoZXkgY2FuJ3QganVzdCBkaXJl
Y3RseSBpbmNsdWRlDQo+IGJvdGggbGliYyBoZWFkZXJzIGFuZCBrZXJuZWwgaGVhZGVycz8NCg0K
aW5jbHVkaW5nIGJvdGggbGliYyBhbmQgbGludXggaGVhZGVycyBpcyBmcmFnaWxlIGFuZA0Kd2ls
bCBicmVhayBkaWZmZXJlbnRseSBhY3Jvc3MgdGhlIGRpZmZlcmVudCBsaW51eA0KbGliYyBpbXBs
ZW1lbnRhdGlvbnMuDQo=
