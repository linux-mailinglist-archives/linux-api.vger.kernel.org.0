Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 201BC1BD6F1
	for <lists+linux-api@lfdr.de>; Wed, 29 Apr 2020 10:16:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726457AbgD2IQ3 (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 29 Apr 2020 04:16:29 -0400
Received: from mail-db8eur05on2065.outbound.protection.outlook.com ([40.107.20.65]:9913
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726355AbgD2IQ2 (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Wed, 29 Apr 2020 04:16:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DEYw/FvkvaF9x55bKMaau52XVLFZl/l/eKZ5JpN0/Uw=;
 b=VZbBl2kEHbAUrqemI+irfJhaPyXjXuDFCJmyH18zF8gAGtf/agKUI5H9LYTSMIt2ff+zdPBqJioEaVOv6AwMfvJRljwclW5GSA0/mq43ulu2inuC6GxsB/6ygFaig4XI7NOUoIJdcKgOycJmkgtxzr6NpSzDQ4Vbo9oyOfTXLAY=
Received: from DB6PR0801CA0049.eurprd08.prod.outlook.com (2603:10a6:4:2b::17)
 by AM0PR08MB3172.eurprd08.prod.outlook.com (2603:10a6:208:66::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2958.19; Wed, 29 Apr
 2020 08:16:24 +0000
Received: from DB5EUR03FT012.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:4:2b:cafe::81) by DB6PR0801CA0049.outlook.office365.com
 (2603:10a6:4:2b::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2958.19 via Frontend
 Transport; Wed, 29 Apr 2020 08:16:24 +0000
Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=bestguesspass
 action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 DB5EUR03FT012.mail.protection.outlook.com (10.152.20.161) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2958.20 via Frontend Transport; Wed, 29 Apr 2020 08:16:24 +0000
Received: ("Tessian outbound 11763d234d54:v54"); Wed, 29 Apr 2020 08:16:24 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 834b98ff6f11995f
X-CR-MTA-TID: 64aa7808
Received: from 45034ea1a3a1.1
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id 4B8EAB9D-89E2-463F-82CA-63A0EBE4E29B.1;
        Wed, 29 Apr 2020 08:16:18 +0000
Received: from EUR01-HE1-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id 45034ea1a3a1.1
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Wed, 29 Apr 2020 08:16:18 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BwvAi7mqBGmgIyz4ZJxueQUu3Wi32KIZ4+Sj5LpV7zfTJo6leKcmrnib9T2jeLvZyGrYKr/jDQi0hmTUacFUW+VLjVZ491nzMkjR4jI1pwmhsBvOfjwbGDGjenSP3fIBX+E9vUXpX1w0M2aDjHAdT1emBLiPqmWrGKl0k/TpOnKyp32E/bUzfXtl8bZSFvySoCaWzP0PlTtWv+tQfxIpb+eVuEvURpU8pnAq5ZRLU8Di2T9Hwv2WloUaqVhJU7u11Me+r2/Li/y/QYSN3ybLgtgqp8dMwhbfD7ClYUko5PbVwObmsG0D1Ku+gPM5FSlMZyYsThBueHEv39dp7WbBmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DEYw/FvkvaF9x55bKMaau52XVLFZl/l/eKZ5JpN0/Uw=;
 b=GLzfIsBxtCYzS1Kpiya+XSVot0yeH8XgxkHq7TREChWljZ7qtZyqo2Ai0DmzdkwSQP3GLGEZtRjwaqkh04jfop1WzePJGywzySFsbbjvWBfdI6bRi+s1ajQf1bHuW7WQ+uOALXlBoa4BQ0GS1JBoeIHEERsrpIunAbcPVKp+nCl+beqev3V/TEf77+ey0HnJfS7N5v3yOuKJhOJuS8F83evfHg5pWFpE1Y7qkp0OF6qHWg9fLmfxHLqbujKOdmjN0AOnCF7oc4FR7LzQ/J+nwj/9+6cgf9QRiAIj7EV69t9++Flo5yCBNyaSXRFZ+mLleEwmzsGK1V3i3oMWDb5ZHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DEYw/FvkvaF9x55bKMaau52XVLFZl/l/eKZ5JpN0/Uw=;
 b=VZbBl2kEHbAUrqemI+irfJhaPyXjXuDFCJmyH18zF8gAGtf/agKUI5H9LYTSMIt2ff+zdPBqJioEaVOv6AwMfvJRljwclW5GSA0/mq43ulu2inuC6GxsB/6ygFaig4XI7NOUoIJdcKgOycJmkgtxzr6NpSzDQ4Vbo9oyOfTXLAY=
Authentication-Results-Original: spf=none (sender IP is )
 smtp.mailfrom=Szabolcs.Nagy@arm.com; 
Received: from AM6PR08MB3047.eurprd08.prod.outlook.com (2603:10a6:209:4c::23)
 by AM6PR08MB2982.eurprd08.prod.outlook.com (2603:10a6:209:43::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2958.20; Wed, 29 Apr
 2020 08:16:12 +0000
Received: from AM6PR08MB3047.eurprd08.prod.outlook.com
 ([fe80::49fd:6ded:4da7:8862]) by AM6PR08MB3047.eurprd08.prod.outlook.com
 ([fe80::49fd:6ded:4da7:8862%7]) with mapi id 15.20.2958.019; Wed, 29 Apr 2020
 08:16:12 +0000
Date:   Wed, 29 Apr 2020 09:16:09 +0100
From:   Szabolcs Nagy <szabolcs.nagy@arm.com>
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc:     Florian Weimer <fw@deneb.enyo.de>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        libc-alpha <libc-alpha@sourceware.org>,
        carlos <carlos@redhat.com>, Rich Felker <dalias@libc.org>,
        linux-api <linux-api@vger.kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Will Deacon <will.deacon@arm.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ben Maurer <bmaurer@fb.com>, Dave Watson <davejwatson@fb.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Paul <paulmck@linux.vnet.ibm.com>, Paul Turner <pjt@google.com>,
        Joseph Myers <joseph@codesourcery.com>
Subject: Re: [PATCH glibc 5/9] glibc: Perform rseq(2) registration at C
 startup and thread creation (v17)
Message-ID: <20200429081606.GP29015@arm.com>
References: <20200326155633.18236-1-mathieu.desnoyers@efficios.com>
 <87zhawvphv.fsf@mid.deneb.enyo.de>
 <2102127737.70791.1588008377292.JavaMail.zimbra@efficios.com>
 <87ftcnrf7d.fsf@mid.deneb.enyo.de>
 <1080028389.72414.1588077193438.JavaMail.zimbra@efficios.com>
 <878sifrdo0.fsf@mid.deneb.enyo.de>
 <190402462.72430.1588077816717.JavaMail.zimbra@efficios.com>
 <87tv13py8j.fsf@mid.deneb.enyo.de>
 <437249723.72685.1588085899422.JavaMail.zimbra@efficios.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <437249723.72685.1588085899422.JavaMail.zimbra@efficios.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: LO2P265CA0261.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:8a::33) To AM6PR08MB3047.eurprd08.prod.outlook.com
 (2603:10a6:209:4c::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from arm.com (217.140.106.55) by LO2P265CA0261.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:8a::33) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.13 via Frontend Transport; Wed, 29 Apr 2020 08:16:11 +0000
X-Originating-IP: [217.140.106.55]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: daec9c9b-3f6a-46ec-7265-08d7ec159b6a
X-MS-TrafficTypeDiagnostic: AM6PR08MB2982:|AM0PR08MB3172:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM0PR08MB317293E40228771D1BBDFD01EDAD0@AM0PR08MB3172.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Oob-TLC-OOBClassifiers: OLM:337;OLM:337;
X-Forefront-PRVS: 03883BD916
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR08MB3047.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(136003)(366004)(376002)(346002)(396003)(39850400004)(5660300002)(44832011)(26005)(66556008)(6916009)(66946007)(66476007)(478600001)(53546011)(8886007)(4744005)(52116002)(7696005)(4326008)(956004)(2616005)(2906002)(36756003)(33656002)(186003)(1076003)(16526019)(7416002)(86362001)(55016002)(54906003)(81156014)(8936002)(316002)(8676002);DIR:OUT;SFP:1101;
Received-SPF: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: 1YEVCqZHE8U8A7jzkQVbgyMHW8LV1Khbkuxu3IXVrN0gpv/LYbA6y7wKWKvRlrrguKQthFXdZwTGc9kE52mAzFS6uo5o2tUmApbkH5Ysa8a0bnKa1a0Kot+g1GK/cvN2eN7W14llQZUWMyWhFUKmtBoSNDRRWtGfj2XoqglOuALlKxltj1ZOByaIUTwgAtISc0+sMQGCHdBdmbXV3ccQQRjmNwWKk5g4q43fGrgKxpBvu2lmMTT+9AOXB7BPcTOHaw4sz3HsBcZr1U9Yeex4TpBDgsRcGyO3SpRkmhiS4hT8UBGsaTF/s0LmtsNIzdEq0GBOM4ZXo/u+w4UaH7HsaoUflCnAaypbVOFW/+Zd6z6ZVlGJAsaL6ulr7UsLzVG/iF/1bmhz3Rf7Fiw9au6Wj+DJCQHfVerArTh0xQtvn1vM8m2TLkNM63hjqPC13zBp
X-MS-Exchange-AntiSpam-MessageData: S5QKZItXyVR/c5a6KJa6LqgT6dkq4k9kBXmzWHoIVXaS+keArb8t63dtGYYm2RjZIH642CKuxbZEaRs3zoPC+oxhv2I/0paH9H5bOJMkroCKuWkICx0urgGc9BmLXY0eTycYcj1uAkXJHOLFwe7A0zGHhZKTQPI7oj1hQivpsPPQEZpLQ92Lxw89fZ/4i5yNYD0vjFJn4iTAN1Le1dKHSKivqlrNDZJcJyQxsSPc3RMcDc9vEf7Tp6AEgJZjYQUJfB5K4M/GmC33roZ0Hr4U/NIffeNsehsiHUTi8X+f4ZFebbbjops3TKwrbYucSJz2343qwgmKpBctYTsynmI2RcQaB7WpzqoGvEWRbzIzs3WXNukTl37in0irmtjUcT1I3zlFVTHHVaIGpTdQm2Uk1agJZgYf6LP/vZZstC7RdJtzSMLL2UcRZ91kevA/w1utTW1q0/DAzsebNNJ9jPLbGPUzt8WLy+JOBlufT5UUfBD9JBcOpzvOgTgq7oeV0OdxIm3y43cjRYz1DCsvyZTw3dzidgRz4T1BoYnm9ZxrdegonrcjJsF4MVRGvgTL/vktamUKmE7jonLXNijpkDgIoSYQTzRp/p+QWA5TTILLex8eFU0iIJxXBg7wDU0NmRyF7ZFmDltimhpFl1p0hvRC+LdWEZgwh2syoK3v7pOVnQY6wPP3O1Iff6oFSQBWBQdlHK9b5kshtDHmD4LPiWU6fCNnyaTzTITRK7MYZmOeOdTDdJpyU8duWTK5fa9byiDsA5O6C5xXQlYSaB2xJnkNr0cfm4B34irfkZ6ifWY50Ek=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB2982
Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Szabolcs.Nagy@arm.com; 
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DB5EUR03FT012.eop-EUR03.prod.protection.outlook.com
X-Forefront-Antispam-Report: CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFTY:;SFS:(4636009)(346002)(396003)(136003)(39850400004)(376002)(46966005)(4326008)(478600001)(336012)(55016002)(44832011)(956004)(2906002)(2616005)(8936002)(8886007)(47076004)(450100002)(1076003)(7696005)(4744005)(8676002)(6862004)(86362001)(5660300002)(186003)(356005)(33656002)(316002)(82740400003)(16526019)(53546011)(70586007)(26005)(107886003)(82310400002)(81166007)(70206006)(36756003)(54906003);DIR:OUT;SFP:1101;
X-MS-Office365-Filtering-Correlation-Id-Prvs: d6ebbe10-6d77-4b40-543c-08d7ec1593f0
X-Forefront-PRVS: 03883BD916
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uoQKP7aUGPduif68m8QvG0Map9N0Ab/9WJJdahYEbKMr+tyH8hTlVpUh5K4TLOpn3wq8uZdVv1YIxOLo/LKvCSG2U4VXYR0rUPN8/kr4nS4xCUhwK/o13hV0TOHaNY0wU1TzED1NO+w7Olra38nCcFduwIG9aFo0M2cWximQP30mss8v4t2sRL0uyUJsUop6k0E6YZTBw20+8DUEGakogAsLeI+B8n4jmTpZ6bhJ/+ZMKVEJmOQ5bWZP3YvtKtnan0AFStf4RgBKL0SjQeV/21dTrDcl8EQakxC5KotGR1MdV9D4MynpZjHtSDazOXsykW7NIfAGQj6yxYf6k86LPTHK+W660P5EHlCIQBrf47cYLLa8CqdY0c+ZZicwdFI/NkmxoWizJshyCatnmWKKDnHrypXfEu/hW2epP+c8aEm1lkHBpKtxkZklmEO6LGzZkUMOuhhGq/IlXYajUIIlvFw9eE4b8v+0VijowLlFDMRx6zUAtD/HynWzjpJaEaykvsPLZrcKtS8fa3G9SswhYA==
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2020 08:16:24.1997
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: daec9c9b-3f6a-46ec-7265-08d7ec159b6a
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB3172
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

The 04/28/2020 10:58, Mathieu Desnoyers wrote:
> ----- On Apr 28, 2020, at 8:54 AM, Florian Weimer fw@deneb.enyo.de wrote:
> > That one definitely should work.
> > 
> > I expect you might see this if libgcc_s.so.1 is installed into a
> > multiarch subdirectory that upstream glibc does not search.  (The
> > Debian patches are unfortunately not upstream.)
> 
> My test environment is a Ubuntu 18.04.1 LTS.
> 
> > 
> > I think on my system, the built glibc can find the system libgcc_s via
> > /etc/ld.so.cache, so I haven't seen this issue yet.
> 
> On my system, libgcc_s is provided here:
> 
> /lib/x86_64-linux-gnu/libgcc_s.so.1
> 
> by this package:
> 
> Package: libgcc1
> Architecture: amd64
> Version: 1:8.4.0-1ubuntu1~18.04

before running the tests

cp `$CC --print-file-name libgcc_s.so.1` glibc/build/dir
cp `$CC --print-file-name libstdc++.so.6` glibc/build/dir

so those toolchain libs are in the search path
of the newly built libc when running tests.
